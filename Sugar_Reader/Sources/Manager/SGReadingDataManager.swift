//
//  SGReadingDataManager.swift
//  Sugar_Reader
//
//  Created by YY on 2019/7/4.
//  Copyright © 2019 Sugar. All rights reserved.
//

import UIKit

class SGReadingDataManager: NSObject {
    static let shared: SGMenuDataManager = {
        let instance = SGMenuDataManager()
        return instance
    }()
}
