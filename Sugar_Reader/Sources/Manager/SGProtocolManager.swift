//
//  SGProtocolManager.swift
//  Sugar_Reader
//
//  Created by YY on 2019/7/4.
//  Copyright © 2019 Sugar. All rights reserved.
//

import UIKit

class SGProtocolManager: NSObject {
    static let shared: SGProtocolManager = {
        let instance = SGProtocolManager()
        return instance
    }()
    
    var dataSource:SGReaderPageViewControllerDataSource? = nil
    var delegate:SGReaderPageViewControllerDelegate? = nil
}
