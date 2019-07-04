//
//  SGReaderPageViewController.swift
//  Sugar_Reader
//
//  Created by YY on 2019/7/3.
//  Copyright © 2019 Sugar. All rights reserved.
//

import UIKit



public class SGReaderPageViewController: SGBaseViewController {
    /// protocol
    var dataSource:SGReaderPageViewControllerDataSource? = nil
    var delegate:SGReaderPageViewControllerDelegate? = nil
    
    /// Data
    var menuArray:[SGChapterDataModel] = Array(){
        didSet{
            SGMenuDataManager.shared.menuArray = menuArray
        }
    }
    //var 
    
    ///
    private var pageView:UIPageViewController = UIPageViewController()
    

    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func initPageView() {
        
    }
    
    func refreshPageView() {
        
    }

}
