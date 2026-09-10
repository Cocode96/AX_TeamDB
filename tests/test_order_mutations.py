"""Validate notebook order mutations through the real SDK without a live DB."""

import ast
import copy
import json
from datetime import datetime, timedelta, timezone
from pathlib import Path
import unittest
from uuid import UUID

import httpx
from postgrest.exceptions import APIError
from supabase import create_client
from supabase.lib.client_options import SyncClientOptions


ROOT = Path(__file__).resolve().parents[1]
USER_ID = "00000000-0000-0000-0000-000000000001"
OTHER_USER_ID = "00000000-0000-0000-0000-000000000002"
ORDER_ID = "00000000-0000-0000-0000-000000000003"


def load_service():
    notebook = json.loads((ROOT / "orders.ipynb").read_text(encoding="utf-8"))
    namespace = {"datetime": datetime, "timezone": timezone}
    for cell in notebook["cells"]:
        if cell["cell_type"] != "code":
            continue
        tree = ast.parse("".join(cell["source"]))
        for node in tree.body:
            if isinstance(node, ast.ClassDef) and node.name == "Order_service":
                # Do not run notebook connection or database query cells.
                module = ast.Module(body=[node], type_ignores=[])
                exec(compile(module, "orders.ipynb", "exec"), namespace)
                return namespace["Order_service"]
    raise AssertionError("Order_service not found")


class OrderMutationTests(unittest.TestCase):
    def setUp(self):
        self.rows = [
            {"id": ORDER_ID, "user_id": USER_ID, "order_status": "READY",
             "deleted_at": None, "modified_at": None},
            {"id": "second-order", "user_id": USER_ID, "order_status": "READY",
             "deleted_at": None, "modified_at": None},
            {"id": "other-user-order", "user_id": OTHER_USER_ID,
             "order_status": "READY", "deleted_at": None, "modified_at": None},
            {"id": "deleted-order", "user_id": USER_ID, "order_status": "READY",
             "deleted_at": "2026-01-01T00:00:00+00:00", "modified_at": None},
        ]
        self.original = copy.deepcopy(self.rows)
        self.fail_request = False
        self.http = httpx.Client(transport=httpx.MockTransport(self.handle_request))
        self.addCleanup(self.http.close)
        client = create_client(
            "https://example.supabase.co", "test-key",
            options=SyncClientOptions(
                httpx_client=self.http, persist_session=False, auto_refresh_token=False,
            ),
        )
        self.service = load_service()(client)

    def handle_request(self, request):
        self.assertEqual(request.method, "PATCH")
        self.assertEqual(request.url.path, "/rest/v1/orders")
        if self.fail_request:
            return httpx.Response(403, json={
                "code": "42501", "message": "permission denied",
                "details": None, "hint": None,
            })
        selected = self.rows[:]
        for column, expression in request.url.params.multi_items():
            if expression.startswith("eq."):
                selected = [row for row in selected if str(row[column]) == expression[3:]]
            elif expression == "is.null":
                selected = [row for row in selected if row[column] is None]
            else:
                self.fail(f"Unexpected filter: {column}={expression}")
        values = json.loads(request.content)
        for row in selected:
            row.update(values)
        return httpx.Response(200, json=selected)

    def assert_recent_utc(self, value, before):
        parsed = datetime.fromisoformat(value)
        self.assertEqual(parsed.utcoffset(), timedelta(0))
        self.assertLessEqual(before, parsed)
        self.assertLessEqual(parsed, datetime.now(timezone.utc))

    def test_status_update_only_changes_target_status_and_timestamp(self):
        before = datetime.now(timezone.utc)
        result = self.service.update_order_status(USER_ID, ORDER_ID, "ORDER")
        self.assertEqual(result, [self.rows[0]])
        self.assertEqual(self.rows[0]["order_status"], "ORDER")
        self.assert_recent_utc(self.rows[0]["modified_at"], before)
        expected = {**self.original[0], "order_status": "ORDER",
                    "modified_at": self.rows[0]["modified_at"]}
        self.assertEqual(self.rows[0], expected)
        self.assertEqual(self.rows[1:], self.original[1:])

    def test_soft_delete_keeps_row_and_records_matching_timestamps(self):
        before = datetime.now(timezone.utc)
        result = self.service.delete_order(USER_ID, ORDER_ID)
        self.assertEqual(result, [self.rows[0]])
        self.assertEqual(len(self.rows), len(self.original))
        self.assertEqual(self.rows[0]["order_status"], "READY")
        self.assertEqual(self.rows[0]["deleted_at"], self.rows[0]["modified_at"])
        self.assert_recent_utc(self.rows[0]["deleted_at"], before)
        self.assertEqual(self.rows[1:], self.original[1:])

    def test_both_operations_ignore_wrong_owner_missing_and_deleted_orders(self):
        for user_id, order_id in [
            (OTHER_USER_ID, ORDER_ID), (USER_ID, "missing"), (USER_ID, "deleted-order"),
        ]:
            for operation in ["update_order_status", "delete_order"]:
                with self.subTest(operation=operation, user_id=user_id, order_id=order_id):
                    args = [user_id, order_id]
                    if operation == "update_order_status":
                        args.append("ORDER")
                    self.assertEqual(getattr(self.service, operation)(*args), [])
                    self.assertEqual(self.rows, self.original)

    def test_deleted_order_cannot_be_updated_or_deleted_again(self):
        self.service.delete_order(USER_ID, ORDER_ID)
        deleted = copy.deepcopy(self.rows)
        self.assertEqual(self.service.delete_order(USER_ID, ORDER_ID), [])
        self.assertEqual(self.service.update_order_status(USER_ID, ORDER_ID, "ORDER"), [])
        self.assertEqual(self.rows, deleted)

    def test_uuid_objects_are_supported(self):
        result = self.service.update_order_status(UUID(USER_ID), UUID(ORDER_ID), "ORDER")
        self.assertEqual(result[0]["order_status"], "ORDER")
        result = self.service.delete_order(UUID(USER_ID), UUID(ORDER_ID))
        self.assertIsNotNone(result[0]["deleted_at"])

    def test_database_errors_propagate_for_both_operations(self):
        self.fail_request = True
        with self.assertRaises(APIError):
            self.service.update_order_status(USER_ID, ORDER_ID, "ORDER")
        with self.assertRaises(APIError):
            self.service.delete_order(USER_ID, ORDER_ID)
        self.assertEqual(self.rows, self.original)


if __name__ == "__main__":
    unittest.main()
