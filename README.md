# UIKit-Template

## 키워드
Tuist, 클린아키텍처, MVVM, DI, 보안

## Tuist
**설치**
```
curl -Ls https://install.tuist.io | bash
```
**초기화**
```
tuist init --platform ios // UIKit
tuist init --platform ios --template swiftui // SwiftUI
```
**파일 편집**
```
tuist edit
```
**외부 라이브러리, 프레임워크 다운**
```
tuist fetch
```
**프로젝트 생성 및 실행**
```
tuist generate
```
**주의점**
- Sources, Resources, Tests, Support 폴더, Asset, info.plist 직접 만들어줘야함
- 폴더 안에 파일 없으면 안보임

## 클린아키텍처
### App
- AppDelegate
- SceneDelegate
- DI 관련 (Injector, Assembly)

### Data
- API
- DTO
- 네트워크 헬퍼 (MoyaWrapper, URLSessin Extension)
- Datasource 프로토콜 + 구현체
- Repository 구현체

### Domain
- VO
- Repository 프로토콜
- Usecase 프로토콜 + 구현체

### Presentation
- ViewController
- ViewModel (Base 포함)

## MVVM
- 프로퍼티 래퍼 잘 활용하기
- BaseViewModel에 공통으로 쓰이는거 집어넣기

## DI
- 각 모듈별로 Assemebly 생성

## 보안
- Config.xcconfig 파일 생성해서 중요정보 써놓기
- Target -> App -> info에 등록 (API_KEY : $(API_KEY))
```
let key = Bundle.main.infoDictionary?["API_KEY"] ?? ""
```
