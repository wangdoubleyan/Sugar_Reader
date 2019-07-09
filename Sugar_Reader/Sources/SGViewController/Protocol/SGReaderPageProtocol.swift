//
//  SGReaderPageProtocol.swift
//  Sugar_Reader
//
//  Created by YY on 2019/7/4.
//  Copyright © 2019 Sugar. All rights reserved.
//

import UIKit

@objc public protocol SGReaderPageViewControllerDataSource:NSObjectProtocol {
    @objc optional func maxFontSizeForReader() -> Int
    @objc optional func minFontSizeForReader() -> Int
    @objc optional func defaultFontSizForReader() -> Int
    @objc optional func fontNameForReader() -> String
    @objc optional func themesForReader() -> [UIColor]
    @objc optional func textColorForTheme() -> [UIColor]
    @objc optional func setPointForReader() -> CGPoint
    func menuArrayForReader() -> [SGChapterDataModel]
    func sgPreLoadBeforeChapterModel(_ chapterModel: SGChapterDataModel) -> SGChapterDataModel
    func sgPreLoadNextChapterModel(_ chapterModel: SGChapterDataModel) -> SGChapterDataModel
    
}

@objc public protocol SGReaderPageViewControllerDelegate {
    @objc optional func sgReaderPageViewController(willTransitionWith chapterModel: SGChapterDataModel)
    @objc optional func sgReaderPageViewController(didFinishAnimating finished: Bool, chapterModel: SGChapterDataModel, transitionCompleted completed: Bool)
    @objc optional func sgReaderPageViewController(didClickMenu finished: Bool)
    @objc optional func sgReaderPageViewController(didSelectTheme theme: Bool)
    @objc optional func sgReaderPageViewController(didChangeFontSize fonSize: Int)
    @objc optional func sgReaderPageViewController(didChangeBrightness Brightness: Int)
    @objc optional func sgReaderPageViewController(didChangeTurnStyle turnStyle: Int)
    @objc optional func sgReaderPageViewController(didOpen success: Bool)
    func sgReaderPageViewController(didSelectChapter chapterModel:SGChapterDataModel, completion: @escaping ((SGChapterDataModel) -> Void))
}
