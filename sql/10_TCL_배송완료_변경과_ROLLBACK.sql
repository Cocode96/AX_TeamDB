-- 제목: 10 TCL - 배송완료 변경과 ROLLBACK
-- 실행 위치: Supabase SQL Editor
-- 목적: 이번 주문의 상태를 바꿨다가 취소하여 원래 상태 확인
-- 대상: ex.ipynb의 최근 실제 시연 주문 ID가 들어 있습니다.
-- 새 주문으로 시연하려면 아래 세 군데의 주문 ID를 같은 새 ID로 바꾸세요.
-- BEGIN부터 마지막 SELECT까지 전체를 함께 실행합니다. ROLLBACK으로 변경이 취소됩니다.

BEGIN;
UPDATE orders SET order_status = 'DELIVERED' WHERE id = 'b9f02be1-d673-4903-a182-c987925ccc23';
SELECT id, order_status FROM orders WHERE id = 'b9f02be1-d673-4903-a182-c987925ccc23';
ROLLBACK;
SELECT id, order_status FROM orders WHERE id = 'b9f02be1-d673-4903-a182-c987925ccc23';
