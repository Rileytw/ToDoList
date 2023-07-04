//
//  ItemList.swift
//  ToDoList
//
//  Created by Lei on 2023/7/4.
//

import Foundation

enum ItemList: Int, CaseIterable {
    case title
    case description
    case createdDate
    case dueDate
    case location
    
    var titleName: String {
        switch self {
        case .title:
            return "Title"
        case .description:
            return "Description"
        case .createdDate:
            return "Created Date"
        case .dueDate:
            return "Due Date"
        case .location:
            return "Location"
        }
    }
}
