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
    @Environment(\.dismiss) var dismiss    
    @EnvironmentObject var viewModel: ToDoListViewModel
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        NavigationView {
            ItemDetailView(title: $title, description: $description, location: $location, createdDate: $createdDate, dueDate: $dueDate)
            .navigationBarTitle(Text("Add To Do Item"),
                                displayMode: .inline)
            .navigationBarItems(
                trailing: Button(
                    action: { addNewItem() },
                    label: { Text("Save") })
            )
            .onAppear {
                locationManager.requestLocation()
            }
        }
    }
    
    private func addNewItem() {
        let defaultLocationString = Utils.getDefaultLocationString(location: locationManager.location)
        
        let newItem = ToDoItem(title: title,
                               description: description,
                               createdDate: createdDate,
                               dueDate: dueDate,
                               location: defaultLocationString)
        viewModel.addNewItem(newItem: newItem)
        dismiss()
    }
    
    private func getCurrectLocation() {
        locationManager.requestLocation()
    }
        
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
            .environmentObject(ToDoListViewModel())
    }
}
