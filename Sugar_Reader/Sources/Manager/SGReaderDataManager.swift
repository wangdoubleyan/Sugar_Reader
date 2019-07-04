//
//  SGReaderDataManager.swift
//  Sugar_Reader
//
//  Created by YY on 2019/7/4.
//  Copyright © 2019 Sugar. All rights reserved.
//

import UIKit

/// 获取阅读器中的相关数据
class SGReaderDataManager: NSObject {
    
    
    
    static let shared: SGReaderDataManager = {
        let instance = SGReaderDataManager()
        return instance
    }()
}
