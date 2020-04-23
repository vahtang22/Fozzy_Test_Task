//
//  HomeViewController.swift
//  FozzyTestTask
//
//  Created by Max Ivanets on 4/22/20.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    let configurator = HomeConfigurator()
    
    var presenter: HomePresenterProtocol!
    
    override func loadView() {
        super.loadView()
        view = HomeView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.configureView()
    }
    
    func view() -> HomeView? {
        return view as? HomeView
    }
    
    @objc func refresh() {
        presenter.loadPokemons()
    }
    
    @objc func updateColumns(notification: NSNotification) {
        if let numberOfColumns = notification.userInfo?["number"] as? Int {
            let layout = ColumnFlowLayout.init(cellsPerRow: numberOfColumns, minimumInteritemSpacing: 4, minimumLineSpacing: 4)
            view()?.collection.setCollectionViewLayout(layout, animated: true)
            view()?.collection.reloadData()
        }
    }
}


// MARK: - HomeViewProtocol


extension HomeViewController: HomeViewProtocol {
    func updateCollection() {
        view()?.refreshControl.endRefreshing()
        view()?.collection.reloadData()
    }
    
    func configureView() {
        view()?.collection.delegate = self
        view()?.collection.dataSource = self
        view()?.collection.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "HomeCollectionViewCell")
        view()?.searchBar.delegate = self
        view()?.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        if let type = configurator.pokemonType() {
            presenter.loadPokemons(of: type)
        } else {
            presenter.loadPokemons()
        }
        
        title = configurator.pokemonType()?.rawValue ?? "all"
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateColumns(notification:)), name: SettingsService.numberOfColumnsChanged, object: nil)
    }
}


// MARK: - UICollectionViewDelegate


extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if configurator.pokemonType() == nil {
            if presenter.pokemons().count > 10 {
                let last = presenter.pokemons().count - 1
                if indexPath.row == last {
                    presenter.loadMorePokemons()
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = presenter.pokemons()[indexPath.row]
        presenter.navigateToDetails(of: item)
    }
}


// MARK: - UICollectionViewDataSource


extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if presenter.pokemons().isEmpty {
            collectionView.setEmptyMessage("oops, no pokemon found")
        } else {
            collectionView.restore()
        }
        return presenter.pokemons().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as? HomeCollectionViewCell {
            if let url = URL.init(string: presenter.pokemons()[indexPath.row].front_default) {
                cell.imageView.loadImage(with: url)
            }
            return cell
        }
        return UICollectionViewCell()
    }
}


// MARK: - UISearchBarDelegate


extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            if let type = configurator.pokemonType() {
                presenter.loadPokemons(of: type)
            } else {
                presenter.loadPokemons()
            }
        } else {
            presenter.searchPokemon(with: searchText)
        }
    }
}

