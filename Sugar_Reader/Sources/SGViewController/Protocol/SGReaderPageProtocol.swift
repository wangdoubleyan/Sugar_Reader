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
    @objc optional func themesForReader() -> [UIImage]
    @objc optional func setPointForReader() -> CGPoint
    func menuArrayForReader() -> [SGChapterDataModel]
    func sgReaderPageViewController(_ readerPageViewController: SGReaderPageViewController, beforeChapterModel chapterModel: SGChapterDataModel) -> SGChapterDataModel
    func sgReaderPageViewController(_ readerPageViewController: SGReaderPageViewController, afterChapterModel chapterModel: SGChapterDataModel) -> SGChapterDataModel
}

@objc public protocol SGReaderPageViewControllerDelegate {
    @objc optional func sgReaderPageViewController(_ readerPageViewController: SGReaderPageViewController, willTransitionWith chapterModel: SGChapterDataModel)
    @objc optional func sgReaderPageViewController(_ readerPageViewController: SGReaderPageViewController, didFinishAnimating finished: Bool, chapterModel: SGChapterDataModel, transitionCompleted completed: Bool)
    @objc optional func sgReaderPageViewController(_ readerPageViewController: SGReaderPageViewController, didClickMenu finished: Bool)
    @objc optional func sgReaderPageViewController(_ readerPageViewController: SGReaderPageViewController, didSelectTheme theme: Bool)
    @objc optional func sgReaderPageViewController(_ readerPageViewController: SGReaderPageViewController, didChangeFontSize fonSize: Int)
    @objc optional func sgReaderPageViewController(_ readerPageViewController: SGReaderPageViewController, didChangeBrightness Brightness: Int)
    @objc optional func sgReaderPageViewController(_ readerPageViewController: SGReaderPageViewController, didChangeTurnStyle turnStyle: Int)
    @objc optional func sgReaderPageViewController(_ readerPageViewController: SGReaderPageViewController, didOpen success: Bool)
}
