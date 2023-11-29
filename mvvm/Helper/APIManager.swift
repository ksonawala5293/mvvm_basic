//
//  APIManager.swift
//  mvvm
//
//  Created by Apple on 29/11/23.
//

import Foundation

typealias Handler = (Result<[ProductBaseModel], dataError>) -> ()

enum dataError: Error {
    case invalidRepsonse
    case invalidData
    case invalidURL
    case invalidDecoding
    case error(Error?)
}

final class APIManager {
    static var shared = APIManager()
    
    private init() {}
    
    func fetchAPI(completionHandler: @escaping Handler) {
        guard let url = URL(string: constants.apis.productURLAPI) else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else {
                completionHandler(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200 ... 299 ~= response.statusCode else {
                completionHandler(.failure(.invalidRepsonse))
                return
            }
            
            do {
                let products = try JSONDecoder().decode([ProductBaseModel].self, from: data)
                completionHandler(.success(products))
            } catch {
                completionHandler(.failure(.error(error)))
                return
            }
        }.resume()
    }
}
