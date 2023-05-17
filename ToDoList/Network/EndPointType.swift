//
//  EndPointType.swift
//  ToDoList
//
//  Created by Lei on 2023/5/16.
//

import Foundation
import Alamofire

protocol EndPointType {
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
    var param: [String: Any]? { get }
    var httpHeaders: HTTPHeaders? { get }
    
}

protocol Router: EndPointType {}
