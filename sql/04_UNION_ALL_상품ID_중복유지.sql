-- 제목: 04 UNION ALL - 상품 ID 중복 유지
-- 실행 위치: Supabase SQL Editor
-- 목적: 두 조회 결과를 중복을 유지하며 합치기

SELECT id FROM products WHERE deleted_at IS NULL
UNION ALL
SELECT product_id FROM order_items WHERE deleted_at IS NULL;
