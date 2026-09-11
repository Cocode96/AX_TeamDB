-- 제목: 07 서브쿼리 AVG - 평균보다 비싼 상품
-- 실행 위치: Supabase SQL Editor
-- 목적: 평균값 하나를 조건으로 사용하는 스칼라 서브쿼리

SELECT name, price FROM products
WHERE deleted_at IS NULL
  AND price > (SELECT AVG(price) FROM products WHERE deleted_at IS NULL);
