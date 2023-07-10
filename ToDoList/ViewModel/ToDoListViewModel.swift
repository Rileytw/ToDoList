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
    @Published var quote: [Quote] = []
    @Published var isError: Bool = false
    private var listItems: [ListItem] = []
    var errorMessage: String?
    var alertTitle: String?
    
    let localDataManager = LocalDataManager()
    
    let networkManager: HTTPClient
    
    init(networkManager: HTTPClient = NetworkManager()) {
        self.networkManager = networkManager
    }
    
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
                self?.errorMessage = AlertMessage.addLocalDataFailed.message + "\n \(error.localizedDescription)"
                self?.alertTitle = AlertMessage.addLocalDataFailed.title
                self?.isError = true
            }
        }
    }
    
    func fetchLocalData() {
        localDataManager.fetchLocalData { [weak self] result in
            switch result {
            case .success(let items):
                self?.listItems = items
                self?.todoList = self?.transferLocalData(localItems: items) ?? []
                self?.isError = false
            case .failure(let error):
                self?.errorMessage = AlertMessage.fetchLocalDataFailed.message + "\n \(error.localizedDescription)"
                self?.alertTitle = AlertMessage.fetchLocalDataFailed.title
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
                self?.errorMessage = AlertMessage.deleteLocalDataFailed.message + "\n \(error.localizedDescription)"
                self?.alertTitle = AlertMessage.deleteLocalDataFailed.title
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
                self?.errorMessage = AlertMessage.editLocalDataFailed.message + "\n \(error.localizedDescription)"
                self?.alertTitle = AlertMessage.editLocalDataFailed.title
                self?.isError = true
            }
        }
    }
    
    func fetchQutableData() {
        let router = QuotableRouter.random
        networkManager.requestData(router) { [weak self] (result: Result<Quote>) in
            switch result {
            case .success(let data):
                self?.quote.append(data)
                self?.isError = false
            case .failure(let error):
                let api = router.baseURL + router.path
                self?.errorMessage = AlertMessage.fetchAPIDataFailed(api: api).message + "\n \(error.localizedDescription)"
                self?.alertTitle = AlertMessage.fetchAPIDataFailed(api: api).title
                self?.isError = true
            }
        }
    }
    
    func checkIsToDoListEmpty() {
        self.isError = todoList.isEmpty ? true : false
        self.alertTitle = AlertMessage.emptyData.title
        self.errorMessage = AlertMessage.emptyData.message
    }
    
    func sendLocationErrorMessage(errorMessage: String) {
        self.isError = true
        self.alertTitle = AlertMessage.getLocationFailed.title
        self.errorMessage =  AlertMessage.getLocationFailed.message + errorMessage
    }
    
    func sendWatchOSConnectionErrorMessage(errorMessage: String) {
        self.isError = true
        self.alertTitle = AlertMessage.watchOSConnectFailed.title
        self.errorMessage =  errorMessage
    }
}

