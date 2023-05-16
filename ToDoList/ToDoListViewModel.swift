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
    var errorMessage: String?
    
    @Published var isError: Bool = false

    let localDataManager = LocalDataManager()
    
    func addNewItem(newItem: ToDoItem) {
        localDataManager.addItem(title: newItem.title,
                                 description: newItem.description,
                                 createdDate: newItem.createdDate,
                                 dueDate: newItem.dueDate,
                                 location: newItem.location) { [weak self] result in
            switch result {
            case .success(()):
                self?.fetchLocalData()
                self?.isError = false
            case .failure(let error):
                self?.errorMessage = ErrorMessage.addLocalDataFailed.message + "\n \(error.localizedDescription)"
                self?.isError = true
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
                self?.isError = false
            case .failure(let error):
                self?.errorMessage = ErrorMessage.fetchLocalDataFailed.message + "\n \(error.localizedDescription)"
                self?.isError = true
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
                self?.isError = false
            case .failure(let error):
                self?.errorMessage = ErrorMessage.deleteLocalDataFailed.message + "\n \(error.localizedDescription)"
                self?.isError = true
            }
        }
    }
    
    func editLocalData(toDoItem: ToDoItem, title: String, description: String, createdDate: Date, dueDate: Date, location: String) {
        guard let listItem = listItems.first(where: { $0.id == toDoItem.id }) else { return }
        localDataManager.editItem(item: listItem,
                                  title: title,
                                  description: description,
                                  createdDate: createdDate,
                                  dueDate: dueDate,
                                  location: location) { [weak self] result in
            switch result {
            case .success(()):
                self?.fetchLocalData()
                self?.isError = false
            case .failure(let error):
                self?.errorMessage = ErrorMessage.editLocalDataFailed.message + "\n \(error.localizedDescription)"
                self?.isError = true
            }
        }
    }
}

enum ErrorMessage {
    case addLocalDataFailed
    case fetchLocalDataFailed
    case deleteLocalDataFailed
    case editLocalDataFailed
    
    var message: String {
        switch self {
        case .addLocalDataFailed:
            return "Failed when adding data."
        case .fetchLocalDataFailed:
            return "Failed when fetching data."
        case .deleteLocalDataFailed:
            return "Failed when deleting data."
        case .editLocalDataFailed:
            return "Failed when editing data."
        }
    }
}
