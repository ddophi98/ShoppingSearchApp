# ShoppingSearchApp

<img width="500" src="https://github.com/ddophi98/ShoppingSearchApp/assets/72330884/bc6af6e7-ef6c-486c-b91b-bdf0756500a8"> 

- 배운 개발 기술들을 실제로 적용해보기 위해 만든 프로젝트입니다.
- 기술스택: UIKit, Tuist, Clean Architecture, 모듈화, MVVM, Server Driven UI, Caching, Logging, DI, Coordinator 패턴

## 목차
- [Clean Architecture + MVVM](#clean-architecture--mvvm)
- [Server Driven UI](#server-driven-ui)
- [TableView, CollectionView](#tableview-collectionview)
- [Caching](#Caching)
- [Logging](#Logging)


## Clean Architecture + MVVM
<img width="700" src="https://github.com/ddophi98/ShoppingSearchApp/assets/72330884/3878668d-cc93-4f54-895a-81aaa0a611fb">

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

## Server Driven UI
<img width="500" src="https://github.com/ddophi98/ShoppingSearchApp/assets/72330884/4048d22e-5310-4ae4-b626-ad2bfd377ed8">

- 서버에서 보내주는 Response에 맞춰서 UI가 동적으로 변경되도록 할 수 있습니다.   
  ex) 현재 화면에서는 광고의 위치를 동적으로 조정할 수 있습니다.
- 이를 응용한다면 뷰의 위치뿐만 아니라 글씨 크기, 색상 등도 Response로 내려주고 동적으로 업데이트할 수 있습니다.
- 클라이언트측에서 직접 UI를 수정할 경우, 오래 걸리는 앱 심사와 유저가 앱 업데이트를 하지 않는 문제를 극복하기 위해 해당 기술을 활용할 수 있습니다.

## TableView, CollectionView
가로 스크롤, 세로 스크롤이 공존하는 화면을 만들고자 했고 두가지 방법을 시도했습니다.

#### 상품검색 화면
<img width="1000" src="https://github.com/ddophi98/ShoppingSearchApp/assets/72330884/b723d2ec-4524-41c6-ad50-0e7c86846d4c">

- 첫번째 방법은 CollectionView만 사용하는 것이었습니다.
- UICollectionViewCompositionalLayout을 사용하면서 특정 섹션에 orthogonalScrollingBehavior 속성을 줬습니다.
- CollectionView만 사용해서 만들 수 있기에 비교적 간단했고 특정 섹션만 스크롤 방향을 변경할 수 있다는 것이 편리했습니다.

#### 장바구니 화면
<img width="1000" src="https://github.com/ddophi98/ShoppingSearchApp/assets/72330884/77f9ffb4-c0e6-4a76-8670-0a6301f05d95">

- 두번째 방법은 TableView를 먼저 정의하고, TableView의 Cell 중 하나를 CollectionView로 정의하는 방식이었습니다.   
- CollectionView에서는 UICollectionViewFlowLayout를 사용하면서 scrollDirection 속성을 horizontal로 지정했습니다.   
- TableView, CollectionView를 모두 정의해야했기에 비교적 복잡했고, scrollDirection은 CollectionView의 모든 섹션에 적용되어버리는 제한 사항이 존재합니다.

## Caching
<img width="500" src="https://github.com/ddophi98/ShoppingSearchApp/assets/72330884/efa67b78-60e0-4275-99b8-46b0aed6d6fb">


#### 이미지 캐싱
- 같은 URL이라면 같은 이미지인 경우가 대다수이기 때문에, 빠르게 이미지를 가져오기 위해 이미지 캐싱을 하게 됐습니다.
- 이미지 URL을 키 값으로 사용하여, 해당 키가 존재하면 네트워크 통신 대신 캐시에서 가져오도록 구현했습니다.
- 디스크에 이미지가 쌓여서 용량이 과도하게 늘어나는 일을 막기 위해서는 메모리 캐시가 적절하다고 생각하여 NSCache를 사용했습니다.

#### JSON 캐싱
- 물건을 검색하는 경우, 시간이 몇분 지나지 않았다면 서버로부터 같은 Response가 내려올 가능성이 크다고 생각했기 때문에, 빠르게 응답을 처리하기 위해 JSON 캐싱을 하게 됐습니다.
- 검색어를 키 값으로 사용하여, 해당 키가 존재하면 네트워크 통신 대신 캐시에서 가져오도록 구현했습니다.
- 물건 검색은 시간이 지나면 결과가 변할 수 있기에, 영구적으로 보관하는 디스크 캐시보다는 메모리 캐시가 적절하다고 생각하여 NSCache를 사용했습니다.

## Logging
<img width="700" src="https://github.com/ddophi98/ShoppingSearchApp/assets/72330884/129a5e5b-a5b2-4e15-a341-71ab33d074bd">

#### 로그
- 로깅은 앱에서 일어나는 각종 이벤트에 대해 로그를 남기는 것입니다.
- 로그를 분석하여 MAU와 같은 특정 지표를 계산하거나, 사용자의 행동 패턴을 관찰할 수 있습니다.
- 에러가 발생했을 경우, 어떤 동작들로 인해 문제가 생겼는지 분석하는 것에도 도움이 될 수 있습니다.
- 보통은 서버에 로그를 기록하지만, 프로젝트 특성 상 로컬 CSV 파일에 기록하게 됐습니다.

#### 스키마
        공통요소: Time, App Version, OS, Log Version, Event, View
        개별요소
        - 상품 탭 이벤트: Product Name, Product Price, Product Position, Product Index
        - 검색 이벤트: Query
- 로그 스키마에는 모든 곳에 공통적으로 필요한 요소와 개별적으로 필요한 요소가 존재합니다.
- 개별적으로 필요한 요소를 위해 처음에는 ```Dictionary<String, String>``` 으로 정의했으나, 스키마를 생성할 때마다 순서가 보장되지 않는 문제 때문에 ```Array<(String, String)>``` 으로 개선했습니다.
- 스키마 객체를 생성할 때는 빌더 패턴을 활용하여, 상황에 따라 필요한 요소만 수월하게 넣을 수 있도록 했습니다.
