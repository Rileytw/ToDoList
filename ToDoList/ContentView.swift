//
//  ContentView.swift
//  ToDoList
//
//  Created by Lei on 2023/5/15.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ToDoListRow(toDoList: ToDoList())
                .navigationTitle("To Do List")
        }
        
    }
}

struct ToDoListRow: View {
    let toDoList: ToDoList
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(toDoList.title)
                    .font(.title2)
                Text(toDoList.description)
                    .font(.title3)
                    .foregroundColor(.secondary)
                HStack {
                    Text("created Date:")
                        .font(.title3)
                        .foregroundColor(.secondary)
                    Text(toDoList.createdDate)
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Due Date:")
                        .font(.title3)
                        .foregroundColor(.secondary)
                    Text(toDoList.dueDate)
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Location:")
                        .font(.title3)
                        .foregroundColor(.secondary)
                    Text(toDoList.location)
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
                
            }
            .lineLimit(1)
        }
        .padding(.vertical, 8)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ToDoList {
    var title: String
    var description: String
    var createdDate: String
    var dueDate: String
    var location : String
    
    init(title: String = "Title", description: String = "Description", createdDate: String = "2023/05/15", dueDate: String = "2023/05/16", location: String = "TestLocation") {
        self.title = title
        self.description = description
        self.createdDate = createdDate
        self.dueDate = dueDate
        self.location = location
    }
}
