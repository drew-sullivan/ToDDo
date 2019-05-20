//
//  ItemListViewController.swift
//  ToDDo
//
//  Created by Drew Sullivan on 5/17/19.
//  Copyright © 2019 Drew Sullivan. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {

    var tableView: UITableView!
    var dataProvider: (UITableViewDataSource & UITableViewDelegate)!

    override func viewDidLoad() {
        super.viewDidLoad()

        dataProvider = TableViewDataProvider()

        let rowHeight = UIApplication.shared.statusBarFrame.size.height
        let tableViewWidth = self.view.frame.width
        let tableViewHeight = self.view.frame.height

        tableView = UITableView(frame: CGRect(x: 0, y: rowHeight, width: tableViewWidth, height: tableViewHeight))
        tableView?.register(ItemCell.self, forCellReuseIdentifier: "ItemCell")
        tableView?.delegate = dataProvider
        tableView?.dataSource = dataProvider
        view.addSubview(tableView!)
    }

}
