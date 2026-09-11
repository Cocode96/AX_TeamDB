-- Title: 4-2 DB 서브쿼리 : IN으로 주문 발생 상품의 현재 가격 조회하기
-- Description: 상품 운영자가 주문이 발생한 상품의 현재 판매 가격을 확인하려고 한다. 주문상품에서 상품 ID 목록을 구한 뒤 그 목록에 포함된 상품의 이름과 가격을 조회한다. 조회되는 가격은 현재 가격이며 주문 당시 단가는 아니다.
-- 실행 위치: Supabase SQL Editor
-- 설명: 안쪽 SELECT는 여러 행을 반환할 수 있다. 같은 ID가 여러 번 있어도 바깥 상품이 그 횟수만큼 복제되지는 않는다. 위 Python 코드는 의미 설명용이고 아래 SQL이 실제 서브쿼리다.

SELECT name AS 상품명, price AS 현재가격
FROM products
WHERE deleted_at IS NULL
  AND id IN (
      SELECT product_id
      FROM order_items
      WHERE deleted_at IS NULL
  )
ORDER BY price DESC;
