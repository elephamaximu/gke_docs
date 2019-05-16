# DOCKER, GKE, jenkins x 통한 django 어플리케이션 클라우드 배포와 CI|CD 과정 정리

### 순서

1. 구글 클라우드 플랫폼 계정 설정 및 구글 플랫폼 로컬 연동 환경 구축
2. 로컬 코드와 구글 클라우드 플랫폼 Mysql 연동 테스트
3. 로컬 코드와 구글 클라우드 플랫폼 Storage 연동을 통한 static 파일 클라우드화 테스트
4. 정적(static) 파일 스토리지 CORS 헤더 삽입 
5. 로컬코드를 도커 이미지화
6. 도커 이미지를 구글 클라우드 클러스터 엔진(GKE)에 배포, 외부 IP를 통한 접속 확인
7. GKE에 배포 후 로깅
8. GKE에 배포 후 Domain Name 부여하기
9. jenkins x를 통한 지속적인 CI|CD

# 1. 구글 클라우드 플랫폼 계정 설정 및 구글 플랫폼 로컬 연동 환경 구축
### 1-1 구글 클라우드 플랫폼 계정 설정
a. 구글 클라우드 플랫폼 가입
b. 프로젝트 만들기
c. 서비스계정 만들기
SQL, STORAGE, KUBERNETES 검색해서 최고 권한 부여

### 1-2 구글 플랫폼 로컬 연동 환경 구축
a. Cloud SDK 로컬에 설치
b. 로컬 os 환경변수에 서비스계정 인증해놓기
c. vscode 플러그인 (선택사항)

# 2. 로컬 코드와 구글 클라우드 플랫폼 Mysql 연동 테스트
a. SQL 프록시 설치(로컬과 클라우드 데이터 베이스 연동 프로그램)
b. Cloud SQL 인스턴스 생성
c. connectionName 확인
d. SQL 프록시를 이용하여 로컬과 클라우드 데이터 베이스 연동
e. 데이터베이스 생성 및 사용자 생성
f. 로컬 os 환경변수에 데이터 베이서 ID와 PASSWORD 저장하기
g. django 어플리케이션 settings.py 데이터 베이스 코드 수정
h. django 어플리케이션 superuser 생성

# 3. 로컬 코드와 구글 클라우드 플랫폼 Storage 연동을 통한 static 파일 클라우드화 테스트

### 2-1 구글 Storage 버킷 생성 및 세팅
a. 구글 Storage 버킷 생성
b. 구글 Storage 버킷 공개

### 2-2 구글 Storage 버킷으로 djnago static 파일 연동하기
a. django 어플리케이션 collect static 수행
b. django 어플리케이션 static 폴더를 Storage 버킷 static 폴더로 업로드
c. django 어플리케이션 settings.py STATIC_URL 수정

