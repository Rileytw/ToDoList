//
//  Quote.swift
//  ToDoList
//
//  Created by Lei on 2023/5/16.
//

import Foundation

struct Quote: Codable, Hashable {
    let id: String?
    let content: String?
    let author: String?
    let tags: [String]?
    let authorSlug: String?
    let length: Int?
    let dateAdded: String?
    let dateModified: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case content
        case author
        case tags
        case authorSlug
        case length
        case dateAdded
        case dateModified
    }
}
