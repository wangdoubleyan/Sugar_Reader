//
//  SGReaderPageViewController.swift
//  Sugar_Reader
//
//  Created by YY on 2019/7/3.
//  Copyright © 2019 Sugar. All rights reserved.
//

import UIKit



class SGReaderPageViewController: SGBaseViewController {
    /// protocol
    var dataSource:SGReaderPageViewControllerDataSource? = nil
    var delegate:SGReaderPageViewControllerDelegate? = nil
    
    /// Data
    var menuArray:[SGChapterDataModel] = Array()
    //var 
    
    ///
    private var pageView:UIPageViewController = UIPageViewController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func initPageView() {
        
    }
    
    func refreshPageView() {
        
    }

}
