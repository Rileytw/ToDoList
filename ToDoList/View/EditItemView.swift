//
//  EditItemView.swift
//  ToDoList
//
//  Created by Lei on 2023/5/16.
//

import SwiftUI

struct EditItemView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var location = ""
    @State private var createdDate = Date()
    @State private var dueDate = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    @ObservedObject var viewModel: ToDoListViewModel
    @StateObject var locationManager = LocationManager()

    var item: ToDoItem

    @State private var selected = EditVersion.swiftUI
    
    var body: some View {
        VStack {
            Picker("Edit Version", selection: $selected) {
                Text(EditVersion.swiftUI.rawValue)
                    .tag(EditVersion.swiftUI)
                Text(EditVersion.UIKit.rawValue)
                    .tag(EditVersion.UIKit)
            }
            .pickerStyle(.segmented)
            .padding()
            
            switch selected {
            case .swiftUI:
                
                ItemDetailView(title: $title, description: $description, location: $location, createdDate: $createdDate, dueDate: $dueDate, viewModel: viewModel)
                    .navigationBarTitle(Text("Edit Item"),
                                        displayMode: .inline)
                    .onAppear {
                        presentOldData()
                    }
                    .onDisappear {
                        editItem()
                    }
            case .UIKit:
                EditViewWrapper(item: item)
                    .navigationBarTitle(Text("Edit Item"),
                                        displayMode: .inline)
            }
        }
    }
    
    private func presentOldData() {
        title = item.title
        description = item.description
        createdDate = item.createdDate
        dueDate = item.dueDate
        location = item.location
    }
    
    private func editItem() {
        guard item.title != title || item.description != description || item.createdDate != createdDate || item.dueDate != dueDate || item.location != location else {
               return
           }
           
           viewModel.editLocalData(toDoItem: item,
                                   title: title,
                                   description: description,
                                   createdDate: createdDate,
                                   dueDate: dueDate,
                                   location: location)
    }

}

enum EditVersion: String {
    case swiftUI = "SwiftUI"
    case UIKit = "UIKit"
}

struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        EditItemView(viewModel: ToDoListViewModel(), item: ToDoItem())
    }
}
