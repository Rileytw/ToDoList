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
    @Published var location: String = ""
    @Published var isError: Bool = false
    private var listItems: [ListItem] = []
    var errorMessage: String?
    
    let localDataManager = LocalDataManager()
    let locationManager = LocationManager()
    
    let networkManager: HTTPClient
    
    init(networkManager: HTTPClient = NetworkManager()) {
        self.networkManager = networkManager
        locationManager.delegate = self
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
                self?.errorMessage = ErrorMessage.addLocalDataFailed.message + "\n \(error.localizedDescription)"
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
    
    func fetchQutableData() {
        let router = QuotableRouter.random
        networkManager.requestData(router) { [weak self] (result: Result<Quote>) in
            switch result {
            case .success(let data):
                self?.quote.append(data)
                self?.isError = false
            case .failure(let error):
                let api = router.baseURL + router.path
                self?.errorMessage = ErrorMessage.fetchAPIDataFailed(api: api).message + "\n \(error.localizedDescription)"
                self?.isError = true
            }
        }
    }
    
    func getLocation() {
        locationManager.requestLocation()
    }
}

extension ToDoListViewModel: LocationDelegate {
    func didGetLocation(location: String) {
        self.location = location
    }
    
    func locationRequestFailed(error: Error) {
        self.isError = true
        self.errorMessage = ErrorMessage.getLocationFailed.message + "\n \(error.localizedDescription)"
    }
}


enum ErrorMessage {
    case addLocalDataFailed
    case fetchLocalDataFailed
    case deleteLocalDataFailed
    case editLocalDataFailed
    case fetchAPIDataFailed(api: String)
    case getLocationFailed
    
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
        case .fetchAPIDataFailed(let api):
            return "Failed when fetching data from API: \(api)."
        case .getLocationFailed:
            return "Failed when requesting location"
        }
    }
}
