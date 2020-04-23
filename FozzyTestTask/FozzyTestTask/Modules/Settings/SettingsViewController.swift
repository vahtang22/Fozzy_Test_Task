//
//  SettingsViewController.swift
//  FozzyTestTask
//
//  Created by Max Ivanets on 4/23/20.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    let configurator = SettingsConfigurator()
    
    var presenter: SettingsPresenterProtocol!
    
    override func loadView() {
        super.loadView()
        view = SettingsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.configureView()
    }
    
    func view() -> SettingsView? {
        return view as? SettingsView
    }
}

extension SettingsViewController: SettingsViewProtocol {
    func updateTable() {
        view()?.tableView.reloadData()
    }
    
    func configureView() {
        view()?.tableView.delegate = self
        view()?.tableView.dataSource = self
        view()?.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = presenter.options()[indexPath.row]
        presenter.apply(option: item)
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.options().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = presenter.options()[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell") {
            cell.textLabel?.text = "\(item.rawValue)"
            if presenter.selected() == item {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            return cell
        }
        return UITableViewCell()
    }
}
