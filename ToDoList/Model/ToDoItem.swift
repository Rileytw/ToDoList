//
//  ToDoList.swift
//  ToDoList
//
//  Created by Lei on 2023/5/15.
//

import Foundation

struct ToDoItem: Hashable, Codable {
    var title: String
    var description: String
    var createdDate: Date
    var dueDate: Date
    var location : String
    var id: UUID?
    
    init(title: String = "Title",
         description: String = "Description",
         createdDate: Date = Date(),
         dueDate: Date = Date(),
         location: String = "TestLocation",
         id: UUID? = UUID()) {
        self.title = title
        self.description = description
        self.createdDate = createdDate
        self.dueDate = dueDate
        self.location = location
        self.id = id
    }
}
