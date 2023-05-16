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
                ForEach(ContentViewSection.allCases, id: \.self) { section in
                    Section(header: Text(section.title)) {
                        switch section {
                        case .toDoList:
                            ForEach(viewModel.todoList, id: \.self) { item in
                                ToDoListRow(toDoItem: item)
                            }
                            .onDelete(perform: deleteItem)
                        case .quote:
                            ForEach(viewModel.quote, id: \.self) { item in
                                QuoteRow(quote: item)
                            }
                        }
                    }
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
                viewModel.fetchQutableData()
            }
            .alert(isPresented: $viewModel.isError) {
                Alert(title: Text("Error Message"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func deleteItem(at offsets: IndexSet) {
        offsets.forEach { index in
            let deltedItem = viewModel.todoList[index]
            self.viewModel.deleteLocalData(toDoItem: deltedItem)
        }
    }
}

extension ContentView {
    enum ContentViewSection: CaseIterable {
        case toDoList
        case quote
        
        var title: String {
            switch self {
            case .toDoList:
                return "To Do"
            case .quote:
                return "Quote"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ToDoListViewModel())
    }
}

