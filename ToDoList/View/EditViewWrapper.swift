//
//  EditViewWrapper.swift
//  ToDoList
//
//  Created by Lei on 2023/7/4.
//

import SwiftUI
import UIKit

struct EditViewWrapper: UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController  {
        let editViewController = EditItemViewController()
        editViewController.tableView.delegate = context.coordinator
        editViewController.tableView.dataSource = context.coordinator
        
        return editViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    class Coordinator: NSObject, UITableViewDelegate, UITableViewDataSource {
        var parent: EditViewWrapper
        var list = ItemList.allCases
        
        init(_ editViewWrapper: EditViewWrapper) {
            self.parent = editViewWrapper
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return ItemList.allCases.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            switch list[indexPath.row] {
            case .title, .description, .location:
                let itemCell = tableView.dequeueReusableCell(withIdentifier: String(describing: ItemTableViewCell.self), for: indexPath)
                guard let itemCell = itemCell as? ItemTableViewCell else { return itemCell }
                itemCell.configure(title: list[indexPath.row].titleName, content: "TestDescription")
                return itemCell
            case .createdDate, .dueDate:
                let datePickerCell = tableView.dequeueReusableCell(withIdentifier: String(describing: DatePickerTableViewCell.self), for: indexPath)
                guard let datePickerCell = datePickerCell as? DatePickerTableViewCell else { return datePickerCell }
                datePickerCell.configure(title: list[indexPath.row].titleName, date: Date())
                return datePickerCell
            }
        }
    }
    
}
