//
//  LocalDataManager.swift
//  ToDoList
//
//  Created by Lei on 2023/5/15.
//

import Foundation
import CoreData

enum LocalStorageResult<T> {
    case success(T)
    case failure(Error)
}

class LocalDataManager: ObservableObject {
    var items: [ListItem] = []
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDoList")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Core Data PersistentContainer Error: \(error.localizedDescription)")
            }
        }
        return container
    }()
        
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext(completion: @escaping (LocalStorageResult<Void>) -> Void) {
        if context.hasChanges {
            do {
                try context.save()
                completion(LocalStorageResult.success(()))
            } catch {
                completion(LocalStorageResult.failure(error))
            }
        }
    }
    
    func addItem(title: String, description: String, createdDate: Date, dueDate: Date, location: String, completion: @escaping (LocalStorageResult<Void>) -> Void) {
        let item = ListItem(context: context)
        item.title = title
        item.content = description
        item.createdDate = createdDate
        item.dueDate = dueDate
        item.location = location
        item.id = UUID()
        
        saveContext(completion: completion)
    }
    
    func editItem(item: ListItem, title: String, description: String, createdDate: Date, dueDate: Date, location: String, completion: @escaping (LocalStorageResult<Void>) -> Void) {
        item.title = title
        item.content = description
        item.createdDate = createdDate
        item.dueDate = dueDate
        item.location = location
        
        saveContext(completion: completion)
    }
    
    func fetchLocalData(completion: @escaping (LocalStorageResult<[ListItem]>) -> Void) {
        let request = NSFetchRequest<ListItem>(entityName: "ListItem")
        
        do {
            let items = try context.fetch(request)
            self.items = items
            completion(LocalStorageResult.success(items))
        } catch {
            print("Core data Fetch failed.")
            completion(LocalStorageResult.failure(error))
        }
    }
    
    func deleteLocalData(item: ListItem, completion: @escaping (LocalStorageResult<Void>) -> Void) {
        context.delete(item)
        saveContext(completion: completion)
    }

}
