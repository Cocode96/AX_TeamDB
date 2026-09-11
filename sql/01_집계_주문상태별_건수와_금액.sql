-- Title: 2-2 DB 집계함수 : COUNT와 SUM으로 주문 상태별 처리 현황 확인하기
-- Description: 주문 관리자가 접수, 배송 중, 배송완료 상태에 주문이 몇 건씩 있는지 확인하려고 한다. 상태별 건수와 주문 금액을 집계해 처리할 주문이 어느 단계에 쌓였는지 파악한다. 결제 완료를 확인한 금액은 아니므로 확정 매출로 해석하지 않는다.
-- 실행 위치: Supabase SQL Editor
-- 설명: GROUP BY는 같은 상태끼리 묶는다. COUNT(*)는 주문 건수, SUM은 합계, AVG는 평균이다. 금액 집계는 NULL을 제외하지만 COUNT(*)는 금액이 없는 주문도 센다.

SELECT
    order_status AS 주문상태,
    COUNT(*) AS 주문건수,
    SUM(total_price) AS 주문금액합계,
    ROUND(AVG(total_price), 2) AS 평균주문금액,
    MIN(total_price) AS 최소주문금액,
    MAX(total_price) AS 최대주문금액
FROM orders
WHERE deleted_at IS NULL
GROUP BY order_status
ORDER BY 주문건수 DESC;
