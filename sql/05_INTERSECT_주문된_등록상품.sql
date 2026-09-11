-- 제목: 05 INTERSECT - 주문된 등록 상품
-- 실행 위치: Supabase SQL Editor
-- 목적: 등록 상품과 주문상품 기록에 모두 있는 상품 ID

SELECT id FROM products WHERE deleted_at IS NULL
INTERSECT
SELECT product_id FROM order_items WHERE deleted_at IS NULL;
