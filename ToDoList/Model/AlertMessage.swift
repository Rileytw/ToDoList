//
//  AlertMessage.swift
//  ToDoList
//
//  Created by Lei on 2023/7/10.
//

import Foundation

enum AlertMessage {
    case addLocalDataFailed
    case fetchLocalDataFailed
    case deleteLocalDataFailed
    case editLocalDataFailed
    case fetchAPIDataFailed(api: String)
    case getLocationFailed
    case emptyData
    case watchOSConnectFailed
    case dataEncodeFailed
    case dataDecodeFailed
    
    var title: String {
        switch self {
        case .emptyData:
            return "Hint"
        default:
            return "Error Message"
        }
    }
    
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
        case .emptyData:
            return "Tap ➕ button to add to do item!"
        case .watchOSConnectFailed:
            return "Failed when WatchOS sending data back."
        case .dataEncodeFailed:
            return "Failed when encoding data."
        case .dataDecodeFailed:
            return "Failed when decoding data."
        }
    }
}
