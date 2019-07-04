//
//  SGStringExtension.swift
//  Sugar_Reader
//
//  Created by YY on 2019/7/4.
//  Copyright © 2019 Sugar. All rights reserved.
//

import UIKit

extension String{
    func wrapTrim() -> String {
        var content = self.replacingOccurrences(of: "<p>", with: "", options: .literal, range: nil)
        content = content.replacingOccurrences(of: "\t", with: "", options: .literal, range: nil)
        content = content.replacingOccurrences(of: "</p>", with: "", options: .literal, range: nil)
        content = content.replacingOccurrences(of: "\r\n", with: "", options: .literal, range: nil)
        content = content.replacingOccurrences(of: "\n", with: "\n", options: .literal, range: nil)
        return content
    }
}
