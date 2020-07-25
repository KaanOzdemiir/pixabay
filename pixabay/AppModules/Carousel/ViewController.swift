//
//  ViewController.swift
//  pixabay
//
//  Created by Kaan Ozdemir on 25.07.2020.
//  Copyright © 2020 Kaan Ozdemir. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class ViewController: UIViewController {
    
    var viewModel = CarouselViewModel()
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            self.collectionView.register(UINib(nibName: "CarouselCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CarouselCollectionViewCell")
        }
    }
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!

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
        viewModel.imageResponse.subscribe(onNext: { [weak self] (response) in
            
            guard let strongSelf = self else {
                return
            }
            
            if response.message.isEmpty {
                print("🟢 response is ok")
                strongSelf.viewModel.response = response
                
//                strongSelf.collectionViewHeight.constant = strongSelf.collectionView.frame.width / strongSelf.viewModel.imageRatio
                strongSelf.collectionView.reloadData()
            }else {
                print("🔴 Error **-->", response.message)

            }
        })
            .disposed(by: viewModel.disposeBag)
    }


}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.response.hits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCollectionViewCell", for: indexPath) as! CarouselCollectionViewCell
        
        let hit = viewModel.response.hits[indexPath.item]
        
        cell.titleLabel.text = hit.tags
        cell.imageView.kf.indicatorType = .activity
        
        if let imageUrl = URL(string: hit.largeImageURL) {
            cell.imageView.kf.setImage(with: ImageResource(downloadURL: imageUrl))
        }
        
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
