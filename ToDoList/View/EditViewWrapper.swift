//
//  EditViewWrapper.swift
//  ToDoList
//
//  Created by Lei on 2023/7/4.
//

import SwiftUI
import UIKit

struct EditViewWrapper: UIViewControllerRepresentable {
    

    
    func makeUIViewController(context: Context) -> UIViewController  {
        let editViewController = EditItemViewController()
        
        return editViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
}
