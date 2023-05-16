//
//  ToDoListViewModel.swift
//  ToDoList
//
//  Created by Lei on 2023/5/15.
//

import Foundation
import Combine

class ToDoListViewModel: ObservableObject {
    @Published var todoList: [ToDoItem] = []
    private var listItems: [ListItem] = []
    
//    var sortedList: [ToDoItem] { toDoListCache }
    let localDataManager = LocalDataManager()
    
//    @Published private var toDoListCache: [ToDoItem] = [
//        .init(title: "See a doctor", description: "Take the Bus 123"),
//        .init(title: "Do the laundry", description: "Must done today!"),
//        .init(title: "Send the parcel", description: "To Tom")
//    ]
//
    
    func addNewItem(newItem: ToDoItem) {
//        toDoListCache.insert(newItem, at: 0)
        
        localDataManager.addItem(title: newItem.title,
                                 description: newItem.description,
                                 createdDate: newItem.createdDate,
                                 dueDate: newItem.dueDate,
                                 location: newItem.location) { [weak self] result in
            switch result {
            case .success(()):
                self?.fetchLocalData()
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }
    }
    
    func dateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func fetchLocalData() {
        localDataManager.fetchLocalData { [weak self] result in
            switch result {
            case .success(let items):
                self?.listItems = items
                self?.todoList = self?.transferLocalData(localItems: items) ?? []
            case .failure(let error):
                print("Error:\(error)")
            }
        }
    }
    
    private func transferLocalData(localItems: [ListItem]) -> [ToDoItem] {
        let newItems = localItems.map { item in
            return ToDoItem(title: item.title ?? "",
                            description: item.content ?? "",
                            createdDate: item.createdDate ?? Date(),
                            dueDate: item.dueDate ?? Date(),
                            location: item.location ?? "",
                            id: item.id)
        }
        let sortedItems = newItems.sorted { item1, item2 in
            item1.dueDate < item2.dueDate
        }
        return sortedItems
    }
    
    func deleteLocalData(toDoItem: ToDoItem) {
        guard let listItem = listItems.first(where: { $0.id == toDoItem.id }) else { return }
        localDataManager.deleteLocalData(item: listItem) { [weak self] result in
            switch result {
            case .success(()):
                self?.fetchLocalData()
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }
    }
}
