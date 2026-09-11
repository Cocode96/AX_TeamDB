-- 제목: 02 JOIN - 주문번호와 상품 상세
-- 실행 위치: Supabase SQL Editor
-- 목적: 주문과 주문상품, 상품을 연결한 상세 목록

SELECT o.order_no, o.order_status, p.name,
       oi.quantity, oi.item_price * oi.quantity AS item_total
FROM orders o
JOIN order_items oi ON oi.order_id = o.id
LEFT JOIN products p ON p.id = oi.product_id
WHERE o.deleted_at IS NULL AND oi.deleted_at IS NULL;
