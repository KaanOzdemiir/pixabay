//
//  ViewController.swift
//  pixabay
//
//  Created by Kaan Ozdemir on 25.07.2020.
//  Copyright © 2020 Kaan Ozdemir. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    var viewModel = CarouselViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        subscribeImageResponse()
        fetchImages()
        
    }
    
    func fetchImages() {
        var queryItems: [URLQueryItem] = AlamofireService.shared.defaultQueryItems()
        
        queryItems.append(URLQueryItem(name: "q", value: "beautiful+landscape"))
        queryItems.append(URLQueryItem(name: "image_type", value: "photo"))

        viewModel.fetchImages(params: [:], queryItems: queryItems)
    }
    
    func subscribeImageResponse() {
        viewModel.imageResponse.subscribe(onNext: { (response) in
            print("🟢 response is ok")
        })
            .disposed(by: viewModel.disposeBag)
    }


}

