#  MarketSearcher

**목차**

- [프로젝트 소개](#프로젝트-소개)
- [프로젝트 스택](#프로젝트-스택)
- [프로젝트 고민 사항](#프로젝트-고민-사항)

<br />

## 프로젝트 소개

사고 싶은 물건을 검색하고 웹 뷰로 살펴보면서, 나만의 장바구니 목록을 만드는 앱

- 개발 인원 : 강한결 (1인 프로젝트)
- 기간 : 2024.06.12 - 18
- 최소 버전 : iOS 15
- 주요 기능
  - 네이버 쇼핑 API를 활용한 상품 키워드 검색
  - 검색한 상품 상세 페이지 Webview에서 확인
  - 사고 싶은 상품을 나만의 장바구니에 저장 (로컬 데이터베이스 활용)
  - 앱 네트워크 연결 상태 모니터링
- 주요 화면
  |상품 검색|상품 리스트 1|상품 리스트 2|상품 상세 웹뷰|네트워크 에러 뷰|
  |:-:|:-:|:-:|:-:|:-:|
  |<img width="150" src="https://github.com/user-attachments/assets/be7b75dc-2755-4998-bae4-0a0907a7d4ea" />|<img width="150" src="https://github.com/user-attachments/assets/403e2e10-8904-49bc-8703-cb482955b047" />|<img width="150" src="https://github.com/user-attachments/assets/76fb3427-14a8-498f-91b6-4212258304a3" />|<img width="150" src="https://github.com/user-attachments/assets/d3611f1a-91e2-4fc0-800e-5051436ceeec" />|<img width="150" src="https://github.com/user-attachments/assets/867c2ba9-fd12-45e7-9dae-62e46e8d7109" />|

<br />

## 프로젝트 스택

> **UIKit, Snapkit, WebView**
>
> - 네트워크 통신 및 데이터베이스 데이터를 바인딩하여 UIKit으로 **코드베이스 View**를 구성했습니다.
>   - TableView, CollectionView를 통해 재사용 가능한 Cell을 활용했습니다.
>   - Snapkit으로 View 요소간 AutoLayout을 설정할 수 있었습니다.
> - WKWebView를 이용하여 검색 결과에서 확인한 상품 상세 링크를 앱 화면에서 띄울 수 있었습니다.

<br />

> **Naver 검색 API, RealmSwift**
>  
> - Naver 검색 API를 활용해 유저가 검색한 상품을 조회하는 네트워크 통신을 구현했습니다.
> - RealmSwift로 유저의 검색 키워드, 좋아요한 상품 리스트를 관리할 수 있었습니다.

<br />

> **CompositionalLayout, DiffableDatasource**
>
> - **CompositionalLayout을 적용**하여 **섹션 단위로 CollectionView의 레이아웃을 설정**하고, **Cell의 크기와 형태를 보다 유연하게 지정**할 수 있었습니다.
> - **DiffableDatasoure의 snapshot**를 적용해서 **바인딩할 데이터의 index에 신경쓰지 않고 데이터 업데이트에 따라 reloadData 호출 없이 View가 업데이트** 될 수 있게 했습니다.

<br />

> **Network 모듈**
>
> - Network 모듈의 **`NWPathMonitor` 를 이용해 앱의 네트워크 상태를 계속 확인하는 서비스 객체**를 구현했습니다.
> - **SceneDelegate에서 서비스 객체가 네트워크 상태를 계속 확인**하고, 네트워크 연결이 중단된 경우 **구현한 `displayNetworkConnectionErrorView` 메서드를 통해 NetworkErrorView로 교환**했습니다.

<br />

## 프로젝트 고민 사항

### 1. CompositionalLayout, DiffableDatasource을 이용한 CollectionView의 다양한 레이아웃 구성

1️⃣ 고민한 부분

- UICollectionViewFlowLayout으로 CollectionView의 레이아웃을 잡아줄 경우, 제한된 레이아웃에 Cell을 모두 적용해야 한다는 단점이 있었습니다.
- 검색 결과를 특정 기준으로 필터링하여 전달 받을 수 있었기 때문에, 다양한 섹션에 다양한 레이아웃으로 상품 리스트를 보여주고 싶었습니다.
<br />

2️⃣ 고민을 풀어낸 방식

- Section 열거형에 섹션 종류를 정의했습니다. `setCollectionSection` 이라는 메서드를 구현하여 내부에서 섹션 케이스별로 어떤 CompositionalLayout을 반환할 지 분기했습니다.
  - 각 섹션에서 재사용할 CollectionViewCell의 타입 메서드로 `NSCollectionLayoutSection` 객체를 반환하도록 구현했습니다. 메서드 내부에서 item, group, section에 대한 반응형 사이즈를 계산했습니다.
    ```swift
    private func setCollectionSection() -> UICollectionViewCompositionalLayout {
      return UICollectionViewCompositionalLayout { [weak self] section, _ in
         switch self?.currentSection[section] {
         case .banner:
            return HorizontalBannerCell.setCellLayout()
         case .horizontalProductItem:
            return VerticalBannerCell.setCollectionHLayout()
         case .separateLine1, .separateLine2: // 섹션별 구분선
            return SeperatorViewCell.setCollectionLayout()
         case .verticalProductItem:
            return VerticalBannerCell.setCollectionVLayout()
         case .none:
            return nil
         }
       }
    }
    ```

- DiffableDatasource과 Snapshot 역시 Section 열거형을 기준으로 설정될 수 있게 타입을 정의했습니다. `UICollectionViewDiffableDataSource<Section, AnyHashable>`, `NSDiffableDataSourceSnapshot<Section, AnyHashable>` 
  - datasource를 맵핑하는 함수에서는 각 섹션마다 어떤 재사용 Cell이 사용되는지를 switch 구문으로 바인딩했습니다. 해당 구문에서 재사용 Cell 객체마다 필요한 데이터를 바인딩 했습니다.
    ```swift
    private func setCollectionViewCell(_ collectionView: UICollectionView,
                                      _ indexPath: IndexPath,
                                      _ viewItem: AnyHashable) -> UICollectionViewCell {
      switch currentSection[indexPath.section] {
      case .banner:
         guard let viewItem = viewItem as? HorizontalBannerCellItem,
               let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalBannerCell.id,
                                                             for: indexPath) as? HorizontalBannerCell
         else { return .init() }
         cell.setViewItem(viewItem)
         return cell
      ...
      }
    }
    ```
 - viewDidLoad에서는 각 섹션에 데이터를 직접적으로 바인딩하는 Snapshot을 업데이트하는 메서드(`setApplySnapshot`)를 호출했습니다.
   ```swift
   private func setApplySnapshot() {
      var snapshot: NSDiffableDataSourceSnapshot<Section, AnyHashable> = .init()
      
      if let horizontalBannerViewItems = viewModel.collectionViewItems.horizontalBannerViewItems {
         snapshot.appendSections([.banner])
         snapshot.appendItems(horizontalBannerViewItems, toSection: .banner)

         // 섹션 아래에 SeperatorCell을 함께 반영해주었습니다.
         snapshot.appendSections([.separateLine1])
         snapshot.appendItems([viewModel.collectionViewItems.seperatorViewItems], toSection: .separateLine1)
      }
      ...

      datasource(apply: snapshot)
   }
   ```

-  ViewModel에서 검색 API 통신으로 처리된 상품 데이터를 맵핑하여 View가 구독할 수 있도록 설정했습니다. Snapshot에 바인딩되는 데이터는 개별적으로 고유해야 하기 때문에, 각 Cell 코드에서 필요로 하는 데이터 타입이 Hashable 프로토콜을 채택할 수 있게 지정했습니다. Published한 데이터를 Snapshot 형태로 CollectionView에 바인딩했기 때문에 검색이 일어날 떄마다 reloadData 호출없이 View를 업데이트 할 수 있었습니다.
    ```swift
    // ViewModel
    @Published
    var collectionViewItems: CollectionViewItems = .init()

    
    // ViewController
    viewModel.$collectionViewItems
         .receive(on: DispatchQueue.main)
         .sink { [weak self] _ in
            guard let self else { return }
            setApplySnapshot() // snapshot을 각 섹션마다 datasource에 업데이트
         }
         .store(in: &store)
    ```

<br />

### 2. Network 모듈을 활용한 전역 네트워크 모니터링 

1️⃣ 고민한 부분

- 상품 검색 요청이 들어오면, 최대 4개의 경우에 대해서 네트워크 요청을 보내야해서 자원 관리가 중요했습니다. 네트워크 끊기면 불필요한 네트워크 요청을 보내지 않고, 네트워크 통신을 계속 기다리지 않도록 확인해야 했습니다.
<br />

2️⃣ 고민을 풀어낸 방식

- Network 모듈은 `NWPathMonitor` 라는 네트워크 연결 검증 객체를 제공했습니다. NWPathMonitor를 활용하는 NetworkMonitorService 객체를 구현하여 SceneDelegate에 바인딩했습니다.
  - 모니터 인스턴스의 `.pathUpdateHandler` 클로저 내부에서 `path.status` 속성으로 네트워크 연결을 지속적으로 확인할 수 있었습니다. 상태값이 .satisfied 일 경우, SceneDelegate가 바인딩하는 isConnected 변수값을 true로 설정했습니다.
  ```swift
  final class NetworkMonitorService {
   static let manager: NetworkMonitorService = .init()
   private init() {}

   private let queue = DispatchQueue(label: "network_monitor")
   private let monitor = NWPathMonitor()
   private(set) var isConnected: Bool = false
   
   func startMonitoring(completionHandler: @escaping (Bool) -> Void) {
      monitor.start(queue: queue)
      monitor.pathUpdateHandler = { [weak self] path in
         guard let self else { return }
         isConnected = path.status == .satisfied // .satisfied일 경우 네트워크가 연결되고 있는 상태
         
         DispatchQueue.main.async {
            completionHandler(self.isConnected)
         }
      }
    }

    func stopMonitoring() {
      monitor.cancel()
    }
  }
  ```

- SceneDelegate의 willConnectToSession 메서드에서 네트워크 모니터링 메서드를 호출해 네트워크 연결을 추적했습니다. 네트워크가 연결된 상태에 따라 UIWindo가 어떤 뷰를 보여줘야 하는지 분기를 나눴습니다.
  - 네트워크 연결이 끊기는 경우 `NetworkErrorView`가 보여질 수 있도록 `displayNetworkConnectionErrorView` 메서드를 startMonitoring 메서드에서 호출했습니다.
    ```swift
    private func displayNetworkConnectionErrorView(_ scene: UIScene) {
      guard let scene = scene as? UIWindowScene else { return }
      window = UIWindow(windowScene: scene)
      window?.windowLevel = .normal
      window?.addSubview(NetworkErrorView(frame: window?.bounds ?? CGRect(x: 0, y: 0, width: 100, height: 300)))
      window?.makeKeyAndVisible()
    }
    ```
  - SceneDelegate의 sceneDidDisconnect 구문에서 앱의 Scene이 종료되면 모니터링을 종료하는 stopMonitoring 메서드를 호출하여 불필요한 네트워크 모니터링을 멈출 수 있도록 설정했습니다.

<br />
