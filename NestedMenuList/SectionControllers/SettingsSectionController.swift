//
//  SettingsSectionController.swift
//  NestedList
//
//  Created by Oleksandr Yevdokymov on 18.06.2021.
//

import Foundation
import IGListKit
import Combine

class SettingsSectionController: ListSectionController,
                                 ListSupplementaryViewSource {
    private var viewModel: SettingsViewModel!
    private let sectionModel = TitleSectionModel(title: "User preferences")
    
    override init() {
        super.init()
        supplementaryViewSource = self
    }
    
    // MARK: - ListSectionController Data Provider
    override func didUpdate(to object: Any) {
        viewModel = object as? SettingsViewModel
    }
    
    override func numberOfItems() -> Int {
        return viewModel.settings.count
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else {
          return .zero
        }
        let width = context.containerSize.width
        return CGSize(width: width, height: 50)
    }
    
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let setting = viewModel.settings[index]
        let cell = collectionContext!.dequeueReusableCell(of: SettingsCell.self, for: self, at: index) as! SettingsCell
        cell.setup(title: setting.title)
        return cell
    }
    
    override func didSelectItem(at index: Int) {
        let setting = viewModel.settings[index]
        print("Did select: \(setting.title)")
        // TODO: - implement navigation
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


