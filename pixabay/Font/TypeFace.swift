//
//  TypeFace.swift
//  pixabay
//
//  Created by Kaan Ozdemir on 25.07.2020.
//  Copyright © 2020 Kaan Ozdemir. All rights reserved.
//

import Foundation
import UIKit

class TypeFace {
    
    static var defaultFontFamily = "RopaSans"
    
    
    static func regularFont(size: CGFloat) -> UIFont {
        return UIFont(name: "\(defaultFontFamily)-Regular", size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    static func italicFont(size: CGFloat) -> UIFont {
        return UIFont(name: "\(defaultFontFamily)-Italic", size: size) ?? UIFont.systemFont(ofSize: size, weight: .medium)
    }
}
