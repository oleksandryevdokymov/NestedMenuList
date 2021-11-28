//
//  OutlineViewModel.swift
//  NestedList
//
//  Created by Oleksandr Yevdokymov on 22.06.2021.
//

import UIKit
import IGListKit

final class OutlineViewModel: ListDiffable {
    private let menuService = MenuService()
    private var data: [OutlineItem]
    private(set) var items: [OutlineItem] = []
    
    init() {
        self.data = menuService.fetchMenuData()
        decomposeData(with: data)
    }
    
    func update() {
        items = []
        decomposeData(with: self.data)
    }
    
    func reset() {
        self.data = menuService.fetchMenuData()
        items = []
        decomposeData(with: self.data)
    }
    
    private func decomposeData(with listItems: [OutlineItem]) {
        for item in listItems {
            items.append(item)
            if !item.subitems.isEmpty && item.expanded {
                decomposeData(with: item.subitems)
            }
        }
    }
    
    // MARK: - ListDiffable
    func diffIdentifier() -> NSObjectProtocol {
        return String("\(data)") as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? OutlineViewModel else { return false }
        return data == object.data
    }
}
