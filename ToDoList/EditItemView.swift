//
//  EditItemView.swift
//  ToDoList
//
//  Created by Lei on 2023/5/16.
//

import SwiftUI

struct EditItemView: View {
    var item: ToDoItem
    private let itemDetailVew = ItemDetailView()
    
    var body: some View {
        ItemDetailView(title: item.title,
                       description: item.description,
                       location: item.location,
                       createdDate: item.createdDate,
                       dueDate: item.dueDate)
            .onDisappear {
                
            }
    }
    

}

struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        EditItemView(item: ToDoItem())
    }
}
