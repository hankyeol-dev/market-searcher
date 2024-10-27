//
//  SearchHomeViewModel.swift
//  ddonawa
//
//  Created by 강한결 on 10/25/24.
//

import Foundation
import Combine

final class SearchHomeViewModel {
   enum Action {
      case search
      case searchSuccess(responses: [ProductResult])
      case searchFail(response: Error)
      
      case didTapLikeButton(productId: String)
      
      case setSearchText(text: String)
   }
   
   struct CollectionViewItems {
      var seperatorViewItems: SeperatorViewItem = .init()
      var headerViewItems: [ReusableHeaderViewItem]?
      var horizontalBannerViewItems: [HorizontalBannerCellItem]?
      var horizontalAndVerticalViewItems: [VerticalSearchingViewItem]?
      var verticalHalfBannerViewItems: [VerticalSearchingViewItem]?
   }
   
   @Published
   var collectionViewItems: CollectionViewItems = .init()
   
   var didTapLikeButton: PassthroughSubject<String, Never> = .init()
   
   private let productRepository: Repository<RealmProduct> = .init()
   var searchText: String = ""
   private var loadTask: Task<Void, Never>?
   private var store = Set<AnyCancellable>()
   
   func send(action: Action) {
      switch action {
      case .search:
         search()
      case let .searchSuccess(response):
         mappingData(response)
      case let .searchFail(response):
         print(response)
      case let .didTapLikeButton(productId):
         print(productId)
      case let .setSearchText(text):
         setSearchText(text)
      }
   }
   
   init() {
      transformLikeProduct()
   }
   
   deinit {
      loadTask?.cancel()
   }
}

extension SearchHomeViewModel {
   private func search() {
      loadTask?.cancel()
      loadTask = Task {
         do {
            let inputType1: APIService.APIInputType = .init(query: searchText, sort: .sim)
            let inputType2: APIService.APIInputType = .init(query: searchText, sort: .date)
            let inputType3: APIService.APIInputType = .init(query: searchText, sort: .dsc)
            let response1 = try await APIService.manager.fetch(inputType1, of: ProductResult.self)
            let response2 = try await APIService.manager.fetch(inputType2, of: ProductResult.self)
            let response3 = try await APIService.manager.fetch(inputType3, of: ProductResult.self)
            send(action: .searchSuccess(responses: [response1, response2, response3]))
         } catch {
            send(action: .searchFail(response: error))
         }
      }
   }
   
   private func mappingData(_ responses: [ProductResult]) {
      Task { await mappingHeaderViewItems() }
      Task { await mappingHorizontalBannerViewItems(responses[0]) }
      Task { await mappingHorizontalAndVerticalBannerViewItems(responses[1])}
      Task { await mappingVerticalHalfBannerViewItems(responses[2])}
   }
   
   @MainActor
   private func mappingHeaderViewItems() async {
      let headers: [String] = ["정확도 순서 (10개)",
                               "",
                               "최신 날짜 순서 (10개)",
                               "",
                               "가격 높은 순서 (10개)",
                               ""]
      collectionViewItems.headerViewItems = headers.map { .init(headerTitle: $0) }
   }
   
   @MainActor
   private func mappingHorizontalBannerViewItems(_ response: ProductResult) async {
      collectionViewItems.horizontalBannerViewItems = response.items.map { item in
         return .init(imageURL: item.image)
      }
   }
   
   @MainActor
   private func mappingHorizontalAndVerticalBannerViewItems(_ response: ProductResult) async {
      collectionViewItems.horizontalAndVerticalViewItems = response.items.map { item in
         return .init(isLiked: productRepository.getRecordById(item.productId) != nil, item: item)
      }
   }
   
   @MainActor
   private func mappingVerticalHalfBannerViewItems(_ response: ProductResult) async {
      collectionViewItems.verticalHalfBannerViewItems = response.items.map { item in
         return .init(isLiked: productRepository.getRecordById(item.productId) != nil, item: item)
      }
   }
   
   private func transformLikeProduct() {
      didTapLikeButton.receive(on: DispatchQueue.main)
         .sink { [weak self] productId in
            self?.send(action: .didTapLikeButton(productId: productId))
         }
         .store(in: &store)
   }
   
   private func setSearchText(_ text: String) {
      loadTask?.cancel()
      searchText = text
   }
}
