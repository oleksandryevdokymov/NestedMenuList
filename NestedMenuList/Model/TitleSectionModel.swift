//
//  SectionTitleModel.swift
//  NestedList
//
//  Created by Oleksandr Yevdokymov on 17.06.2021.
//

import Foundation
import IGListKit

final class TitleSectionModel: ListDiffable {
    let title: String
    
    init(title: String) {
        self.title = title
    }
    
    // MARK: - ListDiffable
    func diffIdentifier() -> NSObjectProtocol {
        return title as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? TitleSectionModel else { return false }
        return title == object.title
    }
}
