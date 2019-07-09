//
//  SGReaderBasePageViewController.swift
//  Sugar_Reader
//
//  Created by YY on 2019/7/5.
//  Copyright © 2019 Sugar. All rights reserved.
//

import UIKit
import TYAttributedLabel

class SGReaderBasePageViewController: SGBaseViewController {
    var pageDataModel:SGPageConDataModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeTheme()
    }
    
    func changeTheme() {
        view.backgroundColor = SGReaderSetDataManager.shared.themeColor
        view.subviews.forEach {
            if $0 is TYAttributedLabel{
                ($0 as? TYAttributedLabel)?.textColor = SGReaderSetDataManager.shared.textColor
            }else if $0 is UILabel{
                ($0 as? UILabel)?.textColor = SGReaderSetDataManager.shared.textColor
            }else if $0 is SGBatterView{
                ($0 as? SGBatterView)?.textColor = SGReaderSetDataManager.shared.textColor
            }
        }
    }

}
