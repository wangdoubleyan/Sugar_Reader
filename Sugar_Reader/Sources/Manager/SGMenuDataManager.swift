//
//  SGMenuDataManager.swift
//  Sugar_Reader
//
//  Created by YY on 2019/7/4.
//  Copyright © 2019 Sugar. All rights reserved.
//

import UIKit

public class SGMenuDataManager: NSObject {
    var menuArray:[SGChapterDataModel] = Array()
    
    public static let shared: SGMenuDataManager = {
        let instance = SGMenuDataManager()
        return instance
    }()
    
    var menuCount:Int{
        return menuArray.count
    }
    
    func menuDataFor(_ index:Int) -> SGChapterDataModel? {
        if index < menuCount{
            return menuArray[index]
        }
        return nil
    }
    
    func menuTitleFor(_ index:Int) -> String {
        if index < menuCount{
            return menuArray[index].title ?? ""
        }
        return ""
    }
    
    
    
}
