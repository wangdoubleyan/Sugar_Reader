//
//  SGPagingModel.swift
//  Sugar_Reader
//
//  Created by YY on 2019/7/4.
//  Copyright © 2019 Sugar. All rights reserved.
//

import UIKit

public class SGPagingModel: NSObject {
    public var attrString:NSAttributedString?
    public var pageAttrStrings:Array<NSAttributedString>?
    public var chapterIndex:Int?
    public var title:String?
}

extension SGPagingModel{
    var pageCount:Int{
        if pageAttrStrings != nil{
            return pageAttrStrings!.count
        }
        return 0
    }
}
