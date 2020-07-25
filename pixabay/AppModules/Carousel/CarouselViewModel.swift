//
//  CarouselViewModel.swift
//  pixabay
//
//  Created by Kaan Ozdemir on 25.07.2020.
//  Copyright © 2020 Kaan Ozdemir. All rights reserved.
//

import Foundation
import RxSwift

class CarouselViewModel {
    
    let disposeBag = DisposeBag()
    
    let imageResponse = PublishSubject<ImageResponse>()
    
    let imageRepo = ImageRepo()
    
    func fetchImages(params: [String: Any], queryItems: [URLQueryItem]) {
        imageRepo.fecthImages(params: params, queryItems: queryItems).subscribe(onNext: { (response) in
            self.imageResponse.onNext(response)
        })
        .disposed(by: disposeBag)
    }
}

