//
//  SGReaderPageViewModel.swift
//  Sugar_Reader
//
//  Created by YY on 2019/7/5.
//  Copyright © 2019 Sugar. All rights reserved.
//

import UIKit

class SGReaderPageViewModel: NSObject {
    
    func startReaderViewControllers() -> [UIViewController] {
        var viewControllers:[UIViewController] = []
        let readingManager = SGReadingDataManager.shared
        let positivePageContentView = readingManager.positivePageContentView()
        viewControllers.append(positivePageContentView)
        /*
        if (SGReaderSetDataManager.shared.pageTurnStyle == .Curl){
            viewControllers.append(readingManager.negativePageContentView(positivePageContentView.pageDataModel!))
        }*/
        return viewControllers
    }
    
    
    func viewControllersWith(chapterIndex:Int? = nil,pageIndex:Int? = nil) -> [UIViewController] {
        let viewControllers:[UIViewController] = []
        if chapterIndex == nil{
            //viewControllers.append(<#T##newElement: UIViewController##UIViewController#>)
        }
        return viewControllers
    }
    

    
    
    
    
    
}
