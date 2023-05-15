//
//  ToDoListViewModel.swift
//  ToDoList
//
//  Created by Lei on 2023/5/15.
//

import Foundation

class ToDoListViewModel {
    var todoList = [ToDoItem]()
    
    var sortedList: [ToDoItem] { toDoListCache }
    
    private var toDoListCache: [ToDoItem] = [
        .init(title: "See a doctor", description: "Take the Bus 123"),
        .init(title: "Do the laundry", description: "Must done today!"),
        .init(title: "Send the parcel", description: "To Tom")
    ]
    
    func addNewItem(title: String, description: String, createdDate: Date, dueDate: Date, location: String) {
       
    }
    
    func dateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
