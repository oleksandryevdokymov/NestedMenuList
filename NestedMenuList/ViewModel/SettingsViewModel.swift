//
//  SettingsViewModel.swift
//  NestedList
//
//  Created by Oleksandr Yevdokymov on 22.06.2021.
//

import UIKit
import IGListKit

final class SettingsViewModel: ListDiffable {
    private(set)
    var settings: [SettingsItemModel]
    
    init(settings: [SettingsItemModel]) {
        self.settings = settings
    }
    
    // MARK: - ListDiffable
    func diffIdentifier() -> NSObjectProtocol {
        return String("\(settings)") as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? SettingsViewModel else { return false }
        return settings == object.settings
    }
}
