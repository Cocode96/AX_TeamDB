-- Title: 3-5 DB 집합과 조인 : EXCEPT로 주문 기록이 없는 판촉 검토 상품 찾기
-- Description: 상품 운영자가 상품 소개나 할인 행사를 검토할 대상을 찾으려고 한다. 등록 상품 목록에서 주문상품 기록에 있는 상품을 제외해 주문 기록이 없는 상품 ID를 찾는다. 삭제 처리된 주문상품 기록은 제외하므로 전체 과거 이력에서 한 번도 주문되지 않았다는 뜻은 아니다.
-- 실행 위치: Supabase SQL Editor
-- 설명: EXCEPT는 앞의 결과에서 뒤의 결과를 제외한다. 순서를 바꾸면 뜻이 달라진다. 빈 결과는 조회 대상 등록 상품이 모두 주문상품 기록에 있다는 뜻이다.

SELECT id AS 상품ID
FROM products
WHERE deleted_at IS NULL

EXCEPT

SELECT product_id AS 상품ID
FROM order_items
WHERE deleted_at IS NULL
ORDER BY 상품ID;
