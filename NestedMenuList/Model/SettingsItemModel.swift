//
//  SettingsItemModel.swift
//  NestedList
//
//  Created by Oleksandr Yevdokymov on 18.06.2021.
//

import Foundation
import IGListKit

class SettingsItemModel: ListDiffable, Equatable {
    let title: String
    
    init(settingTitle: String) {
        self.title = settingTitle
    }
    static func == (lhs: SettingsItemModel, rhs: SettingsItemModel) -> Bool {
        return lhs.title == rhs.title
    }
    
    // MARK: - ListDiffable
    func diffIdentifier() -> NSObjectProtocol {
        return title as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? SettingsItemModel else { return false }
        return title == object.title
    }
}
