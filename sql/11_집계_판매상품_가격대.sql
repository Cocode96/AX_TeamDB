-- Title: 2-1 DB 집계함수 : AVG로 판매 상품의 평균 가격 확인하기
-- Description: 상품 운영자가 현재 판매 상품의 전반적인 가격대를 파악하려고 한다. 상품 수, 평균, 최저, 최고 가격을 함께 조회해 신규 상품 가격을 검토할 때 참고한다. 삭제 처리된 상품은 제외하며 가격이 NULL인 행은 가격 집계에서 제외한다.
-- 실행 위치: Supabase SQL Editor
-- 설명: COUNT(*)는 모든 상품 행을 센다. COUNT(price)는 가격이 있는 상품만 센다. AVG는 평균, MIN과 MAX는 최저와 최고다. ROUND(..., 2)는 소수 둘째 자리까지 표시한다.

SELECT
    COUNT(*) AS 등록상품수,
    COUNT(price) AS 가격등록상품수,
    ROUND(AVG(price), 2) AS 평균가격,
    MIN(price) AS 최저가격,
    MAX(price) AS 최고가격
FROM products
WHERE deleted_at IS NULL;
