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
    @ObservedObject var viewModel: ToDoListViewModel = ToDoListViewModel()
    @ObservedObject var locationServiceAdaptor = LocationServiceAdaptor()
    
    @ObservedObject private var connectivityManager = WatchConnectivityManager.shared
    
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
                                        ToDoListRow(toDoItem: item, viewModel: viewModel)
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
                    NavigationLink(destination: AddItemView(viewModel: viewModel,
                                                            locationServiceAdaptor: locationServiceAdaptor)) {
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
            .alert(isPresented: $locationServiceAdaptor.isError) {
                Alert(title: Text("Error Message"), message: Text(locationServiceAdaptor.errorMessage ?? ""), dismissButton: .default(Text("OK")))
            }
            .alert(isPresented: $connectivityManager.isError) {
                Alert(title: Text("Error Message"), message: Text(connectivityManager.errorMessage ?? ""), dismissButton: .default(Text("OK")))
            }
            .alert(isPresented: $isListEmpty) {
                Alert(title: Text("Hint"), message: Text("Tap ➕ button to add to do item!"), dismissButton: .default(Text("OK")))
            }
        }
        .onReceive(connectivityManager.$item) { item in
            guard let item = item else { return }
            self.connectWatchOSData(watchOSItem: item)
            viewModel.fetchLocalData()
        }
    }
    
    func deleteItem(at offsets: IndexSet) {
        offsets.forEach { index in
            let deltedItem = viewModel.todoList[index]
            self.viewModel.deleteLocalData(toDoItem: deltedItem)
        }
    }
    
    private func connectWatchOSData(watchOSItem: ToDoItem) {
        viewModel.addNewItem(newItem: watchOSItem)
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
    }
}

