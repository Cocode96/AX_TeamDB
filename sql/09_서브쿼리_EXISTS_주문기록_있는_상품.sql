-- Title: 4-3 DB 서브쿼리 : EXISTS로 판매자별 주문 발생 상품 확인하기
-- Description: 운영자가 어떤 판매자의 상품에서 주문이 발생했는지 확인하려고 한다. 상품마다 연결된 주문상품 기록이 하나라도 있는지 확인하고 해당 상품과 판매자 ID를 조회한다. 안쪽 쿼리가 바깥쪽 상품의 p.id를 참조하는 상관 서브쿼리다.
-- 실행 위치: Supabase SQL Editor
-- 설명: SELECT 1은 첫 번째 행이나 열이라는 뜻이 아니다. 상수 1을 선택하는 표현이며 EXISTS는 값보다 행의 존재 여부를 검사하므로 이렇게 쓰는 관례가 있다. 실제 DB 실행 계획이 Python 반복문과 같다고 단정하지 않는다.

SELECT p.seller_id AS 판매자ID, p.name AS 상품명
FROM products p
WHERE p.deleted_at IS NULL
  AND EXISTS (
      SELECT 1
      FROM order_items oi
      WHERE oi.product_id = p.id
        AND oi.deleted_at IS NULL
  )
ORDER BY p.seller_id, p.name;
