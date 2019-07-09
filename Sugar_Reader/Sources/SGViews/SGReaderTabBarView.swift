//
//  SRReaderTabBarView.swift
//  Sugar_Reader
//
//  Created by YY on 2019/7/3.
//  Copyright © 2019 Sugar. All rights reserved.
//

import UIKit
import SideMenu

typealias SGReaderTabBarViewBlock = (_ index: Int) -> Void

class SGReaderTabBarView: SGBaseView {

    var readerTabBarViewBlock:SGReaderTabBarViewBlock?
    func setReadSetBrightBlock(_ block: @escaping SGReaderTabBarViewBlock) {
        readerTabBarViewBlock = block
    }
    
    func blockReaderTabBarView(_ index: Int)  {
        if readerTabBarViewBlock != nil{
            readerTabBarViewBlock!(index)
        }
    }
    
    override func initSubviews() {
        addSubview(buttonNight)
        addSubview(buttonSetting)
        addSubview(buttonMenu)
    }
    
    override func initSubviewsLayout() {
        var buttons:Array<UIButton> = Array()
        buttons.append(buttonNight)
        buttons.append(buttonSetting)
        buttons.append(buttonMenu)
        buttons.snp.distributeViewsAlong(axisType: .horizontal, fixedSpacing: 5, leadSpacing: 10, tailSpacing: 10)
        buttons.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            if UIDevice.isBangs{
                make.height.equalToSuperview().offset(-20)
            }else{
                make.height.equalToSuperview()
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        buttonMenu.layoutIfNeeded()
        buttonSetting.layoutIfNeeded()
        buttonNight.layoutIfNeeded()
        
        buttonNight.set(image: nightNorImage, title: "夜间", titlePosition: .bottom, additionalSpacing: 5, state: .normal)
        buttonNight.set(image: dayNorImage, title: "日间", titlePosition: .bottom, additionalSpacing: 5, state: .normal)
        buttonSetting.set(image: settingNorImage, title: "设置", titlePosition: .bottom, additionalSpacing: 5, state: .normal)
        buttonMenu.set(image: menuNorImage, title: "目录", titlePosition: .bottom, additionalSpacing: 5, state: .normal)
    }
    
    @objc func clickDayOrNight() {
        if buttonNight.isSelected{
            blockReaderTabBarView(1)
            //SGReaderSetDataManager.shared.readerTheme = .SG_Default
            buttonNight.isSelected = false
        }else{
            blockReaderTabBarView(0)
            
            buttonNight.isSelected = true
        }
    }
    
    @objc func clickSetting() {
        blockReaderTabBarView(2)
    }
    
    @objc func clickMenu() {
        blockReaderTabBarView(3)
    }
    
    
    
    lazy var buttonNight: UIButton = {
        let button = UIButton()
        button.setTitleColor( #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1) , for: .normal)
        button.tintColor = #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.set(image: nightNorImage, title: "夜间", titlePosition: .bottom, additionalSpacing: 3, state: .selected)
        button.set(image: dayNorImage, title: "日间", titlePosition: .bottom, additionalSpacing: 3, state: .normal)
        button.addTarget(self, action: #selector(clickDayOrNight), for: .touchUpInside)
        if SGReaderSetDataManager.shared.readerTheme == .SG_Night{
            button.isSelected = true
        }else{
            button.isSelected = false
        }
        return button
    }()
    
    lazy var buttonSetting: UIButton = {
        let button = UIButton()
        button.setTitleColor( #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1) , for: .normal)
        button.tintColor = #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.set(image: settingNorImage, title: "设置", titlePosition: .bottom, additionalSpacing: 3, state: .normal)
        button.addTarget(self, action: #selector(clickSetting), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonMenu: UIButton = {
        let button = UIButton()
        button.setTitleColor( #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1) , for: .normal)
        button.tintColor = #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.set(image: menuNorImage, title: "目录", titlePosition: .bottom, additionalSpacing: 3, state: .normal)
        button.addTarget(self, action: #selector(clickMenu), for: .touchUpInside)
        return button
    }()
    
    lazy var nightNorImage: UIImage = {
        let image = UIImage.init(named: "icon_reader_night")?.withRenderingMode(.alwaysTemplate)
        return image!
    }()
    
    lazy var dayNorImage: UIImage = {
        let image = UIImage.init(named: "icon_reader_day")?.withRenderingMode(.alwaysTemplate)
        return image!
    }()
    
    lazy var settingNorImage: UIImage = {
        let image = UIImage.init(named: "icon_reader_setting")?.withRenderingMode(.alwaysTemplate)
        return image!
    }()
    
    lazy var menuNorImage: UIImage = {
        let image = UIImage.init(named: "icon_reader_menu")?.withRenderingMode(.alwaysTemplate)
        return image!
    }()

}
