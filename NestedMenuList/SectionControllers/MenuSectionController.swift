//
//  MenuSectionController.swift
//  NestedList
//
//  Created by Oleksandr Yevdokymov on 15.06.2021.
//

import Foundation
import IGListKit
import Combine

enum MenuSelectionType {
    case cell(OutlineItem)
    case discloseButton(OutlineItem)
}

class MenuSectionController: ListSectionController,
                             ListSupplementaryViewSource {
    private var viewModel: OutlineViewModel!
    private var disposables = Set<AnyCancellable>()
    public var publisher = PassthroughSubject<MenuSelectionType, Never>()
    private let sectionModel = TitleSectionModel(title: "Menu list")

    override init() {
        super.init()
        supplementaryViewSource = self
    }
    
    func handleDiscloseButtonTapped(with menuItem: OutlineItem) {
        menuItem.expanded.toggle()
        viewModel.update()
        publisher.send(.discloseButton(menuItem))
        cleanPublishers()
        collectionContext?.performBatch(animated: true, updates: { batchContect in
            batchContect.reload(self)
        }, completion: nil)
    }
    
    deinit {
        cleanPublishers()
    }
    
    private func cleanPublishers() {
        disposables.removeAll()
    }
    
    // MARK: - ListSectionController Data Provider
    override func didUpdate(to object: Any) {
        viewModel = object as? OutlineViewModel
    }
    
    override func numberOfItems() -> Int {
        return viewModel.items.count
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else {
          return .zero
        }
        let width = context.containerSize.width
        return CGSize(width: width, height: 50)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let menuItem = viewModel.items[index]
        let cell = collectionContext!.dequeueReusableCell(of: MenuCell.self, for: self, at: index) as! MenuCell
        cell.setup(with: menuItem)
        cell.publisher.sink { [weak self] menuItem in
            guard let self = self else { return }
            self.handleDiscloseButtonTapped(with: menuItem)
        }
        .store(in: &disposables)
        return cell
    }

    override func didSelectItem(at index: Int) {
        let menuItem = viewModel.items[index]
        publisher.send(.cell(menuItem))
    }
    
    // MARK: - ListSupplementaryViewSource
    func supportedElementKinds() -> [String] {
        return  [UICollectionView.elementKindSectionHeader]
    }
    
    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        guard let view = collectionContext!.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: self, class: SectionHeaderView.self, at: index) as? SectionHeaderView else {
            return UICollectionReusableView()
        }
        view.setup(title: sectionModel.title)
        return view
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        guard let context = collectionContext else {
          return .zero
        }
        let width = context.containerSize.width
        return CGSize(width: width, height: 77)
    }
}


