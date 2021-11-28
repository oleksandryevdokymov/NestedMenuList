//
//  MenuItemsService.swift
//  NestedList
//
//  Created by Oleksandr Yevdokymov on 17.06.2021.
//

import Foundation

class MenuService {
    func fetchMenuData() -> [OutlineItem] {
        let menuData = [
            OutlineItem(title: "News", depthLevel: .first, subitems: [
                OutlineItem(title: "Europe", depthLevel: .second),
                OutlineItem(title: "World", depthLevel: .second),
                OutlineItem(title: "Special", depthLevel: .second),
                OutlineItem(title: "Podcast", depthLevel: .second)]),
            OutlineItem(title: "Sport", depthLevel: .first, subitems: [
                OutlineItem(title: "Ball sections", depthLevel: .second, subitems: [
                    OutlineItem(title: "Baseball", depthLevel: .third),
                    OutlineItem(title: "Basketball", depthLevel: .third),
                    OutlineItem(title: "Water Polo", depthLevel: .third),
                    OutlineItem(title: "Freeze Ball", depthLevel: .third)
                    ]),
                OutlineItem(title: "Euro 2020", depthLevel: .second, subitems: [
                    OutlineItem(title: "Results", depthLevel: .third),
                    OutlineItem(title: "Review", depthLevel: .third),
                    OutlineItem(title: "Scores", depthLevel: .third)
                    ]),
                OutlineItem(title: "Tennis", depthLevel: .second),
            ]),
            OutlineItem(title: "Other", depthLevel: .first)
        ]
        return menuData
    }
}
