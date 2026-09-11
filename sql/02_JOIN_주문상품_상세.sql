-- Title: 3-1 DB 집합과 조인 : JOIN으로 고객 문의용 주문 상세 조회하기
-- Description: 고객 문의에 답하기 위해 주문번호, 배송 상태, 구매 상품과 수량을 한 화면에서 확인하려고 한다. orders, order_items, products를 ID로 연결한다. 상품 정보는 변경될 수 있으므로 현재 상품명과 주문 당시 상품명을 구분하고 주문 당시 단가로 항목 금액을 계산한다.
-- 실행 위치: Supabase SQL Editor
-- 설명: o, oi, p는 테이블 별칭이다. JOIN은 주문상품이 연결된 주문을 조회한다. LEFT JOIN은 현재 상품을 연결하지 못해도 주문상품 행을 남긴다. order_items의 단가를 사용해야 현재 가격 변경이 과거 주문 금액에 영향을 주지 않는다.

SELECT
    o.order_no AS 주문번호,
    o.order_status AS 주문상태,
    oi.item_name AS 주문당시상품명,
    p.name AS 현재상품명,
    oi.quantity AS 구매수량,
    oi.item_price AS 주문당시단가,
    oi.item_price * oi.quantity AS 항목금액
FROM orders o
JOIN order_items oi ON oi.order_id = o.id
LEFT JOIN products p ON p.id = oi.product_id
WHERE o.deleted_at IS NULL
  AND oi.deleted_at IS NULL
ORDER BY o.created_at DESC;
