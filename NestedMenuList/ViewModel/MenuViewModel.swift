//
//  MenuViewModel.swift
//  NestedList
//
//  Created by Oleksandr Yevdokymov on 17.06.2021.
//

import UIKit
import IGListKit

final class MenuViewModel {
    private let menuItems: OutlineViewModel = OutlineViewModel()
    private let settings: SettingsViewModel = SettingsViewModel(settings: [
        SettingsItemModel(settingTitle: "Tracking"),
        SettingsItemModel(settingTitle: "Personal"),
        SettingsItemModel(settingTitle: "Push notifications")]
    )
    
    var items: [ListDiffable] {
        return [menuItems, settings]
    }
}


