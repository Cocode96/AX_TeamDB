-- Title: 4-1 DB 서브쿼리 : 평균보다 비싼 상품을 찾아 가격 검토하기
-- Description: 상품 운영자가 현재 상품 중 상대적으로 가격이 높은 상품을 검토하려고 한다. 안쪽 쿼리에서 전체 평균 가격을 구하고 바깥쪽 쿼리에서 평균보다 비싼 상품만 조회한다. 평균보다 비싸다는 사실만으로 잘못된 가격이라고 판단하지 않는다.
-- 실행 위치: Supabase SQL Editor
-- 설명: AVG 결과는 값 하나이므로 스칼라 서브쿼리다. 바깥 행을 참조하지 않으므로 비상관 서브쿼리이기도 하다. 상품이 하나뿐이거나 가격이 모두 같으면 결과가 없는 것이 정상이다.

SELECT name AS 상품명, price AS 가격
FROM products
WHERE deleted_at IS NULL
  AND price > (
      SELECT AVG(price)
      FROM products
      WHERE deleted_at IS NULL
  )
ORDER BY price DESC;
