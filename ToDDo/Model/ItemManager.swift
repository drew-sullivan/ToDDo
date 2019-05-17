//
//  ItemManager.swift
//  ToDDo
//
//  Created by Drew Sullivan on 5/16/19.
//  Copyright © 2019 Drew Sullivan. All rights reserved.
//

import Foundation

class ItemManager {

    private var toDoItems = [ToDoItem]()
    private var doneItems = [ToDoItem]()
    var toDoCount: Int { return toDoItems.count }
    var doneCount: Int { return doneItems.count }

    func addItem(_ toDoItem: ToDoItem) {
        for item in toDoItems {
            if toDoItem == item {
                return
            }
        }
        toDoItems.append(toDoItem)
    }

    func item(at index: Int) -> ToDoItem {
        return toDoItems[index]
    }

    func addCheckToItem(at index: Int) {
        var todo = item(at: index)
        todo.checked = true
        toDoItems.remove(at: index)
        doneItems.append(todo)
    }

    func doneItem(at index: Int) -> ToDoItem {
        return doneItems[index]
    }

    func removeAllItems() {
        toDoItems = []
    }

}
