//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Lei on 2023/5/15.
//

import SwiftUI

@main
struct ToDoListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(ToDoListViewModel())
        }
    }
}
