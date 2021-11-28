//
//  OutlineItem.swift
//  NestedList
//
//  Created by Oleksandr Yevdokymov on 15.06.2021.
//

import UIKit
import IGListKit

enum DepthLevel {
    case first
    case second
    case third
}

final class OutlineItem: Equatable, ListDiffable  {
    let title: String
    let depthLevel: DepthLevel
    let subitems: [OutlineItem]
    var expanded: Bool
    
    init(title: String,
         depthLevel: DepthLevel = .first,
         expanded: Bool = false,
         subitems: [OutlineItem] = []) {
        self.title = title
        self.depthLevel = depthLevel
        self.expanded = expanded
        self.subitems = subitems
    }
    
    static func == (lhs: OutlineItem, rhs: OutlineItem) -> Bool {
        return lhs.title == rhs.title &&
            lhs.depthLevel == rhs.depthLevel &&
            lhs.expanded == rhs.expanded &&
            lhs.subitems == rhs.subitems
    }
    
    // MARK: - ListDiffable
    func diffIdentifier() -> NSObjectProtocol {
        return String("\(title) + \(depthLevel) + \(subitems) + \(expanded)") as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? OutlineItem else { return false }
        return title == object.title &&
            depthLevel == object.depthLevel &&
            expanded == object.expanded &&
            subitems == object.subitems
    }
}
