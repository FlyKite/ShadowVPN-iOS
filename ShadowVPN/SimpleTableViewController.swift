//
//  SimpleTableViewController.swift
//  ShadowVPN
//
//  Created by FlyKite on 2018/5/23.
//  Copyright © 2018年 clowwindy. All rights reserved.
//

import UIKit

class SimpleTableViewController: UITableViewController {
    
    private var labels: [String]
    private var values: [String]
    private var selectedValue: String?
    private var selectionHandler: (String) -> Void
    
    
    init(labels: [String], values: [String], initialValue: String?, selectionHandler: @escaping (String) -> Void) {
        self.labels = labels
        self.values = values
        self.selectedValue = initialValue
        self.selectionHandler = selectionHandler
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.labels[indexPath.row]
        if self.values[indexPath.row] == self.selectedValue {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.labels.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let value = self.values[indexPath.row]
        self.selectedValue = value
        let rowCount = tableView.numberOfRows(inSection: 0)
        for index in 0 ..< rowCount {
            if index != indexPath.row {
                tableView.cellForRow(at: IndexPath(row: index, section: 0))?.accessoryType = .none
            }
        }
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectionHandler(value)
    }
    
}
