-- 제목: 08 서브쿼리 IN - 주문된 상품
-- 실행 위치: Supabase SQL Editor
-- 목적: 상품 ID가 주문상품 조회 결과에 포함되는지 검사

SELECT name, price FROM products
WHERE deleted_at IS NULL
  AND id IN (SELECT product_id FROM order_items WHERE deleted_at IS NULL);
