//
//  HomeView.swift
//  FozzyTestTask
//
//  Created by Max Ivanets on 4/22/20.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import UIKit
import SnapKit

protocol HomeViewProtocol: class {
    func configureView()
    func updateCollection()
}

class HomeView: UIView {
    let collection: UICollectionView = {
        let numberOfColumns = UserDefaults.standard.value(forKey: "numberOfColumns") as? Int ?? 4
        let layout = ColumnFlowLayout.init(cellsPerRow: numberOfColumns, minimumInteritemSpacing: 4, minimumLineSpacing: 4)
        let view = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let searchBar: UISearchBar = {
       let view = UISearchBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collection)
        addSubview(searchBar)
        collection.addSubview(refreshControl)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        removeConstraints(constraints)
        searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalTo(self)
        }
        collection.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalTo(self)
        }
        super.updateConstraints()
    }
}
