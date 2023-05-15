//
//  ToDoList.swift
//  ToDoList
//
//  Created by Lei on 2023/5/15.
//

import Foundation

struct ToDoItem {
    var title: String
    var description: String
    var createdDate: String
    var dueDate: String
    var location : String
    
    init(title: String = "Title", description: String = "Description", createdDate: String = "2023/05/15", dueDate: String = "2023/05/16", location: String = "TestLocation") {
        self.title = title
        self.description = description
        self.createdDate = createdDate
        self.dueDate = dueDate
        self.location = location
    }
}
