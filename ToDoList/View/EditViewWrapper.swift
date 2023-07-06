//
//  EditViewWrapper.swift
//  ToDoList
//
//  Created by Lei on 2023/7/4.
//

import SwiftUI
import UIKit

struct EditViewWrapper: UIViewControllerRepresentable {
    var item: ToDoItem
    @ObservedObject var viewModel: ToDoListViewModel
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, item: item, viewModel: viewModel)
    }
    
    func makeUIViewController(context: Context) -> UIViewController  {
        let editViewController = EditItemViewController()
        editViewController.tableView.delegate = context.coordinator
        editViewController.tableView.dataSource = context.coordinator
        
        return editViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    class Coordinator: NSObject, UITableViewDelegate, UITableViewDataSource, ItemTableViewCellDelegate {
        var parent: EditViewWrapper
        var list = ItemList.allCases
        var item: ToDoItem
        @ObservedObject var viewModel: ToDoListViewModel
        
        init(_ editViewWrapper: EditViewWrapper, item: ToDoItem, viewModel: ToDoListViewModel) {
            self.parent = editViewWrapper
            self.item = item
            self.viewModel = viewModel
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return ItemList.allCases.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            switch list[indexPath.row] {
            case .title, .description, .location:
                let itemCell = tableView.dequeueReusableCell(withIdentifier: String(describing: ItemTableViewCell.self), for: indexPath)
                guard let itemCell = itemCell as? ItemTableViewCell else { return itemCell }
                let content = getContent(list: list[indexPath.row])
                itemCell.itemType = list[indexPath.row]
                itemCell.configure(title: list[indexPath.row].titleName, content: content)
                itemCell.delegate = self
                return itemCell
            case .createdDate, .dueDate:
                let datePickerCell = tableView.dequeueReusableCell(withIdentifier: String(describing: DatePickerTableViewCell.self), for: indexPath)
                guard let datePickerCell = datePickerCell as? DatePickerTableViewCell else { return datePickerCell }
                let date = getDate(list: list[indexPath.row])
                datePickerCell.configure(title: list[indexPath.row].titleName, date: date)
                return datePickerCell
            }
        }
        
        private func getContent(list: ItemList) -> String {
            var content: String
            switch list {
            case .title:
                content = item.title
            case .description:
                content = item.description
            case .location:
                content = item.location
            default:
                content = ""
            }
            
            return content
        }
        
        private func getDate(list: ItemList) -> Date {
            var date: Date
            switch list {
            case .createdDate:
                date = item.createdDate
            case .dueDate:
                date = item.dueDate
            default:
                date = Date()
            }
            
            return date
        }
        
        func textFieldDidEndEditing(itemType: ItemList, text: String) {
            switch itemType {
            case .title:
                item.title = text
            case .description:
                item.description = text
            case .location:
                item.location = text
            default:
                break
            }
            
            viewModel.editLocalData(toDoItem: item,
                                    title: item.title,
                                    description: item.description,
                                    createdDate: item.createdDate,
                                    dueDate: item.dueDate,
                                    location: item.location)
        }
    }
    
}
