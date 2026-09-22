-- Title: 3-4 DB 집합과 조인 : INTERSECT로 실제 주문이 발생한 등록 상품 찾기
-- Description: 상품 운영자가 등록된 상품 중 주문이 발생한 상품을 확인하려고 한다. 등록 상품 ID 목록과 주문상품 ID 목록 양쪽에 공통으로 존재하는 ID만 조회한다. 주문 횟수나 인기 순위를 계산하는 쿼리는 아니다.
-- 실행 위치: Supabase SQL Editor
-- 설명: INTERSECT는 교집합이며 결과의 중복도 제거한다. 현재 예제는 deleted_at이 NULL인 상품과 주문상품 기록을 기준으로 한다.

SELECT id AS 상품ID
FROM products
WHERE deleted_at IS NULL

INTERSECT

SELECT product_id AS 상품ID
FROM order_items
WHERE deleted_at IS NULL
ORDER BY 상품ID;
