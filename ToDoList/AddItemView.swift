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
    @State private var isPresented = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Item Information")) {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                }
                
                Section(header: Text("Date")) {
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
                }
                
                Section(header: Text("Location")) {
                    TextField("Location", text: $location)
                }
            }
            .navigationBarTitle(Text("Add To Do Item"),
                                displayMode: .inline)
            .navigationBarItems(
                trailing: Button(
                    action: { self.isPresented.toggle() },
                    label: { Text("Save") })
            )
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}
