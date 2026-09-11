-- Title: 5-1 DB 트랜잭션과 ACID : 배송완료 변경을 확인하고 ROLLBACK으로 취소하기
-- Description: 주문 관리자가 배송완료 상태로 변경하려다가 아직 완료 처리하면 안 된다는 것을 확인한 상황이다. BEGIN으로 시작해 상태를 변경하고 ROLLBACK으로 확정 전 변경을 취소한다. 전체 SQL을 한 번에 실행한다. 이미 COMMIT한 작업을 되돌리는 예제는 아니다.
-- 실행 위치: Supabase SQL Editor
-- 설명: SQL 파일에는 이전 시연 주문 ID가 들어 있다. 새 주문을 만들었다면 노트북의 바로 위 셀이 출력하는 최신 주문 ID가 포함된 SQL을 복사한다. 편집기에서 마지막 결과만 보일 수 있다. 별도 SDK 요청 두 개가 자동으로 하나의 트랜잭션이 되지는 않는다.

BEGIN;

UPDATE orders
SET order_status = 'DELIVERED'
WHERE id = 'b9f02be1-d673-4903-a182-c987925ccc23';

SELECT id, order_status
FROM orders
WHERE id = 'b9f02be1-d673-4903-a182-c987925ccc23';

ROLLBACK;

SELECT id, order_status
FROM orders
WHERE id = 'b9f02be1-d673-4903-a182-c987925ccc23';
