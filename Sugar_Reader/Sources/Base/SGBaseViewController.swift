//
//  SGBaseViewController.swift
//  Sugar_Reader
//
//  Created by YY on 2019/7/3.
//  Copyright © 2019 Sugar. All rights reserved.
//

import UIKit
import SnapKit

public class SGBaseViewController: UIViewController {

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        initSubviews()
        initSubviewsLayout()
    }
    
    func initSubviews() {
        
    }
    
    func initSubviewsLayout() {
        
    }

}
