# DOCKER, GKE, jenkins x 통한 django 클라우드 배포 및 CI|CD

**[참조 문서 - 구글 공식 다큐먼트](https://cloud.google.com/python/django/kubernetes-engine)**

### 순서

**[1. 구글 클라우드 플랫폼 계정 설정 및 구글 플랫폼 로컬 연동](#1-%EA%B5%AC%EA%B8%80-%ED%81%B4%EB%9D%BC%EC%9A%B0%EB%93%9C-%ED%94%8C%EB%9E%AB%ED%8F%BC-%EA%B3%84%EC%A0%95-%EC%84%A4%EC%A0%95-%EB%B0%8F-%EA%B5%AC%EA%B8%80-%ED%94%8C%EB%9E%AB%ED%8F%BC-%EB%A1%9C%EC%BB%AC-%EC%97%B0%EB%8F%99-%ED%99%98%EA%B2%BD-%EA%B5%AC%EC%B6%95)**

**[2. 로컬 코드와 구글 클라우드 플랫폼 Mysql 연동 테스트](#2-%EB%A1%9C%EC%BB%AC-%EC%BD%94%EB%93%9C%EC%99%80-%EA%B5%AC%EA%B8%80-%ED%81%B4%EB%9D%BC%EC%9A%B0%EB%93%9C-%ED%94%8C%EB%9E%AB%ED%8F%BC-mysql-%EC%97%B0%EB%8F%99-%ED%85%8C%EC%8A%A4%ED%8A%B8)**

**[3. 로컬 코드와 구글 클라우드 플랫폼 Storage 연동을 통한 static 파일 클라우드화 테스트](#3-%EB%A1%9C%EC%BB%AC-%EC%BD%94%EB%93%9C%EC%99%80-%EA%B5%AC%EA%B8%80-%ED%81%B4%EB%9D%BC%EC%9A%B0%EB%93%9C-%ED%94%8C%EB%9E%AB%ED%8F%BC-storage-%EC%97%B0%EB%8F%99%EC%9D%84-%ED%86%B5%ED%95%9C-static-%ED%8C%8C%EC%9D%BC-%ED%81%B4%EB%9D%BC%EC%9A%B0%EB%93%9C%ED%99%94-%ED%85%8C%EC%8A%A4%ED%8A%B8)**

**[4. 정적(static) 파일 스토리지 CORS 헤더 삽입](#4-%EC%A0%95%EC%A0%81static-%ED%8C%8C%EC%9D%BC-%EC%8A%A4%ED%86%A0%EB%A6%AC%EC%A7%80-cors-%ED%97%A4%EB%8D%94-%EC%82%BD%EC%9E%85)**

**[5. Kubernetes 엔진 클러스터 생성 환경 준비하기](#5-kubernetes-%EC%97%94%EC%A7%84-%ED%81%B4%EB%9F%AC%EC%8A%A4%ED%84%B0-%ED%99%98%EA%B2%BD-%EC%A4%80%EB%B9%84%ED%95%98%EA%B8%B0)**

**[6. 도커 이미지를 구글 클라우드 클러스터 엔진(GKE)에 배포](#6-%EB%8F%84%EC%BB%A4-%EC%9D%B4%EB%AF%B8%EC%A7%80%EB%A5%BC-%EA%B5%AC%EA%B8%80-%ED%81%B4%EB%9D%BC%EC%9A%B0%EB%93%9C-%ED%81%B4%EB%9F%AC%EC%8A%A4%ED%84%B0-%EC%97%94%EC%A7%84gke%EC%97%90-%EB%B0%B0%ED%8F%AC)**

**[7. GKE에 배포 후 로깅](#7-gke%EC%97%90-%EB%B0%B0%ED%8F%AC-%ED%9B%84-%EB%A1%9C%EA%B9%85)**

**[8. GKE에 배포 후 Domain Name 부여하기](#8-gke%EC%97%90-%EB%B0%B0%ED%8F%AC-%ED%9B%84-domain-name-%EB%B6%80%EC%97%AC%ED%95%98%EA%B8%B0)**

**[9. jenkins x를 통한 지속적인 CI|CD](#9-jenkins-x%EB%A5%BC-%ED%86%B5%ED%95%9C-%EC%A7%80%EC%86%8D%EC%A0%81%EC%9D%B8-cicd)**

# 1. 구글 클라우드 플랫폼 계정 설정 및 구글 플랫폼 로컬 연동 환경 구축

### 1-1 구글 클라우드 플랫폼 계정 설정

#### a. 구글 클라우드 플랫폼 회원 가입

**[구글 클라우드 플랫폼 페이지->](https://cloud.google.com/?hl=ko)**

#### b. 프로젝트 만들기

- 콘솔에서 상단의 드롭다운 메뉴에서 프로젝트 만들기를 선택.
- 프로젝트 ID(프로젝트 이름과 다를 수 있음)를 메모. 프로젝트 ID는 명령어와 구성에 사용.
- 프로젝트 결제 설정
- API 사용 설정

**[API 사용 설정 안내 페이지->](https://cloud.google.com/apis/docs/enable-disable-apis?hl=ko)**

- 사용하는 API 는 Cloud SQL API와 Compute Engine API

#### c. 서비스계정 만들기

- 콘솔 왼쪽 메뉴 탭에서 IAM 및 관리자 -> 서비스 계정 선택

- 역할 선택 

(1). Cloud SQL관리자 (2). storage 저장소 관리자 (3). Kubernetes Engin 관리자

- json 형식으로 key 로컬에 다운로드

### 1-2 구글 플랫폼 로컬 연동 환경 구축

#### a. Cloud SDK 로컬에 설치**

**[클라우드 SDK 설치 페이지 ->](https://cloud.google.com/sdk/downloads?hl=ko)**

**[윈도우 대화형 설치 프로그램](https://dl.google.com/dl/cloudsdk/channels/rapid/GoogleCloudSDKInstaller.exe?hl=ko)** 다운로드

- 시스템의 Python 2가 Python 2.7.9 이상의 출시 버전으로 설치되지 않은 경우 Bundled Python(Python 포함) 설치 옵션 선택

- 설치 프로그램에서 터미널 창을 시작하고 gcloud init 명령어 실행

`gcloud init`


#### b. 로컬 os 환경변수에 서비스계정 인증해놓기

[1-1 C](#1-1-%EA%B5%AC%EA%B8%80-%ED%81%B4%EB%9D%BC%EC%9A%B0%EB%93%9C-%ED%94%8C%EB%9E%AB%ED%8F%BC-%EA%B3%84%EC%A0%95-%EC%84%A4%EC%A0%95)의 서비스 계정 만들기에서 다운 받은 json 파일을 os 환경변수에 추가해서 서비스 계정을 인증


**[인증 시작하기 페이지 ->](https://cloud.google.com/docs/authentication/getting-started?hl=ko)**

- cmd 창에서 

`set GOOGLE_APPLICATION_CREDENTIALS=[PATH]`

- [PATH] 안에 전체 경로와 json 이름을 쌍따옴표 없이 넣어줌 예) C:\xxx-xxx.json

#### c. vscode 플러그인 (선택사항)

- vscode 플러그인 검색창에서 

(1) Docker 0.62

(2) Kubernetes 1.0.0

(3) Cloud Code 0.0.8

(4) jx-tools 0.0.45


# 2. 로컬 코드와 구글 클라우드 플랫폼 Mysql 연동 테스트

### 2-1 구글 클라우드 플랫폼 Mysql 서버와 local 서버 연동

**a. SQL 프록시 설치(로컬과 클라우드 데이터 베이스 연동 프로그램)**

**[sql 프록시 다운 링크](https://dl.google.com/cloudsql/cloud_sql_proxy_x64.exe)**

다른 이름으로 저장 하기 해서 `cloud_sql_proxy.exe` 로 이름을 바꿔서 다운


**b. Cloud SQL 인스턴스 생성**

콘솔 왼쪽 메뉴 탭에서 SQL 클릭

Mysql 선택

인스턴스 ID, 루트 비밀 번호 설정

리전 -> asia-northeast1 선택

데이터베이스 버전 -> MySQL5.7

생성


**c. connectionName 확인**

생성 된 후 해당 인스턴스 ID를 클릭하여 관리 화면에 접속

인스턴스 연결 이름

`fair-gradient-xxxx:asia-northeast1:xxxx` 복사 해 둠

ConnectionName 이라 해서 자주 사용된다


**d. SQL 프록시를 이용하여 로컬과 클라우드 데이터 베이스 연동**

cmd 창에서 다운 받은 cloud_sql_proxy.exe 파일 위치로 이동 한 후

`cloud_sql_proxy.exe -instances="[YOUR_INSTANCE_CONNECTION_NAME]"=tcp:3306`

가운데 [YOUR_INSTANCE_CONNECTION_NAME] 에는 복사 해 놓은 ConnectionName을 붙여 넣는다.

로컬 3306 포트에 이미 Mysql 서버가 돌고 있으면 충돌이 나므로 로컬 Mysql 서버는 꺼놓고 실행한다.

실행 후 로컬 에서 구글 클라우드 SQL을 사용하는 동안에는 계속 켜둔다.


**e. 데이터베이스 생성 및 사용자 생성**

콘솔 SQL -> 내 인스턴스 ID 로 들어와서 상단 데이터베이스 탭으로 들어간다

데이터베이스 만들기를 클릭하여 데이터베이스를 생성해준다.

상단 사용자 탭으로 들어가서 사용자를 생성 할 수 있다.(root만 사용시 skip 가능)


**f. 로컬 os 환경변수에 구글 SQL 인스턴스 ID와 PASSWORD 저장하기**

위에서 만든 Mysql 인스턴스 내 데이터베이스 접속 가능한 ID와 PASSWORD를 로컬 os 환경변수로 지정해준다

사용자를 생성했다면 사용자 ID와 PASSWORD, 생성하지 않았다면 ID=root, PASSWORD=인스턴스 생성시 비밀번호

cmd 창에서

`set DATABASE_USER=<your-database-user>`

`set DATABASE_PASSWORD=<your-database-password>`


### 2-2 django 어플리케이션 세팅

**a. django 어플리케이션 settings.py 데이터 베이스 코드 수정**

```
  DATABASES = {
      'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': '데이터베이스 이름',
        'USER': os.getenv('DATABASE_USER'),
        'PASSWORD': os.getenv('DATABASE_PASSWORD'),
        'HOST': '127.0.0.1',
        'PORT': '3306',
        }
    }
```

위 코드에서 

`os.getenv('DATABASE_USER')`

`os.getenv('DATABASE_PASSWORD')`

는 로컬 환경변수에 저장한 데이터베이스 아이디와 비밀번호가 자동으로 들어가게 된다

로컬 django 어플리케이션 위치로 가서 데이터베이스 migrate 실행 해준다

`python manage.py migrate`

**b. django 어플리케이션 superuser 생성**

migrate를 통해 구글 클라우드 SQL과 내 로컬 django 어플리케이션이 연동 되어 있으므로

django 어플리케이션 admin 창에서 사용할 superuser를 생성해준다

`python manage.py createsuperuser`


# 3. 로컬 코드와 구글 클라우드 플랫폼 Storage 연동을 통한 static 파일 클라우드화 테스트

### 3-1 구글 Storage 버킷 생성 및 세팅

**a. 구글 Storage 버킷 생성**

구글 클라우드 플랫폼에서는 Gunicorn 서버를 사용하여 앱을 배포한다. 

하지만 Gunicorn 서버는 정적 파일을 서빙하지 않기 때문에 따로 Cloud Storage를 생성하여 정적파일을 서빙해줘야 한다.

먼저 버켓을 생성하고 기본적으로 버켓을 공개해놓는다.

```
# 버켓 생성

gsutil mb gs://<버켓이름>
```

**b. 구글 Storage 버킷 공개**


```
# 기본 공개 설정

gsutil defacl set public-read gs://<버켓이름> 
```


### 3-2 구글 Storage 버킷으로 djnago static 파일 연동하기

**a. django 어플리케이션 collect static 수행**

django 어플리케이션에서 정적파일을 한 폴더에 모아준다.

`python manage.py collectstatic`


**b. django 어플리케이션 static 폴더를 Storage 버킷 static 폴더로 업로드**

만약 settings.py 

`STATIC_ROOT = os.path.join(BASE_DIR, 'static_root')`

로 설정 했다면

`gsutil rsync -R static_root/ gs://<버킷이름>/static`

클라우드 콘솔 왼쪽 메뉴 탭에서 Storage -> 브라우저 클릭

해당 버킷과 업로드 된 static 파일 확인


**c. django 어플리케이션 settings.py STATIC_URL 수정**

`STATIC_URL="http://storage.googleapis.com/<버킷이름>/static/"`


**d. 기타 settings.py 수정 및 로컬에서 서버실행**

`DEBUG = True`

`ALLOWED_HOSTS = ['*']`

`python manage.py runserver`

로컬에서 django 어플리케이션이 돌지만 

데이터베이스는 구글 클라우드 mysql과 연동 되어 있고

Static file 은 구글 클라우드 storage 에서 전송 해주는 상태이다.


# 4. 정적(static) 파일 스토리지 CORS 헤더 삽입

### 4-1 Cors-json

구글 클라우드 스토리지에서 내 django 어플리케이션으로 정적 파일을 전송할 때

CORS(Cross-Origin Resource Sharing) 정책에 의해 파일 전송이 안되는 경우가 생길 수 있다.

이 때에는 웹 브라우저가 사용하는 정보를 읽을 수 있도록 허가된 출처 집합을 서버에게 알려주도록 허용하는 

HTTP 헤더를 추가해 줘야 한다.

django 어플리케이션 폴더 안에 cors-json-file.json 파일은 작성해 주고 

내 클라우드 스토리지 해당 버킷에 작성한 cors-json-file을 적용해 줘야 한다.


**a. cors-json-file 작성** 

django 어플리케이션 폴더 안에 cors-json-file.json 작성

```
[
    {

      "origin": ["*"],
      "method": ["*"]
    
    }
]
```


**b. 클라우드 스토리지 버킷에 작성한 cors-json-file 적용**

cmd창에서 cors-json-file.json 파일이 위치한 곳에서

```
# 버킷에 json 파일 적용하기

gsutil cors set cors-json-file.json gs://<버킷이름>
```


```
# 버킷에 적용된 cors 내용 확인하기

gsutil cors get gs://<버킷이름>
```


# 5. Kubernetes 엔진 클러스터 환경 준비하기


**------------------ 로컬 코드를 도커 이미지화해서 GKE에 배포 하기 위해서 필요한 파일은 3개 이다. ---------------**

**(1)Dockerfile (2)앱이름.yaml (3)requirements.txt**


### 5-1 Kubernetes 엔진 클러스터 생성하기

**a. GKE 초기화**

콘솔에서 왼쪽 메뉴 탭 Kubernetes Engine -> 클러스터 클릭

'Kubernetes Engine을 준비하는 중이며 1분 이상 걸릴 수 있습니다' 

메시지가 사라질 때까지 기다림.

**b. GKE 생성**

cmd 창에서 GKE 클러스터 생성

```
gcloud container clusters create <클러스터이름> --scopes "https://www.googleapis.com/auth/userinfo.email","cloud-platform" --num-nodes 4 --zone "asia-northeast1-a"
```

콘솔창에서 클러스터가 생성 되었는지 확인


**c. gcloud와 kubectl 상호작용 check**

cmd 창에서 

`gcloud container clusters get-credentials <클러스터이름> --zone "asia-northeast1-a"`


### 5-2 GKE 앱과 Cloud SQL간의 통신 환경 준비하기

GKE 앱과 Cloud SQL 간의 통신을 위한 secret 생성

**a. 인스턴스 수준 액세스(연결)**

```
kubectl create secret generic cloudsql-oauth-credentials --from-file=credentials.json=[PATH_TO_CREDENTIAL_FILE].json
```

CREDENTIAL_FILE은 [1-1 C](#1-1-%EA%B5%AC%EA%B8%80-%ED%81%B4%EB%9D%BC%EC%9A%B0%EB%93%9C-%ED%94%8C%EB%9E%AB%ED%8F%BC-%EA%B3%84%EC%A0%95-%EC%84%A4%EC%A0%95) 의 서비스 계정 만들기에서 다운 받은 json


**b. 데이터베이스 액세스용**

```
kubectl create secret generic cloudsql --from-literal=username=[PROXY_USERNAME] --from-literal=password=[PASSWORD]
```

[PROXY_USERNAME] = 데이터베이스 아이디

[PASSWORD] = 데이터베이스 비밀번호


### 5-3 도커 이미지 빌드하기

**a. CloudSQL 프록시용 Docker 이미지 pull**

b.gcr.io 는 [https://cloud.google.com/container-registry/](https://cloud.google.com/container-registry/)

구글 클라우드의 비공개 Docker 저장소이다.

구글 클라우드에서 미리 올려놓은 CloudSQL 프록시용 Docker 이미지를 pull 받는다.

`docker pull b.gcr.io/cloudsql-docker/gce-proxy:1.05`


**b. 도커 이미지 빌드**

내 코드를 미리 만들어 놓은 Dockerfile을 이용하여 도커 이미지를 빌드 한다

Dockerfile

```
FROM gcr.io/google_appengine/python

RUN virtualenv -p python3 /env
ENV PATH /env/bin:$PATH

ADD requirements.txt /app/requirements.txt
RUN /env/bin/pip install --upgrade pip && /env/bin/pip install -r /app/requirements.txt

ADD . /app

CMD gunicorn -b :$PORT 장고프로젝트이름.wsgi --timeout=300
```


`docker build -t gcr.io/<프로젝트아이디>/앱이름 .`



**c. gcloud를 사용자 인증 정보 도우미로 사용**


`gcloud auth configure-docker`


**d. 도커 이미지 push**

`docker build -t gcr.io/<프로젝트아이디>/앱이름 .`

콘솔 왼쪽 메뉴 탭 -> Storage -> 브라우저

버킷 이름 중 artifacts.<프로젝트아이디>.appspot.com

안에 이미지들이 push 되어 있음



# 6. 도커 이미지를 구글 클라우드 클러스터 엔진(GKE)에 배포 

### 6-1 GKE 리소스 생성 및 배포

**a. GKE 리소스 생성**

앱이름.yaml 파일 작성

```

apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: appname
  labels:
    app: appname
spec:
  replicas: 3
  template:
    metadata:
      labels:
        app: appname
    spec:
      containers:
      - name: appname
        image: gcr.io/[projectID]/[appname]
        imagePullPolicy: Always
        env:
            - name: DATABASE_USER
              valueFrom:
                secretKeyRef:
                  name: cloudsql
                  key: username
            - name: DATABASE_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: cloudsql
                  key: password
        ports:
        - containerPort: 8080

      - image: b.gcr.io/cloudsql-docker/gce-proxy:1.05
        name: cloudsql-proxy
        command: ["/cloud_sql_proxy", "--dir=/cloudsql",
                  "-instances=[ConnectionName]=tcp:3306",
                  "-credential_file=/secrets/cloudsql/credentials.json"]
        volumeMounts:
          - name: cloudsql-oauth-credentials
            mountPath: /secrets/cloudsql
            readOnly: true
          - name: ssl-certs
            mountPath: /etc/ssl/certs
          - name: cloudsql
            mountPath: /cloudsql
      volumes:
        - name: cloudsql-oauth-credentials
          secret:
            secretName: cloudsql-oauth-credentials
        - name: ssl-certs
          hostPath:
            path: /etc/ssl/certs
        - name: cloudsql
          emptyDir:


---

apiVersion: v1
kind: Service
metadata:
  name: appname
  labels:
    app: appname
spec:
  type: LoadBalancer
  ports:
  - port: 80
    targetPort: 8080
  selector:
    app: appname

```

작성한 앱이름.yaml을 이용하여 GKE 리소스 생성

`kubectl create -f 앱이름.yaml`


**b. 포드의 상태 확인**

생성 후 클러스터에 3개의 앱이름 pods 가 떠야 한다

`kubectl get pods`


**c. 배포 IP 확인**

포드가 준비되면 부하 분산기의 공개 IP 주소를 가져 올 수 있다.

`kubectl get services 앱이름`


# 7. GKE에 배포 후 로깅 

### 7-1 

a.

b.

c.

### 7-2 

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


# 9. jenkins x를 통한 지속적인 CI|CD 

### 9-1 

a.

b.

c.

### 9-2 

a.

b.

c.
