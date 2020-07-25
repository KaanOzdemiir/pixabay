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
    var response = ImageResponse()
    var imageRatio: CGFloat = 1
    
    func fetchImages(params: [String: Any], queryItems: [URLQueryItem]) {
        imageRepo.fecthImages(params: params, queryItems: queryItems).subscribe(onNext: { [weak self] (response) in
            self?.imageRatio = CGFloat((response.hits.first?.imageWidth ?? 1) / (response.hits.first?.imageHeight ?? 1))
            self?.imageResponse.onNext(response)
        })
        .disposed(by: disposeBag)
    }
}

