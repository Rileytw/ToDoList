//
//  ToDoListRow.swift
//  ToDoList
//
//  Created by Lei on 2023/5/16.
//

import SwiftUI

struct ToDoListRow: View {
    let toDoItem: ToDoItem
    @ObservedObject var viewModel: ToDoListViewModel
    
    var body: some View {
        NavigationLink(destination: EditItemView(viewModel: viewModel, item: toDoItem)) {
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
}
