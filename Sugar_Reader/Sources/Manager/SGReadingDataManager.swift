//
//  SGReadingDataManager.swift
//  Sugar_Reader
//
//  Created by YY on 2019/7/4.
//  Copyright © 2019 Sugar. All rights reserved.
//

import UIKit

class SGReadingDataManager: NSObject {
    
    private var nextChapterPagingDataModel:SGPagingModel? = nil{
        didSet{
            print("下一章加载完成")
        }
    }
    private var previousChapterPagingDataModel:SGPagingModel? = nil{
        didSet{
            print("上一章加载完成")
        }
    }
    private var currentChapterPagingDataModel:SGPagingModel? = nil{
        didSet{
            if currentChapterPagingDataModel != nil{
                preLoadChapter()
            }
        }
    }
    
    private var currentChapterIndex:Int{
        if currentChapterPagingDataModel != nil{
            return currentChapterPagingDataModel?.chapterIndex ?? 0
        }
        return 0
    }
    
    private var currentChapterTitle:String{
        return SGMenuDataManager.shared.menuTitleFor(currentChapterIndex)
    }
    
    var currentPageIndex:Int = 0
    
    private var currentPageModel:SGPageConDataModel{
        let model = SGPageConDataModel()
        if currentChapterPagingDataModel != nil{
            model.chapterIndex = currentChapterIndex
            model.chapterCount = SGMenuDataManager.shared.menuCount
            model.pageIndex = currentPageIndex
            model.pageCount = currentChapterPagingDataModel!.pageCount
            model.title = currentChapterTitle
            if let pages = currentChapterPagingDataModel?.pageAttrStrings{
                if currentChapterIndex < pages.count{
                    model.attrString = pages[currentPageIndex]
                }
            }
        }
        return model
    }
    
    static let shared: SGReadingDataManager = {
        let instance = SGReadingDataManager()
        return instance
    }()
    
    func reloadChapter(completion: @escaping ((Bool) -> Void)) {
        let pagingProcess = SGPagingProcess()
        pagingProcess.setPagingProcessBlock { (status, pagingModel) in
            if pagingModel != nil{
                self.currentChapterPagingDataModel = pagingModel
                completion(true)
            }
        }
        pagingProcess.title = ""
        pagingProcess.index = currentPageIndex
        pagingProcess.content = currentChapterPagingDataModel?.attrString?.string
        pagingProcess.do()
    }
    
    func initBookChapterData(_ pagingModel:SGPagingModel,_ pageIndex:Int) {
        currentPageIndex = pageIndex
        currentChapterPagingDataModel = pagingModel
    }
    
    func preLoadChapter() {
        preLoadNextChapter()
        preLoadBeforeChapter()
    }
    
    func turnChapter(_ chapterIndex:Int) {
        if chapterIndex == nextChapterPagingDataModel?.chapterIndex{
            previousChapterPagingDataModel = currentChapterPagingDataModel
            currentChapterPagingDataModel = nextChapterPagingDataModel
            nextChapterPagingDataModel = nil
        }else{
            nextChapterPagingDataModel = currentChapterPagingDataModel
            currentChapterPagingDataModel = previousChapterPagingDataModel
            previousChapterPagingDataModel = nil
        }
    }
    
    func preLoadNextChapter() {
        if let dataSource = SGProtocolManager.shared.dataSource{
            let chapterModel = SGChapterDataModel()
            chapterModel.index = currentChapterIndex + 1
            chapterModel.title = SGMenuDataManager.shared.menuTitleFor(currentChapterIndex + 1)
            let nextChapterModel = dataSource.sgPreLoadNextChapterModel(chapterModel)
            let pagingProcess = SGPagingProcess()
            pagingProcess.setPagingProcessBlock { (status, pagingModel) in
                if pagingModel != nil{
                    self.nextChapterPagingDataModel = pagingModel
                }else{
                    
                }
            }
            pagingProcess.title = nextChapterModel.title
            pagingProcess.index = nextChapterModel.index
            pagingProcess.content = nextChapterModel.content
            pagingProcess.do()
        }
    }
    
    func preLoadBeforeChapter() {
        if let dataSource = SGProtocolManager.shared.dataSource{
            let chapterModel = SGChapterDataModel()
            chapterModel.index = currentChapterIndex + 1
            chapterModel.title = SGMenuDataManager.shared.menuTitleFor(currentChapterIndex + 1)
            let beforeChapterModel = dataSource.sgPreLoadBeforeChapterModel(chapterModel)
            let pagingProcess = SGPagingProcess()
            pagingProcess.setPagingProcessBlock { (status, pagingModel) in
                if pagingModel != nil{
                    self.previousChapterPagingDataModel = pagingModel
                }else{
                    
                }
            }
            pagingProcess.title = beforeChapterModel.title
            pagingProcess.index = beforeChapterModel.index
            pagingProcess.content = beforeChapterModel.content
            pagingProcess.do()
        }
    }
    
    /// 获取正文页
    func positivePageContentView(_ data:SGPageConDataModel? = nil) -> SGPositiveViewController {
        let vc = SGPositiveViewController()
        if data == nil{
            vc.pageDataModel = currentPageModel
        }else{
            vc.pageDataModel = data
        }
        return vc
    }
    
    /// 获取反面页
    func negativePageContentView(_ data:SGPageConDataModel) -> SGNegativeViewController {
        let vc = SGNegativeViewController()
        vc.pageDataModel = data
        return vc
    }
    
    func nextWillShowPageModel(_ pageModel:SGPageConDataModel) -> SGPositiveViewController {
        let nextPageModel = pageModel
        if pageModel.hasNextPage{
            nextPageModel.pageIndex = pageModel.pageIndex + 1
            nextPageModel.turnPage = false
            if let pages = currentChapterPagingDataModel?.pageAttrStrings{
                if nextPageModel.pageIndex < pages.count{
                    nextPageModel.attrString = pages[nextPageModel.pageIndex]
                }
                //model.chapterCount = pages.count
            }
        }else{
            if pageModel.hasNextChapter{
                nextPageModel.pageIndex = 0
                nextPageModel.chapterIndex = pageModel.chapterIndex + 1
                nextPageModel.pageCount = nextChapterPagingDataModel!.pageCount
                nextPageModel.title = SGMenuDataManager.shared.menuTitleFor(nextPageModel.chapterIndex)
                nextPageModel.turnPage = true
                if let pages = nextChapterPagingDataModel?.pageAttrStrings{
                    if nextPageModel.pageIndex < pages.count{
                        nextPageModel.attrString = pages[nextPageModel.pageIndex]
                    }
                }
            }
        }
        return positivePageContentView(nextPageModel)
    }
    
    func beforeWillShowPageModel(_ pageModel:SGPageConDataModel) -> SGPositiveViewController {
        let beforePageModel = pageModel
        if pageModel.hasPreviousChapter{
            beforePageModel.pageIndex = pageModel.pageIndex - 1
            beforePageModel.turnPage = false
            if let pages = currentChapterPagingDataModel?.pageAttrStrings{
                if beforePageModel.pageIndex < pages.count{
                    beforePageModel.attrString = pages[beforePageModel.pageIndex]
                }
                //model.chapterCount = pages.count
            }
        }else{
            if pageModel.hasPreviousChapter{
                beforePageModel.pageIndex = previousChapterPagingDataModel!.pageCount - 1
                beforePageModel.chapterIndex = pageModel.chapterIndex - 1
                beforePageModel.pageCount = beforePageModel.pageIndex + 1
                beforePageModel.title = SGMenuDataManager.shared.menuTitleFor(beforePageModel.chapterIndex)
                beforePageModel.turnPage = true
                if let pages = nextChapterPagingDataModel?.pageAttrStrings{
                    if beforePageModel.pageIndex < pages.count{
                        beforePageModel.attrString = pages[beforePageModel.pageIndex]
                    }
                }
            }
        }
        return positivePageContentView(beforePageModel)
    }
    
    func getWillShowPageVC(_ vc:UIViewController,_ next:Bool = true) -> UIViewController? {
        if let pageVC = vc as? SGReaderBasePageViewController{
            if let pageDataModel = pageVC.pageDataModel{
                if vc is SGPositiveViewController{
                    if SGReaderSetDataManager.shared.pageTurnStyle == .Curl{
                        return negativePageContentView(pageDataModel)
                    }else{
                        if next{
                            return nextWillShowPageModel(pageDataModel)
                        }else{
                            return beforeWillShowPageModel(pageDataModel)
                        }
                    }
                }else if vc is SGNegativeViewController{
                    if next{
                        return nextWillShowPageModel(pageDataModel)
                    }else{
                        return beforeWillShowPageModel(pageDataModel)
                    }
                }
            }
        }
        return nil
    }
}
