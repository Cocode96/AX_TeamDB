-- Title: 3-3 DB 집합과 조인 : UNION ALL로 상품 ID 기록을 중복까지 확인하기
-- Description: 운영자가 등록 상품과 주문상품의 원래 행이 얼마나 반복되는지 대조하려고 한다. UNION ALL로 두 목록을 합치면 중복 ID를 제거하지 않는다. 같은 상품의 주문상품 기록이 여러 건이면 같은 ID가 반복된다. 결과 행 수는 구매 수량이나 주문 건수가 아니다.
-- 실행 위치: Supabase SQL Editor
-- 설명: UNION과 같은 SELECT를 사용하고 연산자만 UNION ALL로 바꿨다. quantity가 2여도 주문상품 행이 하나면 여기서는 한 행이다. 등록 상품 행도 함께 포함되므로 결과 행 수를 주문 수라고 부르면 안 된다.

SELECT id AS 상품ID
FROM products
WHERE deleted_at IS NULL

UNION ALL

SELECT product_id AS 상품ID
FROM order_items
WHERE deleted_at IS NULL
ORDER BY 상품ID;
