//
//  SGReaderBottomInfoView.swift
//  Sugar_Reader_VC
//
//  Created by YY on 2019/7/5.
//  Copyright © 2019 Sugar. All rights reserved.
//

import UIKit

class SGReaderBottomInfoView: SGBaseView {
    var pageMarker:String = ""{
        didSet{
            labelPageMarker.text = pageMarker
        }
    }
    
    override func initSubviews() {
        addSubview(batterView)
        addSubview(labelTime)
        addSubview(labelPageMarker)
        changeTintColor()
    }
    
    
    func changeTintColor() {
        let setManager = SGReaderSetDataManager.shared
        labelTime.textColor = setManager.textColor
        labelPageMarker.textColor = setManager.textColor
        batterView.textColor = setManager.textColor
    }
    
    override func initSubviewsLayout() {
        batterView.snp.makeConstraints { (make) in
            make.height.equalTo(9)
            make.width.equalTo(16)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }
        labelTime.snp.makeConstraints { (make) in
            make.left.equalTo(batterView.snp.right).offset(5)
            make.centerY.equalToSuperview()
        }
        labelPageMarker.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    //MARK : - lazy
    lazy var batterView: SGBatterView = {
        let lazyView = SGBatterView()
        return lazyView
    }()
    
    lazy var labelTime:UILabel = {
        let lazyLabel = UILabel()
        lazyLabel.font = UIFont.systemFont(ofSize: 12)
        lazyLabel.textColor = .black
        lazyLabel.text = Date.readerTime
        return lazyLabel
    }()
    
    lazy var labelPageMarker: UILabel = {
        let lazyLabel = UILabel()
        lazyLabel.textColor = .black
        lazyLabel.font = UIFont.systemFont(ofSize: 12)
        return lazyLabel
    }()
}

class SGBatterView: SGBaseView {
    var textColor:UIColor = .black{
        didSet{
            bodyView.layer.borderColor = textColor.cgColor
            headView.backgroundColor = textColor
            progressView.backgroundColor = textColor
        }
    }
    
    override func initSubviews() {
        addSubview(bodyView)
        addSubview(headView)
        addSubview(progressView)
    }
    
    override func initSubviewsLayout() {
        bodyView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview().offset(-1)
            make.height.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        headView.snp.makeConstraints { (make) in
            make.width.equalTo(1)
            make.height.equalTo(3)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
        progressView.snp.makeConstraints { (make) in
            make.left.equalTo(bodyView).offset(2)
            make.top.equalTo(bodyView).offset(2)
            make.bottom.equalTo(bodyView).offset(-2)
            make.right.equalTo(bodyView).offset(-2)
        }
    }
    
    //MARK : - lazy
    lazy var bodyView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 2
        //view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    lazy var headView: UIView = {
        let view = UIView()
        //view.backgroundColor = .black
        return view
    }()
    
    lazy var progressView: UIView = {
        let view = UIView()
        //view.backgroundColor = .black
        return view
    }()
}

extension Date{
    public static var readerTime:String{
        let now = Date()
        let dformatter = DateFormatter()
        dformatter.dateFormat = "HH:mm"
        return dformatter.string(from: now)
}
}


