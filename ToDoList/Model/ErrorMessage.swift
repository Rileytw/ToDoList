//
//  ErrorMessage.swift
//  ToDoList
//
//  Created by Lei on 2023/7/10.
//

import Foundation

enum ErrorMessage {
    case addLocalDataFailed
    case fetchLocalDataFailed
    case deleteLocalDataFailed
    case editLocalDataFailed
    case fetchAPIDataFailed(api: String)
    case getLocationFailed
    
    var message: String {
        switch self {
        case .addLocalDataFailed:
            return "Failed when adding data."
        case .fetchLocalDataFailed:
            return "Failed when fetching data."
        case .deleteLocalDataFailed:
            return "Failed when deleting data."
        case .editLocalDataFailed:
            return "Failed when editing data."
        case .fetchAPIDataFailed(let api):
            return "Failed when fetching data from API: \(api)."
        case .getLocationFailed:
            return "Failed when requesting location"
        }
    }
}
