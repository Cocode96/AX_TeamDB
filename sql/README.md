# TeamDB 발표 SQL과 실행 순서

`ex.ipynb`로 발표한다. 별도 .py 실행은 필요하지 않다. SQL은 Supabase SQL Editor에서 실행하고, Python 셀에 붙여 넣지 않는다.

먼저 노트북에서 `AuthUsers.sign_in()`으로 로그인하고 `get_my_info()`로 본인 정보를 확인한다. `UserService.get_active_users()`로 활성 회원 상세정보 수를 확인한 뒤 주문 실습을 진행한다. Python 코드 셀은 16개이며 마지막 셀에서 로그아웃한다.

## 발표 주제 6가지

| 발표 항목 | 보여줄 자료와 실행 위치 |
|---|---|
| 1. 테이블 관계 표현 | ex.ipynb의 관계도. orders → order_items ← products를 설명한다. |
| 2. 데이터 집계함수 | SQL Editor에서 2-1 평균 가격, 2-2 주문 상태별 현황 실행 |
| 3. 집합과 조인 | SQL Editor에서 3-1 JOIN, 3-2 UNION, 3-3 UNION ALL, 3-4 INTERSECT, 3-5 EXCEPT 실행 |
| 4. 서브쿼리 유형 | 노트북의 Python 비교 예제와 SQL Editor의 4-1 AVG, 4-2 IN, 4-3 EXISTS |
| 5. 트랜잭션(TCL)과 ACID 원칙 | 노트북에서 최신 주문 ID가 든 SQL을 출력하고 SQL Editor에서 전체 실행 |
| 6. SDK, 랭체인 | 노트북에서 query is same_query와 execute() 실행. self 반환 체이닝과 LangChain 라이브러리는 구분한다. |

## Supabase에 저장하기

현재 이 파일과 .sql 파일은 로컬 사본이다. Supabase 저장 완료를 뜻하지 않는다. SQL 파일을 수정해도 Supabase에 자동 저장되지는 않는다.

1. SQL Editor의 + 버튼으로 새 쿼리를 연다.
2. 아래 원하는 항목의 SQL 전체를 복사한다. Title과 Description도 SQL 주석에 포함되어 있으므로 내용만 복사해도 설명이 보존된다.
3. Save 또는 Ctrl+S로 저장한다. 제목과 설명 입력 화면이 나오면 아래 Title과 Description을 각각 붙인다.
4. 저장된 제목을 바꾸려면 왼쪽 PRIVATE의 해당 쿼리를 우클릭하고 Rename query를 사용한다.
5. Run은 SQL 실행이고 Save는 쿼리 저장이다. 기존 SHARED의 팀원 쿼리는 수정할 필요가 없다.

로컬 SQL 파일과 Supabase 저장 쿼리는 자동 동기화되지 않는다.

## 개별 SQL 파일

| Title | 파일 |
|---|---|
| 2-1 DB 집계함수 : AVG로 판매 상품의 평균 가격 확인하기 | [11_집계_판매상품_가격대.sql](11_집계_판매상품_가격대.sql) |
| 2-2 DB 집계함수 : COUNT와 SUM으로 주문 상태별 처리 현황 확인하기 | [01_집계_주문상태별_건수와_금액.sql](01_집계_주문상태별_건수와_금액.sql) |
| 3-1 DB 집합과 조인 : JOIN으로 고객 문의용 주문 상세 조회하기 | [02_JOIN_주문상품_상세.sql](02_JOIN_주문상품_상세.sql) |
| 3-2 DB 집합과 조인 : UNION으로 상품 현황 대조용 ID 목록 합치기 | [03_UNION_상품ID_합집합.sql](03_UNION_상품ID_합집합.sql) |
| 3-3 DB 집합과 조인 : UNION ALL로 상품 ID 기록을 중복까지 확인하기 | [04_UNION_ALL_상품ID_중복유지.sql](04_UNION_ALL_상품ID_중복유지.sql) |
| 3-4 DB 집합과 조인 : INTERSECT로 실제 주문이 발생한 등록 상품 찾기 | [05_INTERSECT_주문된_등록상품.sql](05_INTERSECT_주문된_등록상품.sql) |
| 3-5 DB 집합과 조인 : EXCEPT로 주문 기록이 없는 판촉 검토 상품 찾기 | [06_EXCEPT_주문되지_않은_등록상품.sql](06_EXCEPT_주문되지_않은_등록상품.sql) |
| 4-1 DB 서브쿼리 : 평균보다 비싼 상품을 찾아 가격 검토하기 | [07_서브쿼리_평균보다_비싼_상품.sql](07_서브쿼리_평균보다_비싼_상품.sql) |
| 4-2 DB 서브쿼리 : IN으로 주문 발생 상품의 현재 가격 조회하기 | [08_서브쿼리_IN_주문된_상품.sql](08_서브쿼리_IN_주문된_상품.sql) |
| 4-3 DB 서브쿼리 : EXISTS로 판매자별 주문 발생 상품 확인하기 | [09_서브쿼리_EXISTS_주문기록_있는_상품.sql](09_서브쿼리_EXISTS_주문기록_있는_상품.sql) |
| 5-1 DB 트랜잭션과 ACID : 배송완료 변경을 확인하고 ROLLBACK으로 취소하기 | [10_TCL_배송완료_변경과_ROLLBACK.sql](10_TCL_배송완료_변경과_ROLLBACK.sql) |

## 1. 테이블 관계 표현

**제목:** DB 테이블 관계 : 한 회원의 주문에 여러 상품을 담는 구조

**설명:** orders는 주문 전체 정보, order_items는 주문에 담긴 상품과 수량, products는 현재 상품 정보를 저장한다. 주문상품의 order_id와 product_id가 주문과 상품을 연결한다. 회원 한 명의 여러 주문과 주문 하나의 여러 상품을 사진으로 설명한다. 관계도는 노트북에 포함되어 있다.

**발표할 말:** “주문 하나에 여러 상품을 담기 위해 주문과 주문상품을 나눴습니다. 주문상품 테이블이 두 ID로 주문과 상품을 연결합니다.”

## 2. 데이터 집계함수

### 2-1 DB 집계함수 : AVG로 판매 상품의 평균 가격 확인하기

**Title**
```text
2-1 DB 집계함수 : AVG로 판매 상품의 평균 가격 확인하기
```

**Description / 조회 이유**
```text
상품 운영자가 현재 판매 상품의 전반적인 가격대를 파악하려고 한다. 상품 수, 평균, 최저, 최고 가격을 함께 조회해 신규 상품 가격을 검토할 때 참고한다. 삭제 처리된 상품은 제외하며 가격이 NULL인 행은 가격 집계에서 제외한다.
```

**SQL — Supabase SQL Editor에서 실행**
```sql
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
```

**발표할 말**

> 상품 가격대를 파악하려고 평균을 구했습니다. 평균만으로는 차이를 알기 어려워 최저 가격과 최고 가격도 함께 확인합니다.

**설명**

COUNT(*)는 모든 상품 행을 센다. COUNT(price)는 가격이 있는 상품만 센다. AVG는 평균, MIN과 MAX는 최저와 최고다. ROUND(..., 2)는 소수 둘째 자리까지 표시한다.

### 2-2 DB 집계함수 : COUNT와 SUM으로 주문 상태별 처리 현황 확인하기

**Title**
```text
2-2 DB 집계함수 : COUNT와 SUM으로 주문 상태별 처리 현황 확인하기
```

**Description / 조회 이유**
```text
주문 관리자가 접수, 배송 중, 배송완료 상태에 주문이 몇 건씩 있는지 확인하려고 한다. 상태별 건수와 주문 금액을 집계해 처리할 주문이 어느 단계에 쌓였는지 파악한다. 결제 완료를 확인한 금액은 아니므로 확정 매출로 해석하지 않는다.
```

**SQL — Supabase SQL Editor에서 실행**
```sql
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
```

**발표할 말**

> 주문을 상태별로 묶으면 어느 단계에 주문이 많이 쌓였는지 볼 수 있습니다. 건수와 금액을 함께 집계했습니다.

**설명**

GROUP BY는 같은 상태끼리 묶는다. COUNT(*)는 주문 건수, SUM은 합계, AVG는 평균이다. 금액 집계는 NULL을 제외하지만 COUNT(*)는 금액이 없는 주문도 센다.

## 3. 집합과 조인

### 3-1 DB 집합과 조인 : JOIN으로 고객 문의용 주문 상세 조회하기

**Title**
```text
3-1 DB 집합과 조인 : JOIN으로 고객 문의용 주문 상세 조회하기
```

**Description / 조회 이유**
```text
고객 문의에 답하기 위해 주문번호, 배송 상태, 구매 상품과 수량을 한 화면에서 확인하려고 한다. orders, order_items, products를 ID로 연결한다. 상품 정보는 변경될 수 있으므로 현재 상품명과 주문 당시 상품명을 구분하고 주문 당시 단가로 항목 금액을 계산한다.
```

**SQL — Supabase SQL Editor에서 실행**
```sql
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
```

**발표할 말**

> 고객 문의에 필요한 정보가 여러 테이블에 나뉘어 있습니다. ID로 연결해서 주문 상태와 상품, 수량을 함께 보여줍니다.

**설명**

o, oi, p는 테이블 별칭이다. JOIN은 주문상품이 연결된 주문을 조회한다. LEFT JOIN은 현재 상품을 연결하지 못해도 주문상품 행을 남긴다. order_items의 단가를 사용해야 현재 가격 변경이 과거 주문 금액에 영향을 주지 않는다.

### 3-2 DB 집합과 조인 : UNION으로 상품 현황 대조용 ID 목록 합치기

**Title**
```text
3-2 DB 집합과 조인 : UNION으로 상품 현황 대조용 ID 목록 합치기
```

**Description / 조회 이유**
```text
운영자가 상품 목록과 주문상품 기록을 대조할 기준 목록을 만들려고 한다. 등록 상품 ID와 주문상품에 기록된 상품 ID를 합치고 중복을 제거한다. 두 목록에서 같은 상품이 여러 번 나와도 결과에는 한 번만 표시한다.
```

**SQL — Supabase SQL Editor에서 실행**
```sql
-- Title: 3-2 DB 집합과 조인 : UNION으로 상품 현황 대조용 ID 목록 합치기
-- Description: 운영자가 상품 목록과 주문상품 기록을 대조할 기준 목록을 만들려고 한다. 등록 상품 ID와 주문상품에 기록된 상품 ID를 합치고 중복을 제거한다. 두 목록에서 같은 상품이 여러 번 나와도 결과에는 한 번만 표시한다.
-- 실행 위치: Supabase SQL Editor
-- 설명: 양쪽 SELECT의 열 개수와 자료형이 맞아야 한다. 여기서는 UUID 상품 ID 한 열씩 비교한다. 모든 주문상품 ID가 현재 등록 상품에 포함되어 있으면 결과는 등록 상품 목록과 같을 수 있다.

SELECT id AS 상품ID
FROM products
WHERE deleted_at IS NULL

UNION

SELECT product_id AS 상품ID
FROM order_items
WHERE deleted_at IS NULL
ORDER BY 상품ID;
```

**발표할 말**

> 등록 상품과 주문상품 기록에 있는 ID를 한 목록으로 모았습니다. UNION은 같은 상품 ID의 중복을 제거합니다.

**설명**

양쪽 SELECT의 열 개수와 자료형이 맞아야 한다. 여기서는 UUID 상품 ID 한 열씩 비교한다. 모든 주문상품 ID가 현재 등록 상품에 포함되어 있으면 결과는 등록 상품 목록과 같을 수 있다.

### 3-3 DB 집합과 조인 : UNION ALL로 상품 ID 기록을 중복까지 확인하기

**Title**
```text
3-3 DB 집합과 조인 : UNION ALL로 상품 ID 기록을 중복까지 확인하기
```

**Description / 조회 이유**
```text
운영자가 등록 상품과 주문상품의 원래 행이 얼마나 반복되는지 대조하려고 한다. UNION ALL로 두 목록을 합치면 중복 ID를 제거하지 않는다. 같은 상품의 주문상품 기록이 여러 건이면 같은 ID가 반복된다. 결과 행 수는 구매 수량이나 주문 건수가 아니다.
```

**SQL — Supabase SQL Editor에서 실행**
```sql
-- Title: 3-3 DB 집합과 조인 : UNION ALL로 상품 ID 기록을 중복까지 확인하기
-- Description: 운영자가 등록 상품과 주문상품의 원래 행이 얼마나 반복되는지 대조하려고 한다. UNION ALL로 두 목록을 합치면 중복 ID를 제거하지 않는다. 같은 상품의 주문상품 기록이 여러 건이면 같은 ID가 반복된다. 결과 행 수는 구매 수량이나 주문 건수가 아니다.
-- 실행 위치: Supabase SQL Editor
-- 설명: UNION과 같은 SELECT를 사용하고 연산자만 UNION ALL로 바꿨다. quantity가 2여도 주문상품 행이 하나면 여기서는 한 행이다. 등록 상품 행도 함께 포함되므로 결과 행 수를 주문 수라고 부르면 안 된다.

SELECT id AS 상품ID
FROM products
WHERE deleted_at IS NULL

UNION ALL

SELECT product_id AS 상품ID
FROM order_items
WHERE deleted_at IS NULL
ORDER BY 상품ID;
```

**발표할 말**

> 이번에는 중복을 유지했습니다. 같은 상품이 여러 주문상품 행에 있으면 그만큼 ID가 반복해서 나옵니다.

**설명**

UNION과 같은 SELECT를 사용하고 연산자만 UNION ALL로 바꿨다. quantity가 2여도 주문상품 행이 하나면 여기서는 한 행이다. 등록 상품 행도 함께 포함되므로 결과 행 수를 주문 수라고 부르면 안 된다.

### 3-4 DB 집합과 조인 : INTERSECT로 실제 주문이 발생한 등록 상품 찾기

**Title**
```text
3-4 DB 집합과 조인 : INTERSECT로 실제 주문이 발생한 등록 상품 찾기
```

**Description / 조회 이유**
```text
상품 운영자가 등록된 상품 중 주문이 발생한 상품을 확인하려고 한다. 등록 상품 ID 목록과 주문상품 ID 목록 양쪽에 공통으로 존재하는 ID만 조회한다. 주문 횟수나 인기 순위를 계산하는 쿼리는 아니다.
```

**SQL — Supabase SQL Editor에서 실행**
```sql
-- Title: 3-4 DB 집합과 조인 : INTERSECT로 실제 주문이 발생한 등록 상품 찾기
-- Description: 상품 운영자가 등록된 상품 중 주문이 발생한 상품을 확인하려고 한다. 등록 상품 ID 목록과 주문상품 ID 목록 양쪽에 공통으로 존재하는 ID만 조회한다. 주문 횟수나 인기 순위를 계산하는 쿼리는 아니다.
-- 실행 위치: Supabase SQL Editor
-- 설명: INTERSECT는 교집합이며 결과의 중복도 제거한다. 현재 예제는 deleted_at이 NULL인 상품과 주문상품 기록을 기준으로 한다.

SELECT id AS 상품ID
FROM products
WHERE deleted_at IS NULL

INTERSECT

SELECT product_id AS 상품ID
FROM order_items
WHERE deleted_at IS NULL
ORDER BY 상품ID;
```

**발표할 말**

> 등록 상품과 주문상품 기록 양쪽에 있는 상품만 찾았습니다. 두 목록의 공통 부분인 교집합입니다.

**설명**

INTERSECT는 교집합이며 결과의 중복도 제거한다. 현재 예제는 deleted_at이 NULL인 상품과 주문상품 기록을 기준으로 한다.

### 3-5 DB 집합과 조인 : EXCEPT로 주문 기록이 없는 판촉 검토 상품 찾기

**Title**
```text
3-5 DB 집합과 조인 : EXCEPT로 주문 기록이 없는 판촉 검토 상품 찾기
```

**Description / 조회 이유**
```text
상품 운영자가 상품 소개나 할인 행사를 검토할 대상을 찾으려고 한다. 등록 상품 목록에서 주문상품 기록에 있는 상품을 제외해 주문 기록이 없는 상품 ID를 찾는다. 삭제 처리된 주문상품 기록은 제외하므로 전체 과거 이력에서 한 번도 주문되지 않았다는 뜻은 아니다.
```

**SQL — Supabase SQL Editor에서 실행**
```sql
-- Title: 3-5 DB 집합과 조인 : EXCEPT로 주문 기록이 없는 판촉 검토 상품 찾기
-- Description: 상품 운영자가 상품 소개나 할인 행사를 검토할 대상을 찾으려고 한다. 등록 상품 목록에서 주문상품 기록에 있는 상품을 제외해 주문 기록이 없는 상품 ID를 찾는다. 삭제 처리된 주문상품 기록은 제외하므로 전체 과거 이력에서 한 번도 주문되지 않았다는 뜻은 아니다.
-- 실행 위치: Supabase SQL Editor
-- 설명: EXCEPT는 앞의 결과에서 뒤의 결과를 제외한다. 순서를 바꾸면 뜻이 달라진다. 빈 결과는 조회 대상 등록 상품이 모두 주문상품 기록에 있다는 뜻이다.

SELECT id AS 상품ID
FROM products
WHERE deleted_at IS NULL

EXCEPT

SELECT product_id AS 상품ID
FROM order_items
WHERE deleted_at IS NULL
ORDER BY 상품ID;
```

**발표할 말**

> 등록 상품에서 주문된 상품을 빼면 주문 기록이 없는 상품이 남습니다. 이 상품들을 판촉 검토 대상으로 볼 수 있습니다.

**설명**

EXCEPT는 앞의 결과에서 뒤의 결과를 제외한다. 순서를 바꾸면 뜻이 달라진다. 빈 결과는 조회 대상 등록 상품이 모두 주문상품 기록에 있다는 뜻이다.

## 4. 서브쿼리 유형

### 4-1 DB 서브쿼리 : 평균보다 비싼 상품을 찾아 가격 검토하기

**Title**
```text
4-1 DB 서브쿼리 : 평균보다 비싼 상품을 찾아 가격 검토하기
```

**Description / 조회 이유**
```text
상품 운영자가 현재 상품 중 상대적으로 가격이 높은 상품을 검토하려고 한다. 안쪽 쿼리에서 전체 평균 가격을 구하고 바깥쪽 쿼리에서 평균보다 비싼 상품만 조회한다. 평균보다 비싸다는 사실만으로 잘못된 가격이라고 판단하지 않는다.
```

**SQL — Supabase SQL Editor에서 실행**
```sql
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
```

**발표할 말**

> 안쪽 쿼리가 계산한 평균 가격을 바깥쪽 쿼리의 비교 기준으로 사용했습니다.

**설명**

AVG 결과는 값 하나이므로 스칼라 서브쿼리다. 바깥 행을 참조하지 않으므로 비상관 서브쿼리이기도 하다. 상품이 하나뿐이거나 가격이 모두 같으면 결과가 없는 것이 정상이다.

### 4-2 DB 서브쿼리 : IN으로 주문 발생 상품의 현재 가격 조회하기

**Title**
```text
4-2 DB 서브쿼리 : IN으로 주문 발생 상품의 현재 가격 조회하기
```

**Description / 조회 이유**
```text
상품 운영자가 주문이 발생한 상품의 현재 판매 가격을 확인하려고 한다. 주문상품에서 상품 ID 목록을 구한 뒤 그 목록에 포함된 상품의 이름과 가격을 조회한다. 조회되는 가격은 현재 가격이며 주문 당시 단가는 아니다.
```

**SQL — Supabase SQL Editor에서 실행**
```sql
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
```

**발표할 말**

> IN은 목록에 포함되어 있는지 확인합니다. 주문상품에 기록된 ID 목록으로 상품을 골랐습니다.

**설명**

안쪽 SELECT는 여러 행을 반환할 수 있다. 같은 ID가 여러 번 있어도 바깥 상품이 그 횟수만큼 복제되지는 않는다. 위 Python 코드는 의미 설명용이고 아래 SQL이 실제 서브쿼리다.

### 4-3 DB 서브쿼리 : EXISTS로 판매자별 주문 발생 상품 확인하기

**Title**
```text
4-3 DB 서브쿼리 : EXISTS로 판매자별 주문 발생 상품 확인하기
```

**Description / 조회 이유**
```text
운영자가 어떤 판매자의 상품에서 주문이 발생했는지 확인하려고 한다. 상품마다 연결된 주문상품 기록이 하나라도 있는지 확인하고 해당 상품과 판매자 ID를 조회한다. 안쪽 쿼리가 바깥쪽 상품의 p.id를 참조하는 상관 서브쿼리다.
```

**SQL — Supabase SQL Editor에서 실행**
```sql
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
```

**발표할 말**

> 상품마다 연결된 주문 기록이 하나라도 있는지 검사합니다. 안쪽 쿼리에서 바깥쪽 상품 ID를 사용하므로 상관 서브쿼리입니다.

**설명**

SELECT 1은 첫 번째 행이나 열이라는 뜻이 아니다. 상수 1을 선택하는 표현이며 EXISTS는 값보다 행의 존재 여부를 검사하므로 이렇게 쓰는 관례가 있다. 실제 DB 실행 계획이 Python 반복문과 같다고 단정하지 않는다.

## 5. 트랜잭션(TCL)과 ACID 원칙

### 5-1 DB 트랜잭션과 ACID : 배송완료 변경을 확인하고 ROLLBACK으로 취소하기

**Title**
```text
5-1 DB 트랜잭션과 ACID : 배송완료 변경을 확인하고 ROLLBACK으로 취소하기
```

**Description / 조회 이유**
```text
주문 관리자가 배송완료 상태로 변경하려다가 아직 완료 처리하면 안 된다는 것을 확인한 상황이다. BEGIN으로 시작해 상태를 변경하고 ROLLBACK으로 확정 전 변경을 취소한다. 전체 SQL을 한 번에 실행한다. 이미 COMMIT한 작업을 되돌리는 예제는 아니다.
```

**SQL — Supabase SQL Editor에서 실행**
```sql
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
```

**발표할 말**

> 배송완료로 변경했지만 아직 확정하지 않았습니다. ROLLBACK으로 취소해서 변경 전 상태로 돌아갑니다.

**설명**

SQL 파일에는 이전 시연 주문 ID가 들어 있다. 새 주문을 만들었다면 노트북의 바로 위 셀이 출력하는 최신 주문 ID가 포함된 SQL을 복사한다. 편집기에서 마지막 결과만 보일 수 있다. 별도 SDK 요청 두 개가 자동으로 하나의 트랜잭션이 되지는 않는다.

## 6. SDK, 랭체인

**제목:** SDK와 랭체인 : 주문 조회로 메서드 체이닝과 self 반환 이해하기

**설명:** 노트북의 마지막 코드 셀에서 조회할 열을 지정하고 eq로 주문 ID 조건을 추가한다. query is same_query가 True이면 같은 객체가 반환된 것이다. 마지막 execute에서 요청을 보낸다. 새 import나 별도 .py 파일은 사용하지 않는다.

**발표할 말:** “SDK는 서비스 기능을 코드에서 사용할 수 있게 하는 도구입니다. 조건을 추가한 뒤 같은 객체를 반환하므로 메서드를 이어 호출할 수 있습니다.”

**LangChain 구분:** self 반환은 일반적인 메서드 체이닝 방식이다. LangChain은 언어 모델, 프롬프트, 검색 등 구성 요소를 연결하는 라이브러리다. 현재 노트북은 Supabase SDK 예제이며 LangChain 라이브러리를 실행한 예제라고 설명하지 않는다.

## 실행 범위와 검증

- 2~4번 항목의 10개 SQL은 조회만 수행한다.
- 5번은 BEGIN부터 마지막 SELECT까지 전체 실행하며 ROLLBACK으로 취소한다. 새 주문에는 노트북에서 출력한 SQL을 사용한다. 이미 COMMIT한 작업을 취소하는 기능은 아니다.
- 집합과 서브쿼리는 삭제되지 않은 주문상품 기록 기준이다. 부모 주문의 취소 상태 같은 추가 업무 조건을 적용한 통계는 아니다.
- 빈 결과는 조건에 해당하는 행이 없다는 정상 결과일 수 있다.
- 이 목록은 발표용 SQL이며 DB 전체 실행 이력이나 팀원의 모든 설정 SQL을 수집한 결과가 아니다.
- [products RLS 해제](settings/products_RLS_해제.sql)는 이전 설정 기록이며 이번 발표 조회 목록에 포함하지 않는다.

### 이번 변경의 확인 결과

- 노트북 JSON 구조 검증과 코드 셀 14개의 문법 확인을 통과했다.
- 제목, Description, SQL의 파일/노트북 일치를 확인했다.
- 로컬 SQLite 메모리 DB에서 빈 데이터, 상품 한 개, 여러 상품/중복/NULL/삭제 표시 데이터로 조회 10개를 확인했다. ROLLBACK 이후 상태 복원도 확인했다. 이 결과는 Supabase/PostgreSQL에서 직접 실행했다는 뜻은 아니다.
- Python 집합 셀을 제거해도 IN 비교 예제가 필요한 ID 목록을 자체적으로 생성하는 것을 확인했다.
- 기존 클래스 노트북 네 개의 파일 내용이 변경되지 않았음을 확인했다.
