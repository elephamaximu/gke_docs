# DOCKER, GKE, jenkins x 통한 django 어플리케이션 클라우드 배포와 CI|CD

**[참조 문서 - 구글 공식 다큐먼트](https://cloud.google.com/python/django/kubernetes-engine){ target="_blank" }**

### 순서

**[1. 구글 클라우드 플랫폼 계정 설정 및 구글 플랫폼 로컬 연동 환경 구축](#1-%EA%B5%AC%EA%B8%80-%ED%81%B4%EB%9D%BC%EC%9A%B0%EB%93%9C-%ED%94%8C%EB%9E%AB%ED%8F%BC-%EA%B3%84%EC%A0%95-%EC%84%A4%EC%A0%95-%EB%B0%8F-%EA%B5%AC%EA%B8%80-%ED%94%8C%EB%9E%AB%ED%8F%BC-%EB%A1%9C%EC%BB%AC-%EC%97%B0%EB%8F%99-%ED%99%98%EA%B2%BD-%EA%B5%AC%EC%B6%95)**

**[2. 로컬 코드와 구글 클라우드 플랫폼 Mysql 연동 테스트](#2-%EB%A1%9C%EC%BB%AC-%EC%BD%94%EB%93%9C%EC%99%80-%EA%B5%AC%EA%B8%80-%ED%81%B4%EB%9D%BC%EC%9A%B0%EB%93%9C-%ED%94%8C%EB%9E%AB%ED%8F%BC-mysql-%EC%97%B0%EB%8F%99-%ED%85%8C%EC%8A%A4%ED%8A%B8)**

**[3. 로컬 코드와 구글 클라우드 플랫폼 Storage 연동을 통한 static 파일 클라우드화 테스트](#3-%EB%A1%9C%EC%BB%AC-%EC%BD%94%EB%93%9C%EC%99%80-%EA%B5%AC%EA%B8%80-%ED%81%B4%EB%9D%BC%EC%9A%B0%EB%93%9C-%ED%94%8C%EB%9E%AB%ED%8F%BC-storage-%EC%97%B0%EB%8F%99%EC%9D%84-%ED%86%B5%ED%95%9C-static-%ED%8C%8C%EC%9D%BC-%ED%81%B4%EB%9D%BC%EC%9A%B0%EB%93%9C%ED%99%94-%ED%85%8C%EC%8A%A4%ED%8A%B8)**

**[4. 정적(static) 파일 스토리지 CORS 헤더 삽입](#4-%EC%A0%95%EC%A0%81static-%ED%8C%8C%EC%9D%BC-%EC%8A%A4%ED%86%A0%EB%A6%AC%EC%A7%80-cors-%ED%97%A4%EB%8D%94-%EC%82%BD%EC%9E%85)**

**[5. 로컬코드를 도커 이미지화](#5-%EB%A1%9C%EC%BB%AC%EC%BD%94%EB%93%9C%EB%A5%BC-%EB%8F%84%EC%BB%A4-%EC%9D%B4%EB%AF%B8%EC%A7%80%ED%99%94)**

**[6. 도커 이미지를 구글 클라우드 클러스터 엔진(GKE)에 배포, 외부 IP를 통한 접속 확인]()**

**[7. GKE에 배포 후 로깅](#7-gke%EC%97%90-%EB%B0%B0%ED%8F%AC-%ED%9B%84-%EB%A1%9C%EA%B9%85)**

**[8. GKE에 배포 후 Domain Name 부여하기](#8-gke%EC%97%90-%EB%B0%B0%ED%8F%AC-%ED%9B%84-domain-name-%EB%B6%80%EC%97%AC%ED%95%98%EA%B8%B0)**

**[9. jenkins x를 통한 지속적인 CI|CD](#9-jenkins-x%EB%A5%BC-%ED%86%B5%ED%95%9C-%EC%A7%80%EC%86%8D%EC%A0%81%EC%9D%B8-cicd)**

# 1. 구글 클라우드 플랫폼 계정 설정 및 구글 플랫폼 로컬 연동 환경 구축

### 1-1 구글 클라우드 플랫폼 계정 설정
a. 구글 클라우드 플랫폼 가입

[구글 클라우드 플랫폼]()

b. 프로젝트 만들기

[구글 클라우드]

c. 서비스계정 만들기

SQL, STORAGE, KUBERNETES 검색해서 최고 권한 부여

### 1-2 구글 플랫폼 로컬 연동 환경 구축
a. Cloud SDK 로컬에 설치

b. 로컬 os 환경변수에 서비스계정 인증해놓기

c. vscode 플러그인 (선택사항)

# 2. 로컬 코드와 구글 클라우드 플랫폼 Mysql 연동 테스트

### 2-1 구글 클라우드 플랫폼 MYsql 서버와 local 서버 연동

a. SQL 프록시 설치(로컬과 클라우드 데이터 베이스 연동 프로그램)

b. Cloud SQL 인스턴스 생성

c. connectionName 확인

d. SQL 프록시를 이용하여 로컬과 클라우드 데이터 베이스 연동

e. 데이터베이스 생성 및 사용자 생성

f. 로컬 os 환경변수에 데이터 베이서 ID와 PASSWORD 저장하기

### 2-2 django 어플리케이션 세팅

a. django 어플리케이션 settings.py 데이터 베이스 코드 수정

b. django 어플리케이션 superuser 생성

# 3. 로컬 코드와 구글 클라우드 플랫폼 Storage 연동을 통한 static 파일 클라우드화 테스트

### 3-1 구글 Storage 버킷 생성 및 세팅
a. 구글 Storage 버킷 생성

b. 구글 Storage 버킷 공개

### 3-2 구글 Storage 버킷으로 djnago static 파일 연동하기
a. django 어플리케이션 collect static 수행

b. django 어플리케이션 static 폴더를 Storage 버킷 static 폴더로 업로드

c. django 어플리케이션 settings.py STATIC_URL 수정

# 4. 정적(static) 파일 스토리지 CORS 헤더 삽입

### 4-1 Cors-json

a

# 5. 로컬코드를 도커 이미지화 

### 5-1 

a.

b.

c.

### 5-2 

a.

b.

c.

### 5-3 

a.

b.

c.

# 6. 도커 이미지를 구글 클라우드 클러스터 엔진(GKE)에 배포, 외부 IP를 통한 접속 확인 

### 6-1 

a.

b.

c.

### 6-2 

a.

b.

c.

### 6-3 

a.

b.

c.

# 7. GKE에 배포 후 로깅 

### 7-1 

a.

b.

c.

### 7-2 

a.

b.

c.

### 7-3 

a.

b.

c.

# 8. GKE에 배포 후 Domain Name 부여하기 

### 8-1 

a.

b.

c.

### 8-2 

a.

b.

c.

### 8-3 

a.

b.

c.

# 9. jenkins x를 통한 지속적인 CI|CD 

### 9-1 

a.

b.

c.

### 9-2 

a.

b.

c.

### 9-3 

a.

b.

c.

