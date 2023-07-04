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
        
        init(_ editViewWrapper: EditViewWrapper) {
            self.parent = editViewWrapper
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 4
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ItemTableViewCell.self), for: indexPath)
            guard let itemCell = cell as? ItemTableViewCell else { return cell }
            itemCell.configure(title: "TestTitle", content: "TestDescription")
            return itemCell
        }
    }
    
}
