//
//  SGPositiveViewController.swift
//  Sugar_Reader
//
//  Created by YY on 2019/7/5.
//  Copyright © 2019 Sugar. All rights reserved.
//

import UIKit
import TYAttributedLabel

class SGPositiveViewController: SGReaderBasePageViewController {
    
    override var pageDataModel: SGPageConDataModel?{
        didSet{
            if let dataModel = pageDataModel{
                if let attriString = dataModel.attrString{
                    attriLabel.setAttributedText(attriString)
                }
                bottomTipView.pageMarker = String(dataModel.pageIndex + 1) + "/" + String(dataModel.pageCount)
                labelChapterTitle.text = dataModel.title
                if dataModel.turnPage{
                    SGReadingDataManager.shared.turnChapter(dataModel.chapterIndex)
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if pageDataModel != nil{
            SGReadingDataManager.shared.currentPageIndex = pageDataModel?.pageIndex ?? 0
        }
    }
    
    
    override func initSubviews() {
        view.addSubview(attriLabel)
        
        view.addSubview(bottomTipView)
        view.addSubview(labelChapterTitle)
    }
    
    override func initSubviewsLayout() {
        let setManager = SGReaderSetDataManager.shared
        attriLabel.snp.makeConstraints { (make) in
            make.left.equalTo(setManager.marginSide)
            make.right.equalTo(-setManager.marginSide)
            make.top.equalTo(setManager.marginTop)
            make.bottom.equalTo(-setManager.marginBottom)
        }
        bottomTipView.snp.makeConstraints { (make) in
            make.left.equalTo(attriLabel)
            make.right.equalTo(attriLabel)
            make.height.equalTo(20)
            make.top.equalTo(attriLabel.snp.bottom).offset(5)
        }
        labelChapterTitle.snp.makeConstraints { (make) in
            make.left.equalTo(attriLabel)
            make.right.equalTo(attriLabel)
            make.height.equalTo(20)
            make.bottom.equalTo(attriLabel.snp.top).offset(-5)
        }
    }
    
    
    
    // MARK: - lazy
    
    lazy var attriLabel: TYAttributedLabel = {
        let label = TYAttributedLabel()
        label.backgroundColor = .clear
        return label
    }()
    
    lazy var bottomTipView: SGReaderBottomInfoView = {
        let view  = SGReaderBottomInfoView()
        return view
    }()
    
    lazy var labelChapterTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
}

