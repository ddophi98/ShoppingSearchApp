## ShoppingSearchApp

<img width="400" src="https://github.com/ddophi98/ShoppingSearchApp/assets/72330884/9dde49d5-d612-4261-b7df-8d8385c96631"> 

- 배운 개발 기술들을 실제로 적용해보기 위해 만든 프로젝트
- UIKit, Tuist, Clean Architecture, 모듈화, MVVM, Server Driven UI, Caching, DI, Coordinator 패턴

## Clean Architecture + MVVM
<img width="700" src="https://github.com/ddophi98/ShoppingSearchApp/assets/72330884/a2cb2b17-f78f-406a-9bb8-586a3ba42d3b">

#### 계층별 역할 분리
    Data 계층 : 서버 또는 로컬 저장소로부터 데이터를 가져오고, DTO를 VO로 변환하는 역할을 합니다.
    Domain 계층 : 비즈니스 로직을 담당하는 역할을 합니다.
    Presentaion 계층 : UI를 보여주는 역할을 합니다.

- 계층별로 역할이 명확하기 때문에, 개발해야 하는 로직을 어느 곳에 넣을지 빠르게 결정할 수 있습니다.   
- 코드를 수정할 일이 생기더라도 다른 계층에 영향을 주지 않고 해당 계층만 안정적으로 수정할 수 있습니다.

#### 컴포넌트간 관계
    View, ViewModel, Usecase는 1:1 관계로 정의했습니다. (ShoppingList, Basket, Detail)
    Repository, Datasource는 1:1 관계로 정의했습니다. (Image, Search, ServerDriven)
    Usecase, Repository는 1:N 관계로 정의했습니다.
  
- 이렇게 함으로써 Repository를 재사용할 수 있습니다.   
  ex) 모든 Usecase에서 이미지 다운 로직을 다루기 위해 ImageRepository를 의존하고 있습니다.   
- 물론 이러한 관계는 앱의 환경에 맞춰 정의해야하며 정답이 정해져 있는 것은 아닙니다. 

#### 모듈화
- 각각의 계층을 모듈로 정의했습니다.
- 모듈별로 의존해야하는 프레임워크 및 라이브러리를 다르게 함으로써 의존성을 줄일 수 있습니다.
- 코드의 수정이 생기더라도 해당 모듈만 재빌드함으로써 빌드 시간을 줄일 수 있습니다.

#### MVVM
- Combine 프레임워크를 통해 ViewModel의 데이터가 변경될 시 View가 자동적으로 업데이트되도록 했습니다.
- Data Binding으로 View와 ViewModel 사이의 의존성을 줄일 수 있습니다.
