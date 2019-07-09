//
//  SGReaderManager.swift
//  Sugar_Reader
//
//  Created by YY on 2019/7/4.
//  Copyright © 2019 Sugar. All rights reserved.
//

import UIKit

public class SGReaderManager: NSObject {
    /// 书籍目录数据
    public var menuArray:[SGChapterDataModel] = Array(){
        didSet{
            SGMenuDataManager.shared.menuArray = menuArray
        }
    }
    /// 书籍名称
    public var bookName:String = ""
    /// 书籍编号
    public var bookMd:String = ""
    /// 书籍作者
    public var bookAuthor:String = ""
    
    /// 是否使用Reader内容的阅读进度存储
    public var userReadProgress:Bool = true
    
    /// 开始阅读页码
    public var startPageIndex:Int = 0
    public var startChapterIndex:Int = 0
    /// 开始阅读的章节内容
    public var chapterContent:String = ""
    
    public var dataSource:SGReaderPageViewControllerDataSource? = nil{
        didSet{
            SGProtocolManager.shared.dataSource = dataSource
        }
    }
    public var delegate:SGReaderPageViewControllerDelegate? = nil{
        didSet{
            SGProtocolManager.shared.delegate = delegate
        }
    }
    
    
    public static let shared: SGReaderManager = {
        let instance = SGReaderManager()
        return instance
    }()
    
    public func startOpenBook(){
        let pagingProcess = SGPagingProcess()
        pagingProcess.setPagingProcessBlock { (status, pagingModel) in
            if pagingModel != nil{
                SGReadingDataManager.shared.initBookChapterData(pagingModel!, self.startPageIndex)
            }else{
                
            }
            
            if self.delegate != nil{
                self.delegate?.sgReaderPageViewController?(didOpen: true)
            }
            self.openReaderViewController()
        }
        pagingProcess.title = ""
        pagingProcess.index = startChapterIndex
        pagingProcess.content = chapterContent
        pagingProcess.do()
    }
    
    func openReaderViewController() {
        if let currVC = currentViewController(){
            if let navigationController = currVC.navigationController{
                navigationController.pushViewController(SGReaderPageViewController(), animated: true)
            }else{
                currVC.present(SGReaderPageViewController(), animated: true, completion: nil)
            }
            
        }
    }
    
    func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
    
    
    
    
}
