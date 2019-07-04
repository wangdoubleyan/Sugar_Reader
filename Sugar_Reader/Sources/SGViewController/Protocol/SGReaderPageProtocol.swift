//
//  SGReaderPageProtocol.swift
//  Sugar_Reader
//
//  Created by YY on 2019/7/4.
//  Copyright © 2019 Sugar. All rights reserved.
//

import UIKit

@objc protocol SGReaderPageViewControllerDataSource:NSObjectProtocol {
    @objc optional func maxFontSize(for pageViewController: SGReaderPageViewController) -> Int
    @objc optional func minFontSize(for pageViewController: SGReaderPageViewController) -> Int
    @objc optional func defaultFontSize(for pageViewController: SGReaderPageViewController) -> Int
    @objc optional func fontName(for pageViewController: SGReaderPageViewController) -> String
    @objc optional func themes(for pageViewController: SGReaderPageViewController) -> [UIImage]
    @objc optional func setPoint(for pageViewController: SGReaderPageViewController) -> CGPoint
    func menuArrayOfReader(in pageViewController: SGReaderPageViewController) -> [SGChapterDataModel]
    func sgReaderPageViewController(_ readerPageViewController: SGReaderPageViewController, beforeChapterModel chapterModel: SGChapterDataModel) -> SGChapterDataModel
    func sgReaderPageViewController(_ readerPageViewController: SGReaderPageViewController, afterChapterModel chapterModel: SGChapterDataModel) -> SGChapterDataModel
}

@objc protocol SGReaderPageViewControllerDelegate {
    @objc optional func sgReaderPageViewController(_ readerPageViewController: SGReaderPageViewController, willTransitionWith chapterModel: SGChapterDataModel)
    @objc optional func sgReaderPageViewController(_ readerPageViewController: SGReaderPageViewController, didFinishAnimating finished: Bool, chapterModel: SGChapterDataModel, transitionCompleted completed: Bool)
    @objc optional func sgReaderPageViewController(_ readerPageViewController: SGReaderPageViewController, didClickMenu finished: Bool)
    @objc optional func sgReaderPageViewController(_ readerPageViewController: SGReaderPageViewController, didSelectTheme theme: Bool)
    @objc optional func sgReaderPageViewController(_ readerPageViewController: SGReaderPageViewController, didChangeFontSize fonSize: Int)
    @objc optional func sgReaderPageViewController(_ readerPageViewController: SGReaderPageViewController, didChangeBrightness Brightness: Int)
    @objc optional func sgReaderPageViewController(_ readerPageViewController: SGReaderPageViewController, didChangeTurnStyle turnStyle: Int)
}
