//
//  MenuTableView.swift
//  Four11
//
//  Created by Omar Padierna on 2019-03-25.
//  Copyright © 2019 Omar Padierna. All rights reserved.
//


import UIKit

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CUSTOM_CELLS.MENU_CELL, for: indexPath)
        cell.textLabel?.text = settings[indexPath.row]
        return cell
    }
    
}
