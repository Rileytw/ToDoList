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
            List(ToDoList().sortedList, id: \.title) { item in
                ToDoListRow(toDoItem: item)
                    .navigationTitle("To Do List")
            }
        }
    }
}

struct ToDoListRow: View {
    let toDoItem: ToDoItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(toDoItem.title)
                    .font(.title2)
                Text(toDoItem.description)
                    .font(.title3)
                    .foregroundColor(.secondary)
                HStack {
                    Text("created Date:")
                        .font(.title3)
                        .foregroundColor(.secondary)
                    Text(toDoItem.createdDate)
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Due Date:")
                        .font(.title3)
                        .foregroundColor(.secondary)
                    Text(toDoItem.dueDate)
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Location:")
                        .font(.title3)
                        .foregroundColor(.secondary)
                    Text(toDoItem.location)
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
                
            }
            .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.vertical, 8)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

