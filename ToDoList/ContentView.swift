//
//  ContentView.swift
//  ToDoList
//
//  Created by Lei on 2023/5/15.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresented = false
    @EnvironmentObject var viewModel: ToDoListViewModel

    var body: some View {
        NavigationView {
            List {
//                ForEach(viewModel.sortedList, id: \.self) { item in
//                    ToDoListRow(toDoItem: item)
//                }
                ForEach(viewModel.todoList, id: \.self) { item in
                    ToDoListRow(toDoItem: item)
                }
            }
            .navigationTitle("To Do List")
            .navigationBarItems(
                trailing: Button(action: {
                self.isPresented = true
            }) {
                Image(systemName: "plus")
            }
                .sheet(isPresented: $isPresented) {
                    AddItemView()
                }
            )
            .onAppear {
                viewModel.fetchLocalData()
            }
        }
    }
}

struct ToDoListRow: View {
    let toDoItem: ToDoItem
    private let viewModel = ToDoListViewModel()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(toDoItem.title)
                    .font(.title2)
                Text(toDoItem.description)
                    .font(.title3)
                    .foregroundColor(.gray)
                Spacer()
                HStack {
                    Text("created Date:")
                        .font(.subheadline)
                    Text(viewModel.dateToString(toDoItem.createdDate))
                        .font(.subheadline)
                }
                HStack {
                    Text("Due Date:")
                        .font(.subheadline)
                        .foregroundColor(.red)
                    Text(viewModel.dateToString(toDoItem.dueDate))
                        .font(.subheadline)
                        .foregroundColor(.red)
                }
                HStack {
                    Text("Location:")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(toDoItem.location)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
            }
            .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.vertical, 12)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ToDoListViewModel())
    }
}

