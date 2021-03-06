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

    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {

        guard let itemSection = Section(rawValue: indexPath.section) else { fatalError() }
        switch itemSection {
        case .toDo:
            return "Check"
        case .done:
            return "Uncheck"
        }
    }

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell

        guard let itemManager = itemManager, let section = Section(rawValue: indexPath.section) else { fatalError() }

        let item: ToDoItem
        switch section {
        case .toDo:
            item = itemManager.item(at: indexPath.row)
        case .done:
            item = itemManager.doneItem(at: indexPath.row)
        }

        cell.configCell(withItem: item)
        
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let itemManager = itemManager, let section = Section(rawValue: indexPath.section) else { fatalError() }

        switch section {
        case .toDo:
            itemManager.addCheckToItem(at: indexPath.row)
        case .done:
            itemManager.removeCheckFromItem(at: indexPath.row)
        }

        tableView.reloadData()
    }

}

extension TableViewDataProvider {

    enum Section: Int {
        case toDo
        case done
    }

}
