//
//  SGReaderPageViewController.swift
//  Sugar_Reader
//
//  Created by YY on 2019/7/3.
//  Copyright © 2019 Sugar. All rights reserved.
//

import UIKit
import SideMenu
import SwiftEntryKit

public class SGReaderPageViewController: SGBaseViewController {
    ///
    private var sgReaderView = UIPageViewController()
    
    override func initSubviews() {
        view.backgroundColor = .white
        initPageView()
        initGestureRecognizer()
        openReadingBook()
        initBookSideMenu()
        view.addSubview(navigationBarView)
        view.addSubview(tabBarView)
    }
    
    override func initSubviewsLayout() {
        navigationBarView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            if UIDevice.isBangs{
                make.height.equalTo(88)
            }else{
                make.height.equalTo(64)
            }
            make.bottom.equalTo(view.snp.top)
        }
        tabBarView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(view.snp.bottom)
            if UIDevice.isBangs{
                make.height.equalTo(70)
            }else{
                make.height.equalTo(50)
            }
        }
    }
    
    func openReadingBook() {
        sgReaderView.setViewControllers(viewModel.startReaderViewControllers(), direction: .forward, animated: false) { (success) in
            
        }
    }
    
    func initPageView() {
        refreshPageView()
        addChild(sgReaderView)
        view.addSubview(sgReaderView.view)
        view.addSubview(brightView)
        brightView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    @objc func readerTapAction(){
        navBarShowOrHidden()
        tabBarShowOrHidden()
    }
    
    func navBarShowOrHidden() {
        navigationBarView.layoutIfNeeded()
        if navigationBarView.frame.origin.y == 0{
            hideNavBar()
        }else{
            UIView.animate(withDuration: 0.35) {
                var rect = self.navigationBarView.frame
                rect.origin.y = 0
                self.navigationBarView.frame = rect
            }
        }
    }
    
    func hideNavBar() {
        UIView.animate(withDuration: 0.35) {
            var rect = self.navigationBarView.frame
            rect.origin.y = -rect.size.height
            self.navigationBarView.frame = rect
        }
    }
    
    func tabBarShowOrHidden() {
        tabBarView.layoutIfNeeded()
        if tabBarView.frame.origin.y == view.frame.size.height {
            UIView.animate(withDuration: 0.35) {
                var rect = self.tabBarView.frame
                rect.origin.y = self.view.frame.size.height - rect.size.height
                self.tabBarView.frame = rect
            }
        }else{
            hideTabBar()
        }
    }
    
    func hideTabBar() {
        UIView.animate(withDuration: 0.35) {
            var rect = self.tabBarView.frame
            rect.origin.y = self.view.frame.size.height
            self.tabBarView.frame = rect
        }
    }
    
    func hideNavBarAndTabBar() {
        hideNavBar()
        hideTabBar()
    }
    
    
    
    func initGestureRecognizer() {
        let tapReaderView = UITapGestureRecognizer(target: self, action: #selector(readerTapAction))
        view.addGestureRecognizer(tapReaderView)
    }
    
    func initBookSideMenu() {
        let menuVC = SGReaderMenuViewController()
        menuVC.delegate = self
        let rightNavController = UISideMenuNavigationController(rootViewController: menuVC)
        SideMenuManager.default.menuRightNavigationController = rightNavController
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuShadowOpacity = 0.3
        SideMenuManager.default.menuWidth = UIDevice.screenWidth * 0.75
        SideMenuManager.default.menuAnimationTransformScaleFactor = 0.90
        SideMenuManager.default.menuAnimationBackgroundColor = .clear
        //SideMenuManager.default.menuAnimationBackgroundColor = UIColor.black
        SideMenuManager.default.menuFadeStatusBar = false
    }
    
    func refreshPageView() {
        let setManager = SGReaderSetDataManager.shared
        let transitionStyle:UIPageViewController.TransitionStyle = (setManager.pageTurnStyle == .Curl ? .pageCurl : .scroll)
        let pageViewController = UIPageViewController(transitionStyle: transitionStyle, navigationOrientation: .horizontal, options: nil)
        pageViewController.view.frame = CGRect(x: 0, y: 0, width: UIDevice.screenWidth, height: UIDevice.screenHeight)
        pageViewController.delegate = self
        pageViewController.isDoubleSided = (transitionStyle == .pageCurl ? true : false)
        if setManager.pageTurnStyle != .None{
            pageViewController.dataSource = self
        }else{
            pageViewController.dataSource = nil
        }
        sgReaderView = pageViewController
    }
    
    /// MARK : - lazy
    lazy var navigationBarView: SGReaderNavBarView = {
        let barView = SGReaderNavBarView()
        barView.backgroundColor = .white
        barView.layer.shadowColor = UIColor.black.cgColor
        barView.layer.shadowOffset = CGSize(width: 0, height: 0)
        barView.layer.shadowRadius = 1
        barView.layer.shadowOpacity = 0.3
        barView.layer.masksToBounds = false
        return barView
    }()
    
    lazy var tabBarView: SGReaderTabBarView = {
        let tabBarView = SGReaderTabBarView()
        tabBarView.backgroundColor = .white
        tabBarView.layer.shadowColor = UIColor.black.cgColor
        tabBarView.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBarView.layer.shadowRadius = 1
        tabBarView.layer.shadowOpacity = 0.3
        tabBarView.layer.masksToBounds = false
        tabBarView.setReadSetBrightBlock({ (index) in
            self.hideNavBarAndTabBar()
            if index == 1{
                SGReaderSetDataManager.shared.readerTheme = .SG_Night
                self.changeTheme(.SG_Night)
            }else if index == 0{
                SGReaderSetDataManager.shared.readerTheme = .SG_Default
                self.changeTheme(.SG_Default)
            }else if index == 2{
                SwiftEntryKit.display(entry: self.readerToolView, using: EKAttributes().readerToolAttributes, presentInsideKeyWindow: true)
            }else if index == 3{
                self.present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
            }
        })
        return tabBarView
    }()
    
    lazy var brightView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = CGFloat(1 - (Float(SGReaderSetDataManager.shared.brightness)/100))
        view.isUserInteractionEnabled=false
        return view
    }()
    
    lazy var viewModel: SGReaderPageViewModel = {
        let viewModel = SGReaderPageViewModel()
        return viewModel
    }()
    
    lazy var readerToolView: SGReaderToolView = {
        let view = SGReaderToolView()
        view.backgroundColor = .white
        view.delegate = self
        return view
    }()
    
}

extension SGReaderPageViewController:UIPageViewControllerDataSource{
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return SGReadingDataManager.shared.getWillShowPageVC(viewController,false)
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return SGReadingDataManager.shared.getWillShowPageVC(viewController)
    }
    
    
}

extension SGReaderPageViewController:UIPageViewControllerDelegate{
    
}

extension SGReaderPageViewController{
    func readerCurrViewControllers() -> [UIViewController] {
        if let viewControllers = sgReaderView.viewControllers{
            return viewControllers
        }
        return []
    }
}

extension SGReaderPageViewController:SGReaderToolViewDelegate{
    
    func changeTheme(_ theme:SGReaderTheme) {
        let viewControllers = readerCurrViewControllers()
        if viewControllers.count > 0{
            if let viewController = viewControllers.first{
                if viewController is SGReaderBasePageViewController{
                    (viewController as! SGReaderBasePageViewController).changeTheme()
                }
            }
        }
    }
    
    func reloadReaderContent() {
        SGReadingDataManager.shared.reloadChapter { (completion) in
            var viewControllers:[UIViewController] = []
            let readingManager = SGReadingDataManager.shared
            let positivePageContentView = readingManager.positivePageContentView()
            viewControllers.append(positivePageContentView)
            self.sgReaderView.setViewControllers(viewControllers, direction: .forward, animated: false) { (success) in
                
            }
        }
    }
    
    func resetReader() {
        initPageView()
        initGestureRecognizer()
        reloadReaderContent()
        view.bringSubviewToFront(navigationBarView)
        view.bringSubviewToFront(tabBarView)
    }
    
    func readerToolView(brightChange value: Int) {
        brightView.alpha = CGFloat(1 - (Float(value)/100))
    }
    
    func readerToolView(fontSizeChange value: Int) {
        if value != SGReaderSetDataManager.shared.fontSize{
            SGReaderSetDataManager.shared.fontSize = value
            reloadReaderContent()
        }
    }
    
    func readerToolView(themeChange theme: SGReaderTheme) {
        changeTheme(theme)
    }
    
    func readerToolView(turnStyleChange style: SGPageTurnStyle) {
        resetReader()
    }
}

extension SGReaderPageViewController:SGReaderMenuDelegate{
    func readerMenu(didSelect chapterModel: SGChapterDataModel) {
        SGProtocolManager.shared.delegate?.sgReaderPageViewController(didSelectChapter: chapterModel, completion: { (selectChapterModel) in
            let pagingProcess = SGPagingProcess()
            pagingProcess.setPagingProcessBlock { (status, pagingModel) in
                if pagingModel != nil{
                    SGReadingDataManager.shared.initBookChapterData(pagingModel!, 0)
                    self.dismiss(animated: true, completion: {
                        self.reloadReaderContent()
                    })
                    
                }
            }
            pagingProcess.title = selectChapterModel.title
            pagingProcess.index = selectChapterModel.index
            pagingProcess.content = selectChapterModel.content
            pagingProcess.do()
        })
    }
}
