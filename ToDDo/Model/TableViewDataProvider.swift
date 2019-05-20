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
        guard let itemManager = itemManager else { return 0 }

        guard let itemSection = Section(rawValue: section) else { fatalError() }

        let numRows: Int
        switch itemSection {
        case .toDo:
            numRows = itemManager.toDoCount
        case .done:
            numRows = itemManager.doneCount
        }
        return numRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        return cell
    }

}

extension TableViewDataProvider {

    enum Section: Int {
        case toDo
        case done
    }

}
