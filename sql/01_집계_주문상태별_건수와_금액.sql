-- 제목: 01 집계 - 주문 상태별 건수와 금액
-- 실행 위치: Supabase SQL Editor
-- 목적: 배송 상태별 주문 수, 합계, 평균, 최소, 최대 금액

SELECT order_status, COUNT(*) AS order_count,
       SUM(total_price) AS total_amount,
       ROUND(AVG(total_price), 2) AS average_amount,
       MIN(total_price) AS minimum_amount,
       MAX(total_price) AS maximum_amount
FROM orders
WHERE deleted_at IS NULL
GROUP BY order_status;
