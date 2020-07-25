//
//  CarouselCollectionViewCell.swift
//  pixabay
//
//  Created by Kaan Ozdemir on 25.07.2020.
//  Copyright © 2020 Kaan Ozdemir. All rights reserved.
//

import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setFont()
        
        print(titleLabel.font.familyName)
    }
    
    func setFont() {
        titleLabel.font = TypeFace.regularFont(size: 16)
    }

}
