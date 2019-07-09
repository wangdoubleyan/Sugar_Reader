//
//  SGReaderSetDataManager.swift
//  Sugar_Reader
//
//  Created by YY on 2019/7/4.
//  Copyright © 2019 Sugar. All rights reserved.
//

import UIKit

class SGReaderSetDataManager: NSObject {
    public static let shared: SGReaderSetDataManager = {
        let instance = SGReaderSetDataManager()
        return instance
    }()
    let sgDefaults = UserDefaults.standard
    
    var themeColors:[UIColor]{
        if let themeColor = SGProtocolManager.shared.dataSource?.themesForReader?(){
            return themeColor
        }
        let whiteColor = UIColor(patternImage: (UIImage.init(named: "pic_BG_theme_white")?.scaleFullSize)!)
        let blackColor = UIColor(patternImage: (UIImage.init(named: "pic_BG_theme_black")?.scaleFullSize)!)
        let greenColor = UIColor(patternImage: (UIImage.init(named: "pic_BG_theme_green")?.scaleFullSize)!)
        let redColor = UIColor(patternImage: (UIImage.init(named: "pic_BG_theme_red")?.scaleFullSize)!)
        let yelloColor = UIColor(patternImage: (UIImage.init(named: "pic_BG_theme_yellow")?.scaleFullSize)!)
        return [whiteColor,blackColor,greenColor,redColor,yelloColor,.black]
    }
    var themeTextColors:[UIColor]{
        if let colors = SGProtocolManager.shared.dataSource?.textColorForTheme?(){
            return colors
        }
        return [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0.2980392157, green: 0.337254902, blue: 0.4, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0.2980392157, green: 0.337254902, blue: 0.4, alpha: 1)]
    }
    
    /// 上边距
    let marginTop:CGFloat = UIDevice.isBangs ? 72 : 42
    /// 下边距
    let marginBottom:CGFloat = 50
    /// 两边间距
    let marginSide:CGFloat = 20
    /// 阅读器尺寸
    var readerTextSize:CGSize{
        let width = UIDevice.screenWidth - 2 * marginSide
        let height = UIDevice.screenHeight - marginTop - marginBottom
        return CGSize(width: width, height: height)
    }
    
    /// 字体名称
    var fontName:String{
        get{
            if let dataSource = SGProtocolManager.shared.dataSource{
                if let fontName = dataSource.fontNameForReader?(){
                    return fontName
                }
            }
            return "PingFang SC"
        }
    }
    
    /// 字体大小
    var fontSize:Int{
        get{
            let fontSize = sgDefaults.integer(forKey: "SGFontSize")
            if fontSize > 0{
                return fontSize
            }
            return 20
        }
        set{
            sgDefaults.set(newValue, forKey: "SGFontSize")
            sgDefaults.synchronize()
        }
    }
    
    var maxFontSize:Int{
        get{
            if let dataSource = SGProtocolManager.shared.dataSource{
                if let size = dataSource.maxFontSizeForReader?(){
                    return size
                }
            }
            return 30
        }
    }
    
    var minFontSize:Int{
        get{
            if let dataSource = SGProtocolManager.shared.dataSource{
                if let size = dataSource.minFontSizeForReader?(){
                    return size
                }
            }
            return 15
        }
    }
    
    var readerFont:UIFont{
        if let font = UIFont(name: fontName, size: CGFloat(fontSize)){
            return font
        }
        return UIFont.systemFont(ofSize: CGFloat(fontSize))
    }
    
    var readerTitleFont:UIFont{
        if let font = UIFont(name: fontName, size: 25){
            return font
        }
        return UIFont.systemFont(ofSize: 25)
    }
    
    var readerTheme:SGReaderTheme{
        get{
            if let theme = SGReaderTheme(rawValue: sgDefaults.integer(forKey: "SGTheme")){
                return theme
            }
            return .SG_Default
        }
        set{
            sgDefaults.set(newValue.rawValue, forKey: "SGTheme")
            sgDefaults.synchronize()
        }
    }
    
    var characterSpacing:CGFloat{
        get{
            return 2.5
        }
    }
    
    var linesSpacing:CGFloat{
        get{
            return 10
        }
    }
    
    var paragraphSpacing:CGFloat{
        get{
            return 15
        }
    }
    
    var firstLineHeadIndent:CGFloat{
        get{
            return 40
        }
    }
    
    var brightness:CGFloat{
        get{
            let value = CGFloat(sgDefaults.float(forKey: "SGBrightness"))
            if value < 30{
                return 100
            }
            return value
        }
        set{
            sgDefaults.set(newValue, forKey: "SGBrightness")
            sgDefaults.synchronize()
        }
    }
    
    var pageTurnStyle:SGPageTurnStyle{
        get{
            return SGPageTurnStyle(rawValue: sgDefaults.integer(forKey: "SGTransitionStyle"))!
        }
        set{
            sgDefaults.set(newValue.rawValue, forKey: "SGTransitionStyle")
            sgDefaults.synchronize()
        }
    }
    
    var textColor:UIColor{
        get{
            let row = readerTheme.rawValue
            if row < themeTextColors.count{
                return themeTextColors[row]
            }
            return .black
        }
    }
    
    var themeColor:UIColor?{
        get{
            let row = readerTheme.rawValue
            if row >= 0{
                if row < themeColors.count{
                    return themeColors[row]
                }
            }
            return .white
        }
    }
    
    var barTintColor:UIColor{
        get{
            switch readerTheme {
            case .SG_Night:
                return #colorLiteral(red: 0.3294117647, green: 0.3294117647, blue: 0.3294117647, alpha: 1)
            default:
                return #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
            }
        }
    }
    
    var nightTheme:Bool{
        switch readerTheme {
        case .SG_Night:
            return true
        default:
            return false
        }
    }
    
}
