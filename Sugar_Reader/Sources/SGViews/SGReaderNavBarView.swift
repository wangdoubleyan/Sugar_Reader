//
//  SGReaserNavBarView.swift
//  Sugar_Reader
//
//  Created by YY on 2019/7/3.
//  Copyright © 2019 Sugar. All rights reserved.
//

import UIKit

class SGReaderNavBarView: SGBaseView {

    
    override func initSubviews() {
        addSubview(previousButton)
    }
    
    override func initSubviewsLayout() {
        previousButton.snp.makeConstraints { (make) in
            make.width.equalTo(44)
            make.height.equalTo(44)
            make.bottom.equalToSuperview()
            make.left.equalTo(10)
        }
    }
    
    lazy var previousButton:UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        let image = UIImage.init(named: "ico_navbar_previous")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1) 
        return button
    }()
    
}
