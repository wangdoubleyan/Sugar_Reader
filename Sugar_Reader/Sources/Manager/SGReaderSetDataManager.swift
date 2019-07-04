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
    
    var themeColors:[UIColor] = Array()
    var themeTextColors:[UIColor] = Array()
    
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
            return CGFloat(sgDefaults.float(forKey: "SGBrightness"))
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
            let row = readerTheme.hashValue
            if row < themeTextColors.count{
                return themeTextColors[row]
            }
            return .black
        }
    }
    
    var themeColor:UIColor?{
        get{
            let row = readerTheme.hashValue
            if row < themeColors.count{
                return themeColors[row]
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
