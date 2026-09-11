-- 제목: 06 EXCEPT - 주문되지 않은 등록 상품
-- 실행 위치: Supabase SQL Editor
-- 목적: 등록 상품 중 주문상품 기록에 없는 상품 ID

SELECT id FROM products WHERE deleted_at IS NULL
EXCEPT
SELECT product_id FROM order_items WHERE deleted_at IS NULL;
