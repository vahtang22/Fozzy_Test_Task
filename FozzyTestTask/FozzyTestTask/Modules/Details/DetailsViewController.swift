//
//  DetailsViewController.swift
//  FozzyTestTask
//
//  Created by Max Ivanets on 4/23/20.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    let configurator = DetailsConfigurator()
    
    var presenter: DetailsPresenterProtocol!
    
    override func loadView() {
        super.loadView()
        view = DetailsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func view() -> DetailsView? {
        return view as? DetailsView
    }
}


// MARK: - DetailsViewProtocol


extension DetailsViewController: DetailsViewProtocol {
    func configureTableView() {
        view()?.tableView.dataSource = self
        view()?.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
    
    func configureView(for model: Pokemon) {
        if let url = URL.init(string: model.front_default) {
            view()?.imageView.loadImage(with: url)
        }
        title = model.name
    }
}


// MARK: - UITableViewDataSource


extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell") {
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Abilities - " + (configurator.pokemon()?.abilities.map{$0.name}.joined(separator: ", ") ?? "none")
            case 1:
                cell.textLabel?.text = "Height - " + "\(configurator.pokemon()?.height ?? 0)"
            case 2:
                cell.textLabel?.text = "Weight - " + "\(configurator.pokemon()?.weight ?? 0)"
            case 3:
                cell.textLabel?.text = "Base experience - " + "\(configurator.pokemon()?.base_experience ?? 0)"
            case 4:
                cell.textLabel?.text = "Types - " + "\(configurator.pokemon()?.types.map{$0.name}.joined(separator: ", ") ?? "none")"
            default:
                break
            }
            return cell
        }
        return UITableViewCell()
    }
}
