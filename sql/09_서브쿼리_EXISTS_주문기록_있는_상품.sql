-- 제목: 09 서브쿼리 EXISTS - 주문 기록이 있는 상품
-- 실행 위치: Supabase SQL Editor
-- 목적: 현재 상품과 연결된 주문상품의 존재 여부 검사

SELECT p.name FROM products p
WHERE p.deleted_at IS NULL
  AND EXISTS (
    SELECT 1 FROM order_items oi
    WHERE oi.product_id = p.id AND oi.deleted_at IS NULL
  );
