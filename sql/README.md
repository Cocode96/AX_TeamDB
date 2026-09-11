# TeamDB 발표 SQL 모음

현재 ex.ipynb에 있는 SQL, 그 안에서 설명한 집합 연산 4가지, 실제 출력된 TCL SQL을 각각 저장했다. 대시보드의 전체 실행 이력을 추출한 목록은 아니다. Python SDK가 내부에서 수행하는 모든 SQL이나 아직 확인하지 못한 팀원의 트리거/테이블 생성 쿼리는 포함하지 않는다.

## Supabase에서 제목을 정하고 저장하기

1. 새 쿼리는 SQL Editor의 + 버튼으로 연다.
2. 사용할 .sql 파일의 내용을 전체 복사해 붙여 넣는다.
3. 왼쪽 PRIVATE의 Untitled query를 우클릭하고 **Rename query**를 선택한다.
4. 아래 제목을 입력하고 Rename query로 적용한다.
5. **Save 또는 Ctrl+S**로 내용을 저장한다. 제목 변경 뒤 자동 저장됐더라도 변경 내용이 남아 있지 않은지 확인한다.

Run은 실행이고 Save는 저장이다. 쿼리를 정리하기 위해 실행할 필요는 없다. SQL 파일은 Supabase SQL Editor에서 사용하며 Python 셀에 붙여 넣지 않는다.

Supabase의 저장된 쿼리와 이 폴더의 파일은 별도 사본이며 자동 동기화되지 않는다. 둘 중 하나를 수정하면 다른 쪽에도 내용을 반영한다. PRIVATE는 개인 저장 목록이고 팀 공유 여부는 별도로 정한다.

## 제목 목록

| 파일 | Supabase에 붙일 제목 |
|---|---|
| [01_집계_주문상태별_건수와_금액.sql](01_집계_주문상태별_건수와_금액.sql) | 01 집계 - 주문 상태별 건수와 금액 |
| [02_JOIN_주문상품_상세.sql](02_JOIN_주문상품_상세.sql) | 02 JOIN - 주문번호와 상품 상세 |
| [03_UNION_상품ID_합집합.sql](03_UNION_상품ID_합집합.sql) | 03 UNION - 상품 ID 합집합 |
| [04_UNION_ALL_상품ID_중복유지.sql](04_UNION_ALL_상품ID_중복유지.sql) | 04 UNION ALL - 상품 ID 중복 유지 |
| [05_INTERSECT_주문된_등록상품.sql](05_INTERSECT_주문된_등록상품.sql) | 05 INTERSECT - 주문된 등록 상품 |
| [06_EXCEPT_주문되지_않은_등록상품.sql](06_EXCEPT_주문되지_않은_등록상품.sql) | 06 EXCEPT - 주문되지 않은 등록 상품 |
| [07_서브쿼리_평균보다_비싼_상품.sql](07_서브쿼리_평균보다_비싼_상품.sql) | 07 서브쿼리 AVG - 평균보다 비싼 상품 |
| [08_서브쿼리_IN_주문된_상품.sql](08_서브쿼리_IN_주문된_상품.sql) | 08 서브쿼리 IN - 주문된 상품 |
| [09_서브쿼리_EXISTS_주문기록_있는_상품.sql](09_서브쿼리_EXISTS_주문기록_있는_상품.sql) | 09 서브쿼리 EXISTS - 주문 기록이 있는 상품 |
| [10_TCL_배송완료_변경과_ROLLBACK.sql](10_TCL_배송완료_변경과_ROLLBACK.sql) | 10 TCL - 배송완료 변경과 ROLLBACK |

## 실행 전에 알아둘 내용

- 01~09는 조회 SQL이다. 빈 결과가 나와도 조건에 맞는 행이 없다는 의미일 수 있다.
- 10은 실제 시연 주문의 상태를 잠시 변경한 뒤 ROLLBACK으로 취소한다. BEGIN부터 마지막 SELECT까지 전체를 실행한다. 새로운 주문으로 시연할 때는 파일에 들어 있는 주문 ID 세 군데를 동일한 새 ID로 바꾼다.
- [products RLS 해제](settings/products_RLS_해제.sql)는 기존 설정 작업의 기록이다. 발표 조회 목록과 구분해 둔다.
- 회원가입 트리거 등 팀원이 SHARED에 저장한 쿼리는 원문을 확인한 후 별도 파일로 보관해야 한다. 실행 이력이 없는 SQL을 실행 완료한 것처럼 기록하지 않는다.

제목 변경 동작 참고: [Supabase 공식 SQL Editor 테스트](https://github.com/supabase/supabase/blob/master/e2e/studio/features/sql-editor.spec.ts).
