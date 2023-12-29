# ShoppingSearchApp

<img width="500" src="https://github.com/ddophi98/ShoppingSearchApp/assets/72330884/bc6af6e7-ef6c-486c-b91b-bdf0756500a8"> 

- 배운 개발 기술들을 실제로 적용해보기 위해 만든 프로젝트입니다.
- 기술스택: Tuist, UIKit, RxSwift, Clean Architecture, 모듈화, DI, MVVM, Coordinator 패턴, Server Driven UI, Caching, Logging, TTI, Deep Link

## 목차
- [Clean Architecture + MVVM](#clean-architecture--mvvm)
- [RxSwift](#rxswift)
- [Server Driven UI](#server-driven-ui)
- [TableView, CollectionView](#tableview-collectionview)
- [Caching](#Caching)
- [Logging](#Logging)
- [TTI (Time To Interactive)](#tti-time-to-interactive)
- [Deep Link](#deep-link)

## Clean Architecture + MVVM
<img width="700" src="https://github.com/ddophi98/ShoppingSearchApp/assets/72330884/cc41cc4b-94c7-4de7-8d8a-fbec26b4c903">


#### 계층별 역할 분리
    Data 계층 : 서버 또는 로컬 저장소로부터 데이터를 가져오고, DTO를 VO로 변환하는 역할을 합니다.
    Domain 계층 : 비즈니스 로직을 담당하는 역할을 합니다.
    Presentaion 계층 : UI를 보여주는 역할을 합니다.

- 계층별로 역할이 명확하기 때문에, 개발해야 하는 로직을 어느 곳에 넣을지 빠르게 결정할 수 있습니다.   
- 코드를 수정할 일이 생기더라도 다른 계층에 영향을 주지 않고 해당 계층만 안정적으로 수정할 수 있습니다.

#### 컴포넌트간 관계
    View, ViewModel은 1:1 관계로 정의했습니다.
    ViewModel, Usecase는 1:N 관계로 정의했습니다.
    Usecase, Repository는 1:N 관계로 정의했습니다.
    Repository, Datasource는 1:1 관계로 정의했습니다.

    View, ViewModel = <ShoppingList, Basket, Detail>
    Usecase = <Product, Logging>
    Repository, Datasource = <Image, Search, ServerDriven>

- View와 ViewModel, Repository와 Datasource는 밀접하게 관련이 있는 컴포넌트라고 생각하여 각각 1:1로 정의하였습니다.
- ViewModel과 Usecase, Usecase와 Repository는 1:N 관계로 정의함으로써, 공통적으로 사용되는 Usecase 또는 Repository를 재사용할 수 있습니다.   
  ex) 모든 ViewModel에서 상품 관련 로직을 위해 ProductUsecase에, 로깅 관련 로직을 위해 LoggingUsecase에 의존하고 있습니다.  

#### DTO -> VO 변환
- DTO에서 크게 의미가 없다고 생각되는 값은 옵셔널로 정의를 하고, VO로 변환할 때 옵셔널 처리를 통해 자체적으로 값을 설정했습니다.   
  (중요한 값은 옵셔널 처리를 할 것이 아니라, 에러 처리를 해야한다고 생각합니다.)
- 프로젝트에 따라 옵셔널 처리 외에도 DTO에서 VO로 변환해줄 때 해야하는 작업이 더 있을 수도 있습니다.   
  ex) MTS 앱이라면 매우 긴 숫자 데이터를 담기 위한 클라이언트 자체 모델로 변환하는 작업이 필요할 수도 있습니다.

#### 모듈화
- 각각의 계층을 모듈로 정의했습니다.
- 모듈별로 의존해야하는 프레임워크 및 라이브러리를 다르게 함으로써 의존성을 줄일 수 있습니다.
- 코드의 수정이 생기더라도 해당 모듈만 재빌드함으로써 빌드 시간을 줄일 수 있습니다.

#### MVVM
- RxSwift를 통해 ViewModel의 데이터가 변경될 시 View가 자동적으로 업데이트되도록 했습니다.
- Data Binding으로 View와 ViewModel 사이의 의존성을 줄일 수 있습니다.

## RxSwift
클린아키텍쳐 컴포넌트 사이에서 비동기적으로 데이터를 전달해주기 위해, 그리고 MVVM 패턴에서 Data Binding을 위해 RxSwift를 사용했습니다.
<img width="800" src="https://github.com/ddophi98/ShoppingSearchApp/assets/72330884/d190b302-d360-4d24-98fd-63e0a723e311">

1. Datasource에서 Usecase까지는 Single 객체를 그대로 전달합니다.
    - completed는 불필요하다고 생각되어, item 또는 error 두가지만 방출하는 Single을 사용했습니다.
3. ViewModel은 Usecase의 Single 객체를 구독합니다.
    - Datasource로부터 방출된 데이터를 자신의 프로퍼티에 저장합니다.
    - 데이터가 변했다는 것을 알리기 위해 PublishRelay에 Void 값을 방출합니다.
    - ViewModel이 사라지지 않는 이상 구독을 끊을 필요가 없기에, completed와 error가 존재하지 않는 PublishRelay를 사용했습니다.
4. View는 ViewModel의 PublishRelay를 구독합니다.
    - View는 ViewModel의 프로퍼티를 사용하여 CollectionView를 구성하고 있는 상태입니다.
    - ViewModel이 신호를 보내면 CollectionView를 업데이트하기 위해 reloadData()를 호출합니다.

> CollectionView, TableView와 RxSwift를 함께 사용할 때는 RxDataSources 프레임워크를 통해 Data Binding을 구현할 수 있는 것 같습니다.   
> 다만 해당 프로젝트에서는 RxSwift를 집중적으로 공부해보고 싶어 사용하지 않았습니다.
   

## Server Driven UI
<img width="500" src="https://github.com/ddophi98/ShoppingSearchApp/assets/72330884/4048d22e-5310-4ae4-b626-ad2bfd377ed8">

- 서버에서 보내주는 Response에 맞춰서 UI가 동적으로 변경되도록 할 수 있습니다.   
  ex) 현재 화면에서는 광고의 위치를 동적으로 조정할 수 있습니다.
- 이를 응용한다면 뷰의 위치뿐만 아니라 글씨 크기, 색상 등도 Response로 내려주고 동적으로 업데이트할 수 있습니다.
- 클라이언트측에서 직접 UI를 수정할 경우, 오래 걸리는 앱 심사와 유저가 앱 업데이트를 하지 않는 문제를 극복하기 위해 해당 기술을 활용할 수 있습니다.
- [전체 JSON 확인하기](https://gist.githubusercontent.com/ddophi98/14535628aa282fb22a1284d3bebc5a83/raw/03e1a370779df0ea9e2a47d0f88e0205eda48a0e/JsonForServerDrivenUI)

## TableView, CollectionView
가로 스크롤, 세로 스크롤이 공존하는 화면을 만들고자 했고 두가지 방법을 시도했습니다.

#### 상품검색 화면
<img width="1000" src="https://github.com/ddophi98/ShoppingSearchApp/assets/72330884/b723d2ec-4524-41c6-ad50-0e7c86846d4c">

- 첫번째 방법은 CollectionView만 사용하는 것이었습니다.
- UICollectionViewCompositionalLayout을 사용하면서 특정 섹션에 orthogonalScrollingBehavior 속성을 줬습니다.
- CollectionView만 사용해서 만들 수 있기에 비교적 간단했고 특정 섹션만 스크롤 방향을 변경할 수 있다는 것이 편리했습니다.

#### 장바구니 화면
<img width="1000" src="https://github.com/ddophi98/ShoppingSearchApp/assets/72330884/77f9ffb4-c0e6-4a76-8670-0a6301f05d95">

- 두번째 방법은 TableView를 먼저 정의하고, TableView의 Cell 중 하나를 CollectionView로 정의하는 것이었습니다.   
- CollectionView에서는 UICollectionViewFlowLayout를 사용하면서 scrollDirection 속성을 horizontal로 지정했습니다.   
- TableView, CollectionView를 모두 정의해야했기에 비교적 복잡했고, scrollDirection은 CollectionView의 모든 섹션에 적용되어버리는 제한 사항이 존재했습니다.

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
<img width="700" src="https://github.com/ddophi98/ShoppingSearchApp/assets/72330884/4a452664-d33a-4a20-9c05-17123df63755">

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

## TTI (Time To Interactive)
<img width="900" src="https://github.com/ddophi98/ShoppingSearchApp/assets/72330884/8debb3fd-98e3-47e4-baae-486b92f9553a">

#### TTI
- 유저가 새로운 화면에 진입했을 때, 최초의 행동을 할 수 있기까지의 시간을 의미합니다.
- 화면에 유의미한 정보가 나타나기까지 여러 작업을 거쳐야 하는데, 각각의 작업이 완료되는 시간을 측정할 수 있습니다.
- 타임라인을 통해 시간이 과도하게 걸리지 않는다는 것을 확인함으로써, 서비스의 품질을 유지할 수 있습니다.
- 만약 문제가 있다고 판단된다면, 어느 구간에서 시간이 오래 걸리는지 확인할 수 있습니다.

#### 구간 설정
        loadView: View가 메모리에 로드 되는 시점입니다. viewDidLoad 함수가 호출될 때 시간을 측정했습니다.
        drawView: View가 화면에 나타나는 시점입니다. viewDidAppear 함수가 호출될 때 시간을 측정했습니다.
        sendRequest: 네트워크 통신을 하기 위해 request를 보내는 시점입니다. 
        receiveResponse: 네트워크 통신을 통해 response를 받는 시점입니다.
        bindData: ViewModel의 데이터가 변하면서, 데이터 바인딩으로 View에 신호가 가는 시점입니다.
        drawCoreComponent: 핵심적이거나 시간이 걸릴 수 있는 컴포넌트가 완성되는 시점입니다. 현재 프로젝트에서는 첫번째 이미지 다운이 완료되는 시간으로 측정했습니다.
- 각각의 작업 사이의 시간차를 계산함으로써 구간마다 걸리는 시간을 로그로 기록했습니다.
- 프로젝트 특성에 따라 측정하고자 하는 작업이나 구간이 달라질 수 있습니다.    
  ex) MTS 앱이라면 차트가 완성되는 시점을 측정해야할 것입니다.


## Deep Link
<img width="800" src="https://github.com/ddophi98/ShoppingSearchApp/assets/72330884/b75625fb-f4e3-46ce-a837-5cd04ecb6807">

- iOS에서 Deep Link를 사용하기 위해서는 크게 URI Scheme 방식과 Universal Link 방식으로 나누어집니다.
- Universal Link 방식은 특정 도메인 주소를 소유하고 있어야 하기에, URI Scheme 방식으로 구현했습니다.
- Deep Link 정책은 프로젝트 특성에 따라 달라질 수 있으며, 해당 프로젝트에서는 아래와 같은 정책을 사용했습니다.
  
    - 기존에 존재하던 화면은 모두 없애버리고, Deep Link로 이동한 화면만 나타나게 하기   
    - Detail 화면과 같이 depth가 있는 경우, 이전 화면도 Navigation 스택에 집어넣기
  
