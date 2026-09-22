-- Title: 3-2 DB 집합과 조인 : UNION으로 상품 현황 대조용 ID 목록 합치기
-- Description: 운영자가 상품 목록과 주문상품 기록을 대조할 기준 목록을 만들려고 한다. 등록 상품 ID와 주문상품에 기록된 상품 ID를 합치고 중복을 제거한다. 두 목록에서 같은 상품이 여러 번 나와도 결과에는 한 번만 표시한다.
-- 실행 위치: Supabase SQL Editor
-- 설명: 양쪽 SELECT의 열 개수와 자료형이 맞아야 한다. 여기서는 UUID 상품 ID 한 열씩 비교한다. 모든 주문상품 ID가 현재 등록 상품에 포함되어 있으면 결과는 등록 상품 목록과 같을 수 있다.

SELECT id AS 상품ID
FROM products
WHERE deleted_at IS NULL

UNION

SELECT product_id AS 상품ID
FROM order_items
WHERE deleted_at IS NULL
ORDER BY 상품ID;
