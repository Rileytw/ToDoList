//
//  QuotableRouter.swift
//  ToDoList
//
//  Created by Lei on 2023/5/16.
//

import Foundation
import Alamofire

enum QuotableRouter {
    case random
}

extension QuotableRouter: Router { 
    var baseURL: String {
        return NetworkClient.baseURL
    }
    
    var path: String {
        return "/random"
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var param: [String : Any]? {
        nil
    }
    
    var httpHeaders: HTTPHeaders? {
        nil
    }
}
