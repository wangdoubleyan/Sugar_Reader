//
//  SGDeviceExtension.swift
//  Sugar_Reader
//
//  Created by YY on 2019/7/4.
//  Copyright © 2019 Sugar. All rights reserved.
//

import UIKit

extension UIDevice{
    static var isBangs: Bool {
        if #available(iOS 11, *) {
            guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else {
                return false
            }
            if unwrapedWindow.safeAreaInsets.left > 0 || unwrapedWindow.safeAreaInsets.bottom > 0 {
                print(unwrapedWindow.safeAreaInsets)
                return true
            }
        }
        return false
    }
    
    static var screenWidth:CGFloat{
        return UIScreen.main.bounds.size.width
    }
    
    static var screenHeight:CGFloat{
        return UIScreen.main.bounds.size.height
    }
}

