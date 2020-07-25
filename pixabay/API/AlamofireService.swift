//
//  AlamofireService.swift
//  pixabay
//
//  Created by Kaan Ozdemir on 25.07.2020.
//  Copyright © 2020 Kaan Ozdemir. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class AlamofireService {
    
    static let shared = AlamofireService()
    
    private let httpType = "https"
    
    private func defaultsHeaderParams ( _ parameters : HTTPHeaders? = nil ) -> HTTPHeaders {
        var dictionary = HTTPHeaders(["Content-Type": "application/json",])
        if let result =  parameters {
            result.forEach({dictionary.update($0)})
        }
        
        return dictionary
    }
    
    func defaultQueryItems() -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        queryItems.append(URLQueryItem(name: "key", value: AppConstant.apiKey))
        return queryItems
    }
    
    func getImages(params: [String: Any], queryItems: [URLQueryItem], completion: @escaping (DataResponse<ImageResponse,AFError>) -> ()) {
        
        var urlComponents = URLComponents()
        urlComponents.host = AppConstant.host
        urlComponents.path = URLPaths.api
        urlComponents.queryItems = queryItems
        urlComponents.scheme = httpType
        
        AF.request(urlComponents.string!, method: .post, parameters: params, encoding: JSONEncoding.default,headers: defaultsHeaderParams()).responseObject{ (response: DataResponse<ImageResponse, AFError>) in
            print("🟡 getImages service request is returned.")
            completion(response)
        }
    }
    
}
