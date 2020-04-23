//
//  SettingsView.swift
//  FozzyTestTask
//
//  Created by Max Ivanets on 4/23/20.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import UIKit

protocol SettingsViewProtocol: class {
    func configureView()
    func updateTable()
}

class SettingsView: UIView {
    let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let title: UILabel = {
        let view = UILabel()
        view.text = "Set number of columns"
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(title)
        addSubview(tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        removeConstraints(constraints)
        title.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(self)
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalTo(self)
        }
        super.updateConstraints()
    }
}
