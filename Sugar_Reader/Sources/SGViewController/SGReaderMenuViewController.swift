//
//  SGReaderMenuViewController.swift
//  Sugar_Reader_VC
//
//  Created by YY on 2019/7/5.
//  Copyright © 2019 Sugar. All rights reserved.
//

import UIKit

protocol SGReaderMenuDelegate {
    func readerMenu(didSelect chapterModel:SGChapterDataModel)
}

class SGReaderMenuViewController: SGBaseViewController {
    var delegate:SGReaderMenuDelegate?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    override func initSubviews() {
        view.addSubview(tableView)
        tableView.reloadData()
        title = "目录"
    }
    
    override func initSubviewsLayout() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - lazy
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight=55
        tableView.separatorStyle = .none;
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
}

extension SGReaderMenuViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SGMenuDataManager.shared.menuCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "chapterListCellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: cellID)
            cell?.selectionStyle = .gray
        }
        cell?.textLabel?.text = SGMenuDataManager.shared.menuTitleFor(indexPath.row)
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
        return cell!
    }
    
    
}


extension SGReaderMenuViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if delegate != nil{
            if let chapterModel = SGMenuDataManager.shared.menuDataFor(indexPath.row){
                delegate?.readerMenu(didSelect: chapterModel)
            }
            
        }
    }
}
