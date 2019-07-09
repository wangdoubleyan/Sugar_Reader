//
//  SGPageConDataModel.swift
//  Sugar_Reader
//
//  Created by YY on 2019/7/5.
//  Copyright © 2019 Sugar. All rights reserved.
//

import UIKit

class SGPageConDataModel: NSObject {
    
    /// 标题
    var title = ""
    /// 页码
    var pageIndex  = 0
    /// 总页数
    var pageCount = 0
    /// 章节码
    var chapterIndex = 0
    /// 章节总数
    var chapterCount = 0
    
    var attrString:NSAttributedString? = nil
    
    var turnPage:Bool = false
}

extension SGPageConDataModel{
    
    /// 是否含有上一章
    var hasPreviousChapter:Bool{
        if chapterIndex == 0{
            return false
        }else{
            return true
        }
    }
    
    /// 是否含有上一页
    var hasPreviousPage:Bool{
        if chapterIndex == 0{
            return false
        }else{
            return true
        }
    }
    
    /// 是否含有下一页
    var hasNextPage:Bool{
        if pageIndex < pageCount - 1{
            return true
        }
        return false
    }
    
    
    /// 是否含有下一章
    var hasNextChapter:Bool{
        if chapterIndex < chapterCount - 1{
            return true
        }
        return false
    }
    


}
