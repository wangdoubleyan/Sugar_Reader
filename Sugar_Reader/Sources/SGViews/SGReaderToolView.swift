//
//  SGReaderToolView.swift
//  Sugar_Reader_VC
//
//  Created by YY on 2019/7/5.
//  Copyright © 2019 Sugar. All rights reserved.
//

import UIKit
import fluid_slider
import TYText

protocol SGReaderToolViewDelegate {
    func readerToolView(brightChange value:Int)
    func readerToolView(fontSizeChange value:Int)
    func readerToolView(themeChange theme:SGReaderTheme)
    func readerToolView(turnStyleChange style:SGPageTurnStyle)
}

typealias SGFontSizeChangeBlock = (_ value: Int) -> Void
typealias SGThemeViewChangeBlock = (_ theme: SGReaderTheme) -> Void
typealias SGPageTurningChangeBlock = (_ style: SGPageTurnStyle) -> Void


class SGReaderToolView: SGBaseView {
    var delegate:SGReaderToolViewDelegate?
    override func initSubviews() {
        clipsToBounds = true
        layer.cornerRadius = 15
        set(.height, of: 240, priority: .defaultHigh)
        brightnessSlider.addSubview(brightImageView)
        addSubview(brightnessSlider)
        addSubview(fontSizeView)
        addSubview(themeView)
        addSubview(pageTurnView)
    }
    
    override func initSubviewsLayout() {
        brightnessSlider.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(10)
            make.width.equalTo(40)
            if UIDevice.isBangs{
                make.bottom.equalTo(-20)
            }else{
                make.bottom.equalTo(-10)
            }
        }
        
        fontSizeView.snp.makeConstraints { (make) in
            make.left.equalTo(brightnessSlider.snp.right).offset(10)
            make.top.equalTo(brightnessSlider).offset(30)
            make.height.equalTo(40)
            make.right.equalToSuperview().offset(-10)
        }
        
        themeView.snp.makeConstraints { (make) in
            make.left.equalTo(fontSizeView)
            make.top.equalTo(fontSizeView.snp.bottom).offset(35)
            make.height.equalTo(40)
            make.right.equalToSuperview().offset(-10)
        }
        
        pageTurnView.snp.makeConstraints { (make) in
            make.left.equalTo(fontSizeView)
            make.bottom.equalTo(brightnessSlider)
            make.height.equalTo(40)
            make.right.equalToSuperview().offset(-10)
        }
        
        brightImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.bottom.equalTo(-10)
        }
    }
    
    @objc func brightChange() {
        SGReaderSetDataManager.shared.brightness = CGFloat(brightnessSlider.value)
        if delegate != nil{
            delegate?.readerToolView(brightChange: Int(brightnessSlider.value))
        }
    }
    
    lazy var brightnessSlider: BGSlider = {
        let slider = BGSlider()
        slider.vertical = true
        slider.minimum = 30
        slider.maximum = 100
        slider.layer.shadowColor = UIColor.black.cgColor
        slider.layer.shadowOffset = CGSize(width: 0, height: 0)
        slider.layer.shadowRadius = 1
        slider.layer.shadowOpacity = 0.3
        slider.layer.masksToBounds = false
        slider.thumbTint = UIColor.white.withAlphaComponent(0.9)
        slider.setValue(Float(SGReaderSetDataManager.shared.brightness), animated: false)
        slider.addTarget(self, action: #selector(brightChange), for: .valueChanged)
        return slider
    }()
    
    lazy var brightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "pic_readtool_light")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.gray.withAlphaComponent(0.7)
        return imageView
    }()
    
    lazy var fontSizeView: SGFontSizeView = {
        let view = SGFontSizeView()
        view.setFontSizeChangeBlock({ (fontSize) in
            if self.delegate != nil{
                self.delegate?.readerToolView(fontSizeChange: fontSize)
            }
        })
        return view
    }()
    
    lazy var themeView: SGThemeView = {
        let view = SGThemeView()
        view.setThemeViewChangeBlock({ (theme) in
            if self.delegate != nil{
                self.delegate?.readerToolView(themeChange: theme)
            }
        })
        return view
    }()
    
    lazy var pageTurnView: SGPageTurningView = {
        let view = SGPageTurningView()
        view.setPageTurningChangeBlock({ (style) in
            if self.delegate != nil{
                self.delegate?.readerToolView(turnStyleChange: style)
            }
        })
        return view
    }()
}

class SGFontSizeView: SGBaseView {
    override func initSubviews() {
        addSubview(imageView)
        addSubview(fontSizeSlider)
    }
    
    override func initSubviewsLayout() {
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        fontSizeSlider.snp.makeConstraints { (make) in
            make.left.equalTo(imageView.snp.right).offset(15)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(35)
        }
    }
    
    @objc func fontSizeChange() {
        let fontSize = 14 + fontSizeSlider.fraction * 18
        blockFontSizeChange(Int(roundf(Float(fontSize))))
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "icon_set_fontsize")
        return imageView
    }()
    
    lazy var minAttributedText: NSAttributedString = {
        let text = NSMutableAttributedString(string: "14")
        text.ty_add(.white, range: NSRange(location: 0, length: 2))
        return text
    }()
    
    lazy var maxAttributedText: NSAttributedString = {
        let text = NSMutableAttributedString(string: "32")
        text.ty_add(.white, range: NSRange(location: 0, length: 2))
        return text
    }()
    
    
    lazy var fontSizeSlider: Slider = {
        let slider = Slider()
        slider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 2
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: ( 14 + fraction * 18) as NSNumber) ?? ""
            return NSAttributedString(string: string)
        }
        
        
        
        slider.setMinimumLabelAttributedText(minAttributedText)
        slider.setMaximumLabelAttributedText(maxAttributedText)
        slider.fraction = (CGFloat(SGReaderSetDataManager.shared.fontSize) - CGFloat(14))/CGFloat(18)
        slider.shadowOffset = CGSize(width: 0, height: 0)
        slider.shadowBlur = 5
        slider.shadowColor = UIColor(white: 0, alpha: 0.1)
        slider.contentViewColor = #colorLiteral(red: 0.09411764706, green: 0.3882352941, blue: 0.8588235294, alpha: 1)
        slider.addTarget(self, action: #selector(fontSizeChange), for: .valueChanged)
        slider.valueViewColor = .white
        return slider
    }()
    
    //MARK : - BLOCK
    var fontSizeChangeBlock:SGFontSizeChangeBlock?
    func setFontSizeChangeBlock(_ block: @escaping SGFontSizeChangeBlock) {
        fontSizeChangeBlock = block
    }
    
    func blockFontSizeChange(_ fontSize: Int)  {
        if fontSizeChangeBlock != nil{
            fontSizeChangeBlock!(fontSize)
        }
    }
    
}

class SGThemeView: SGBaseView {
    
    override func initSubviews() {
        addSubview(imageView)
        addSubview(themeBaseView)
        themeBaseView.addSubview(themeWhiteView)
        themeBaseView.addSubview(themeBlackView)
        themeBaseView.addSubview(themeGreenView)
        themeBaseView.addSubview(themeRedView)
        themeBaseView.addSubview(themeYellowView)
        themeSelectd()
    }
    
    override func initSubviewsLayout() {
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        themeBaseView.snp.makeConstraints { (make) in
            make.left.equalTo(imageView.snp.right).offset(15)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(30)
        }
        
        var buttons:Array<UIImageView> = Array()
        buttons.append(themeWhiteView)
        buttons.append(themeBlackView)
        buttons.append(themeGreenView)
        buttons.append(themeRedView)
        buttons.append(themeYellowView)
        buttons.snp.distributeViewsAlong(axisType: .horizontal, fixedSpacing: 15, leadSpacing: 10, tailSpacing: 10)
        buttons.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.height.equalToSuperview()
        }
    }
    
    func themeSelectd() {
        for subview in themeBaseView.subviews{
            if subview is UIImageView{
                subview.layer.borderWidth = 0
            }
        }
        switch SGReaderSetDataManager.shared.readerTheme {
        case .SG_Black:
            themeBlackView.layer.borderWidth = 2
            break
        case .SG_Default:
            themeWhiteView.layer.borderWidth = 2
            break
        case .SG_Pink:
            themeRedView.layer.borderWidth = 2
            break
        case .SG_Night:
            //.layer.borderWidth = 1
            break
        case .SG_Retro:
            themeYellowView.layer.borderWidth = 2
            break
        case .SG_Green:
            themeGreenView.layer.borderWidth = 2
        }
    }
    
    @objc func selectThemeTapAction(recognizer: UITapGestureRecognizer) {
        let tag = recognizer.view!.tag
        let theme = SGReaderTheme(rawValue: tag)!
        SGReaderSetDataManager.shared.readerTheme = theme
        themeSelectd()
        blockThemeViewChange(theme)
        
    }
    
    
    
    lazy var themeBaseView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "icon_set_theme")
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var themeWhiteView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "pic_theme_white")
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.layer.borderColor = #colorLiteral(red: 0.09411764706, green: 0.3882352941, blue: 0.8588235294, alpha: 1)
        imageView.tag = 0
        imageView.isUserInteractionEnabled = true
        let tapReaderView = UITapGestureRecognizer(target: self, action: #selector(selectThemeTapAction(recognizer:)))
        imageView.addGestureRecognizer(tapReaderView)
        return imageView
    }()
    
    lazy var themeBlackView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "pic_theme_black")
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.layer.borderColor = #colorLiteral(red: 0.09411764706, green: 0.3882352941, blue: 0.8588235294, alpha: 1)
        imageView.tag = 1
        imageView.isUserInteractionEnabled = true
        let tapReaderView = UITapGestureRecognizer(target: self, action: #selector(selectThemeTapAction(recognizer:)))
        imageView.addGestureRecognizer(tapReaderView)
        return imageView
    }()
    
    lazy var themeGreenView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "pic_theme_green")
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.layer.borderColor = #colorLiteral(red: 0.09411764706, green: 0.3882352941, blue: 0.8588235294, alpha: 1)
        imageView.tag = 2
        imageView.isUserInteractionEnabled = true
        let tapReaderView = UITapGestureRecognizer(target: self, action: #selector(selectThemeTapAction(recognizer:)))
        imageView.addGestureRecognizer(tapReaderView)
        return imageView
    }()
    
    lazy var themeRedView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "pic_theme_red")
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.layer.borderColor = #colorLiteral(red: 0.09411764706, green: 0.3882352941, blue: 0.8588235294, alpha: 1)
        imageView.tag = 3
        imageView.isUserInteractionEnabled = true
        let tapReaderView = UITapGestureRecognizer(target: self, action: #selector(selectThemeTapAction(recognizer:)))
        imageView.addGestureRecognizer(tapReaderView)
        return imageView
    }()
    
    lazy var themeYellowView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "pic_theme_yellow")
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.layer.borderColor = #colorLiteral(red: 0.09411764706, green: 0.3882352941, blue: 0.8588235294, alpha: 1)
        imageView.tag = 4
        imageView.isUserInteractionEnabled = true
        let tapReaderView = UITapGestureRecognizer(target: self, action: #selector(selectThemeTapAction(recognizer:)))
        imageView.addGestureRecognizer(tapReaderView)
        return imageView
    }()
    
    //MARK : - BLOCK
    var themeViewChangeBlock:SGThemeViewChangeBlock?
    func setThemeViewChangeBlock(_ block: @escaping SGThemeViewChangeBlock) {
        themeViewChangeBlock = block
    }
    
    func blockThemeViewChange(_ theme: SGReaderTheme)  {
        if themeViewChangeBlock != nil{
            themeViewChangeBlock!(theme)
        }
    }
}

class SGPageTurningView: SGBaseView {
    override func initSubviews() {
        addSubview(imageView)
        addSubview(typeBaseView)
        typeBaseView.addSubview(buttonCurl)
        typeBaseView.addSubview(buttonScroll)
        typeBaseView.addSubview(buttonNone)
        pageTrunSelected()
    }
    
    override func initSubviewsLayout() {
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        typeBaseView.snp.makeConstraints { (make) in
            make.left.equalTo(imageView.snp.right).offset(15)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(30)
        }
        
        var buttons:Array<UIButton> = Array()
        buttons.append(buttonCurl)
        buttons.append(buttonScroll)
        buttons.append(buttonNone)
        buttons.snp.distributeViewsAlong(axisType: .horizontal, fixedSpacing: 15, leadSpacing: 10, tailSpacing: 10)
        buttons.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.height.equalToSuperview()
        }
    }
    
    @objc func selectPageTrunTapAction(recognizer: UITapGestureRecognizer) {
        let tag = recognizer.view!.tag
        let theme = SGReaderTheme(rawValue: tag)!
        SGReaderSetDataManager.shared.readerTheme = theme
        pageTrunSelected()
    }
    
    @objc func clickCurl() {
        clickSelectStyle(.Curl)
    }
    
    @objc func clickScroll() {
        clickSelectStyle(.Scroll)
    }
    
    @objc func clickNone() {
        clickSelectStyle(.None)
    }
    
    func clickSelectStyle(_ style:SGPageTurnStyle) {
        if style != SGReaderSetDataManager.shared.pageTurnStyle{
            SGReaderSetDataManager.shared.pageTurnStyle = style
            pageTrunSelected()
            blockPageTurningChange(style)
        }
    }
    
    func pageTrunSelected() {
        buttonNone.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        buttonScroll.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        buttonCurl.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        switch SGReaderSetDataManager.shared.pageTurnStyle {
        case .Curl:
            buttonCurl.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.3882352941, blue: 0.8588235294, alpha: 1)
        case .None:
            buttonNone.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.3882352941, blue: 0.8588235294, alpha: 1)
        case .Scroll:
            buttonScroll.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.3882352941, blue: 0.8588235294, alpha: 1)
        }
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "icon_set_pageturn")
        return imageView
    }()
    
    lazy var typeBaseView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var buttonCurl: UIButton = {
        let button = UIButton()
        button.setTitle("仿真", for: .normal)
        button.backgroundColor = .gray
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(clickCurl), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonScroll: UIButton = {
        let button = UIButton()
        button.setTitle("平滑", for: .normal)
        button.backgroundColor = .gray
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(clickScroll), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonNone: UIButton = {
        let button = UIButton()
        button.setTitle("无", for: .normal)
        button.backgroundColor = .gray
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(clickNone), for: .touchUpInside)
        return button
    }()
    
    //MARK : - BLOCK
    var pageTurningChangeBlock:SGPageTurningChangeBlock?
    func setPageTurningChangeBlock(_ block: @escaping SGPageTurningChangeBlock) {
        pageTurningChangeBlock = block
    }
    
    func blockPageTurningChange(_ style: SGPageTurnStyle)  {
        if pageTurningChangeBlock != nil{
            pageTurningChangeBlock!(style)
        }
    }
}
