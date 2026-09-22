-- 제목: 설정 - products RLS 해제
-- 실행 위치: Supabase SQL Editor
-- 기록: 상품 생성이 RLS 정책으로 거부되어 실습 중 사용한 설정 SQL입니다.
-- 일반 발표 순서에는 포함하지 않습니다. 실행하면 products의 RLS 설정을 변경합니다.

ALTER TABLE public.products DISABLE ROW LEVEL SECURITY;
