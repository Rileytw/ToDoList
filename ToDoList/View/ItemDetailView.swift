//
//  ItemDetailView.swift
//  ToDoList
//
//  Created by Lei on 2023/5/16.
//

import SwiftUI

struct ItemDetailView: View {
    @Binding var title: String
    @Binding var description: String
    @Binding var location: String
    @Binding var createdDate: Date
    @Binding var dueDate: Date
    @ObservedObject var viewModel: ToDoListViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading) {
                Text(ItemList.title.titleName)
                    .font(.title3)
                    .bold()
                TextField("Title...", text: $title)
                Divider()
            }
            
            VStack(alignment: .leading) {
                Text(ItemList.description.titleName)
                    .font(.title3)
                    .bold()
                TextField("Description...", text: $description)
                Divider()
            }
            
            DatePicker(
                selection: $createdDate,
                displayedComponents: .date) {
                    Text(ItemList.createdDate.titleName).foregroundColor(Color(.gray))
                }
            DatePicker(
                selection: $dueDate,
                displayedComponents: .date) {
                    Text(ItemList.dueDate.titleName).foregroundColor(Color(.gray))
                }
            
            VStack(alignment: .leading) {
                Text(ItemList.location.titleName)
                    .font(.title3)
                    .bold()
                if viewModel.location.isEmpty {
                    TextField("Location...", text: $location)
                    
                } else {
                    TextField("Location: \(viewModel.location)", text: $location)
                }
                
                Divider()
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .top)
        .padding()
        .onAppear {
            viewModel.getLocation()
        }
    }
}


struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView(
            title: .constant("Sample Title"),
            description: .constant("Sample Description"),
            location: .constant("Sample Location"),
            createdDate: .constant(Date()),
            dueDate: .constant(Calendar.current.date(byAdding: .day, value: 1, to: Date())!),
            viewModel: ToDoListViewModel()
        )
    }
}
