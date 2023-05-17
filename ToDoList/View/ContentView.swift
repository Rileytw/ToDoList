//
//  ContentView.swift
//  ToDoList
//
//  Created by Lei on 2023/5/15.
//

import SwiftUI

struct ContentView: View {
    @State private var isListEmpty = false
    @State private var isFistAppear = true
    @EnvironmentObject var viewModel: ToDoListViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(ContentViewSection.allCases, id: \.self) { section in
                    Section(header: Text(section.title)
                        .font(.title3)) {
                            switch section {
                            case .toDoList:
                                if viewModel.todoList.isEmpty {
                                    Text("To Do List is Empty.")
                                        .padding()
                                } else {
                                    ForEach(viewModel.todoList, id: \.self) { item in
                                        ToDoListRow(toDoItem: item)
                                    }
                                    .onDelete(perform: deleteItem)
                                }
                            case .quote:
                                ForEach(viewModel.quote, id: \.self) { item in
                                    QuoteRow(quote: item)
                                }
                                DailyQuoteRow()
                            }
                        }
                }
            }
            .navigationTitle("To Do List")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    NavigationLink(destination: AddItemView()) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 32))
                            .foregroundColor(.blue)
                    }
                }
            }
            .onAppear {
                viewModel.fetchLocalData()
                
                isListEmpty = viewModel.todoList.isEmpty ? true : false
                
                if isFistAppear {
                    viewModel.fetchQutableData()
                    isFistAppear = false
                }
            }
            .alert(isPresented: $viewModel.isError) {
                Alert(title: Text("Error Message"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("OK")))
            }
            .alert(isPresented: $isListEmpty) {
                Alert(title: Text("Hint"), message: Text("Tap ➕ button to add to do item!"), dismissButton: .default(Text("OK")))
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

