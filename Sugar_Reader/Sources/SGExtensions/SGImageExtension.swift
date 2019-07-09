//
//  SGImageExtension.swift
//  Sugar_Reader_VC
//
//  Created by YY on 2019/7/6.
//  Copyright © 2019 Sugar. All rights reserved.
//

import UIKit

extension UIImage{
    var scaleFullSize:UIImage?{
        let scale = UIScreen.main.scale
        let size = UIScreen.main.bounds.size
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let sizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return sizeImage
    }

}
