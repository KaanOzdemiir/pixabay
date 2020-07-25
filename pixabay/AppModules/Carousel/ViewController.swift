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
import SkeletonView

class ViewController: UIViewController {
    
    var viewModel = CarouselViewModel()
    var timer: Timer!

    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            self.collectionView.register(UINib(nibName: "CarouselCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CarouselCollectionViewCell")
        }
    }
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!

    @IBOutlet weak var leftArrowContainerView: UIView!
    @IBOutlet weak var leftArrowButton: UIButton!
    @IBAction func leftButtonTapped(_ sender: UIButton) {
        let item = viewModel.currenIndexPath.item - 1
        if item >= 0 {
            collectionView.scrollToItem(at: .init(item: item, section: 0), at: .left, animated: true)
        }
    }
    @IBOutlet weak var rightArrowContainerView: UIView!
    @IBOutlet weak var rightArrowButton: UIButton!
    @IBAction func rightButtonTapped(_ sender: UIButton) {
        let item = viewModel.currenIndexPath.item + 1
        if item < viewModel.response.hits.count {
            collectionView.scrollToItem(at: .init(item: item, section: 0), at: .right, animated: true)
        }else {
            collectionView.scrollToItem(at: .init(item: 0, section: 0), at: .right, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        configureSkeletonView()
        subscribeImageResponse()
        fetchImages()
        
    }
    
    func setupTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [unowned self] timer in
            self.rightButtonTapped(self.rightArrowButton)
        }
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
                
                // imageWidth ve imageHeight verileri çok değişken sabit veya sabite yakın bir ratio değeri yok
//                strongSelf.collectionViewHeight.constant = strongSelf.collectionView.frame.width / strongSelf.viewModel.imageRatio
                strongSelf.collectionView.reloadData()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self?.collectionView.hideSkeleton()
                    self?.leftArrowButton.hideSkeleton()
                    self?.leftArrowContainerView.hideSkeleton()
                    self?.rightArrowButton.hideSkeleton()
                    self?.rightArrowContainerView.hideSkeleton()
                    self?.setupTimer()
                }
            }else {
                print("🔴 Error **-->", response.message)

            }
        })
            .disposed(by: viewModel.disposeBag)
    }

    // MARK: SkeletonView Configirations
    func configureSkeletonView() {
        if #available(iOS 12.0, *) {
            if self.traitCollection.userInterfaceStyle == .dark {
                // User Interface is Dark
                view.showAnimatedSkeleton(usingColor: UIColor(red: 20 / 255, green: 23 / 255, blue: 22 / 255, alpha: 1))
                
            } else {
                // User Interface is Light
                let gradient = SkeletonGradient(baseColor: UIColor(red: 240 / 255, green: 243 / 255, blue: 242 / 255, alpha: 1))
                let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight, duration: 2)
                view.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
            }
        } else {
            // Fallback on earlier versions
            view.showAnimatedSkeleton(usingColor: UIColor(red: 240 / 255, green: 242 / 255, blue: 244 / 255, alpha: 1))
        }
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
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.currenIndexPath = indexPath
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

extension ViewController: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "CarouselCollectionViewCell"
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.response.hits.count
    }
    
    func numSections(in collectionSkeletonView: UICollectionView) -> Int {
        return 1
    }
}
