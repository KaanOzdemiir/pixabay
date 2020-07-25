//
//  ImageRepo.swift
//  pixabay
//
//  Created by Kaan Ozdemir on 25.07.2020.
//  Copyright © 2020 Kaan Ozdemir. All rights reserved.
//

import Foundation
import RxSwift

class ImageRepo {
    
    func fecthImages(params: [String: Any], queryItems: [URLQueryItem]) -> Observable<ImageResponse> {
        
        return Observable.create { observer -> Disposable in
            AlamofireService.shared.getImages(params: params, queryItems: queryItems){ (dataResponse) in
                let result = dataResponse.result
                switch result {
                case .success(let response):
                    observer.onNext(response)
                case .failure(let error):
                    let error = ImageResponse(message: error.localizedDescription)
                    observer.onNext(error)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
