//
//  SGReaderManager.swift
//  Sugar_Reader
//
//  Created by YY on 2019/7/4.
//  Copyright © 2019 Sugar. All rights reserved.
//

import UIKit

public class SGReaderManager: NSObject {
    
    public var menuArray:[SGChapterDataModel] = Array()
    
    
    public static let shared: SGReaderManager = {
        let instance = SGReaderManager()
        return instance
    }()
}
