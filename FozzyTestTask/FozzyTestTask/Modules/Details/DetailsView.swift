//
//  DetailsView.swift
//  FozzyTestTask
//
//  Created by Max Ivanets on 4/23/20.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import UIKit

protocol DetailsViewProtocol: class {
    func configureView(for model: Pokemon)
    func configureTableView()
}

class DetailsView: UIView {
    let imageView: CachebaleImageView = {
        let view = CachebaleImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(imageView)
        addSubview(tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        removeConstraints(constraints)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalTo(self)
            make.height.equalTo(200)
        }
        tableView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(self)
            make.top.equalTo(imageView.snp.bottom)
            make.bottom.equalTo(self)
        }
        super.updateConstraints()
    }
}
