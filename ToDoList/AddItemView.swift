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
    @State private var dueDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    @State private var isSaved = false
    @Environment(\.dismiss) var dismiss    
    @EnvironmentObject var viewModel: ToDoListViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading) {
                    Text("Title")
                        .font(.title3)
                        .bold()
                    TextField("Title...", text: $title)
                    Divider()
                }
                
                VStack(alignment: .leading) {
                    Text("Description")
                        .font(.title3)
                        .bold()
                    TextField("Description...", text: $description)
                    Divider()
                }
                
                DatePicker(
                    selection: $createdDate,
                    displayedComponents: .date) {
                        Text("Created Date").foregroundColor(Color(.gray))
                    }
                DatePicker(
                    selection: $dueDate,
                    displayedComponents: .date) {
                        Text("Due Date").foregroundColor(Color(.gray))
                    }
                
                VStack(alignment: .leading) {
                    Text("Location")
                        .font(.title3)
                        .bold()
                    TextField("Location...", text: $location)
                    Divider()
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .top)
            .padding()
            
            
            .navigationBarTitle(Text("Add To Do Item"),
                                displayMode: .inline)
            .navigationBarItems(
                trailing: Button(
                    action: { addNewItem() },
                    label: { Text("Save") })
            )
        }
    }
    
    private func addNewItem() {
        let newItem = ToDoItem(title: title,
                               description: description,
                               createdDate: createdDate,
                               dueDate: dueDate,
                               location: location)
        viewModel.addNewItem(newItem: newItem)
        dismiss()
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
            .environmentObject(ToDoListViewModel())
    }
}
