//
//  SearchHomeViewController.swift
//  ddonawa
//
//  Created by 강한결 on 10/25/24.
//

import UIKit
import Combine

import SnapKit

final class SearchHomeViewController: UIViewController {
   // MARK: diffable datasource 정의
   private typealias DiffableDatasource = UICollectionViewDiffableDataSource<Section, AnyHashable>
   // MARK: dataSnapshot 정의
   private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>
   
   private enum Section: Int {
      case banner
      case separateLine1
      case horizontalProductItem
      case separateLine2
      case verticalProductItem
   }
   private lazy var dataSource: DiffableDatasource = setDatasource()
   private let viewModel: SearchHomeViewModel = .init()
   private var currentSection: [Section] {
      return dataSource.snapshot().sectionIdentifiers as [Section]
   }
   private var store = Set<AnyCancellable>()
   
   private lazy var collectionView: UICollectionView =  {
      let view = UICollectionView(frame: .zero, collectionViewLayout: setCollectionSection())
      view.register(HorizontalBannerCell.self, forCellWithReuseIdentifier: HorizontalBannerCell.id)
      view.register(VerticalBannerCell.self, forCellWithReuseIdentifier: VerticalBannerCell.id)
      view.register(SeperatorViewCell.self, forCellWithReuseIdentifier: SeperatorViewCell.id)
      view.register(ReusableHeaderView.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: ReusableHeaderView.id)
      view.delegate = self
      return view
   }()

   override func viewDidLoad() {
      super.viewDidLoad()
      bindingViewModelState()
      setView()
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      configureNav(navTitle: viewModel.searchText, left: _genLeftGoBackBarButton(), right: nil)
   }
   
   private func setView() {
      view.backgroundColor = .white
      view.addSubviews(for: collectionView)
      collectionView.snp.makeConstraints { make in
         make.edges.equalTo(view.safeAreaLayoutGuide)
      }
   }
   
   func setSearchText(_ searchText: String) {
      viewModel.send(action: .setSearchText(text: searchText))
   }
}

extension SearchHomeViewController {
   private func setCollectionSection() -> UICollectionViewCompositionalLayout {
      return UICollectionViewCompositionalLayout { [weak self] section, _ in
         switch self?.currentSection[section] {
         case .banner:
            return HorizontalBannerCell.setCellLayout()
         case .horizontalProductItem:
            return VerticalBannerCell.setCollectionHLayout()
         case .separateLine1, .separateLine2:
            return SeperatorViewCell.setCollectionLayout()
         case .verticalProductItem:
            return VerticalBannerCell.setCollectionVLayout()
         case .none:
            return nil
         }
      }
   }
   
   private func setDatasource() -> DiffableDatasource {
      let source: DiffableDatasource = UICollectionViewDiffableDataSource(collectionView: collectionView) {
         [weak self] collectionView, indexPath, viewItem in
         guard let self else { return .init() }
         
         return setCollectionViewCell(collectionView, indexPath, viewItem)
      }
      
      source.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
         guard kind == UICollectionView.elementKindSectionHeader,
               let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                            withReuseIdentifier: ReusableHeaderView.id,
                                                                            for: indexPath)
                  as? ReusableHeaderView,
               let viewItems = self?.viewModel.collectionViewItems.headerViewItems
         else { return .init() }
         header.setViewItem(viewItems[indexPath.section])
         return header
      }
      
      return source
   }
   
   private func setCollectionViewCell(_ collectionView: UICollectionView,
                                      _ indexPath: IndexPath,
                                      _ viewItem: AnyHashable) -> UICollectionViewCell {
      switch currentSection[indexPath.section] {
      case .banner:
         guard let viewItem = viewItem as? HorizontalBannerCellItem,
               let cell = collectionView.dequeueReusableCell(
                  withReuseIdentifier: HorizontalBannerCell.id,
                  for: indexPath) as? HorizontalBannerCell
         else { return .init() }
         cell.setViewItem(viewItem)
         return cell
      case .horizontalProductItem, .verticalProductItem:
         guard let viewItem = viewItem as? VerticalSearchingViewItem,
               let cell = collectionView.dequeueReusableCell(
                  withReuseIdentifier: VerticalBannerCell.id,
                  for: indexPath) as? VerticalBannerCell
         else { return .init() }
         cell.setViewItem(viewItem, didTapLikeButton: viewModel.didTapLikeButton)
         return cell
      case .separateLine1, .separateLine2:
         guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SeperatorViewCell.id,
            for: indexPath) as? SeperatorViewCell
         else { return .init() }
         cell.setViewItem(viewModel.collectionViewItems.seperatorViewItems)
         return cell
      }
   }
   
   private func setApplySnapshot() {
      var snapshot: Snapshot = .init()
      
      if let horizontalBannerViewItems = viewModel.collectionViewItems.horizontalBannerViewItems {
         snapshot.appendSections([.banner])
         snapshot.appendItems(horizontalBannerViewItems, toSection: .banner)
         snapshot.appendSections([.separateLine1])
         snapshot.appendItems([viewModel.collectionViewItems.seperatorViewItems], toSection: .separateLine1)
      }
      
      if let verticalBannerViewItems = viewModel.collectionViewItems.horizontalAndVerticalViewItems {
         snapshot.appendSections([.horizontalProductItem])
         snapshot.appendItems(verticalBannerViewItems, toSection: .horizontalProductItem)
         
         snapshot.appendSections([.separateLine2])
         snapshot.appendItems([viewModel.collectionViewItems.seperatorViewItems], toSection: .separateLine2)
      }
      
      if let verticalHalfBannerViewItems = viewModel.collectionViewItems.verticalHalfBannerViewItems {
         snapshot.appendSections([.verticalProductItem])
         snapshot.appendItems(verticalHalfBannerViewItems, toSection: .verticalProductItem)
      }
      
      dataSource.apply(snapshot)
   }
   
   private func bindingViewModelState() {
      viewModel.$collectionViewItems
         .receive(on: DispatchQueue.main)
         .sink { [weak self] _ in
            guard let self else { return }
            setApplySnapshot()
         }
         .store(in: &store)
      
      viewModel.send(action: .search)
   }
}

extension SearchHomeViewController: UICollectionViewDelegate {
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      switch currentSection[indexPath.section] {
      case .horizontalProductItem:
         if let viewItems = viewModel.collectionViewItems.horizontalAndVerticalViewItems {
            let vc = VCSearchingDetail()
            print(viewItems[indexPath.row].item)
            vc.setVCWithData(viewItems[indexPath.row].item)
            navigationController?.pushViewController(vc, animated: true)
         }
      case .verticalProductItem:
         if let viewItems = viewModel.collectionViewItems.verticalHalfBannerViewItems {
            let vc = VCSearchingDetail()
            vc.setVCWithData(viewItems[indexPath.row].item)
            navigationController?.pushViewController(vc, animated: true)
         }
      default:
         break
      }
   }
}
