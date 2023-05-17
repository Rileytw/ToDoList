//
//  AddItemView.swift
//  ToDoList
//
//  Created by Lei on 2023/5/15.
//

import SwiftUI

struct AddItemView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var location = ""
    @State private var createdDate = Date()
    @State private var dueDate = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var viewModel: ToDoListViewModel
    
    var body: some View {
        ItemDetailView(title: $title, description: $description, location: $location, createdDate: $createdDate, dueDate: $dueDate, viewModel: viewModel)
            .navigationBarTitle(Text("Add To Do Item"),
                                displayMode: .inline)
            .navigationBarItems(
                trailing: Button(
                    action: { addNewItem() },
                    label: { Text("Save") })
            )
    }
    
    private func addNewItem() {
        let newItem = ToDoItem(title: title,
                               description: description,
                               createdDate: createdDate,
                               dueDate: dueDate,
                               location: viewModel.location)
        viewModel.addNewItem(newItem: newItem)
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(viewModel: ToDoListViewModel())
    }
}
