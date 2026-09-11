-- 제목: 03 UNION - 상품 ID 합집합
-- 실행 위치: Supabase SQL Editor
-- 목적: 등록 상품과 주문상품의 상품 ID를 합치고 중복 제거

SELECT id FROM products WHERE deleted_at IS NULL
UNION
SELECT product_id FROM order_items WHERE deleted_at IS NULL;
