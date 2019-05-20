//
//  TableViewDataProvider.swift
//  ToDDo
//
//  Created by Drew Sullivan on 5/17/19.
//  Copyright © 2019 Drew Sullivan. All rights reserved.
//

import UIKit

class TableViewDataProvider: NSObject {

    var itemManager: ItemManager?

}

extension TableViewDataProvider: UITableViewDelegate {

}

extension TableViewDataProvider: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemManager?.toDoCount ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}
