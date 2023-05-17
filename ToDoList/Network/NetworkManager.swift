//
//  NetworkManager.swift
//  ToDoList
//
//  Created by Lei on 2023/5/16.
//

import Foundation
import Alamofire

protocol HTTPClient {
    func requestData<T: Decodable>(_ router: EndPointType, completion: @escaping (Result<T>) -> Void)
}

enum Result<T: Decodable> {
    case success(T)
    case failure(Error)
}


class NetworkManager: HTTPClient {
    
    func requestData<T: Decodable>(_ router: EndPointType, completion: @escaping (Result<T>) -> Void) {
        let requestURL = router.baseURL + router.path
        let request = AF.request(requestURL,
                   method: router.httpMethod,
                   parameters: router.param,
                   encoding: router.encoding,
                   headers: router.httpHeaders)
        
        request.responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(Result.success(data))
            case .failure(let error):
                completion(Result.failure(error))
            }
            
        }
    }
}
