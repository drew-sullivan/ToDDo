//
//  ToDoItem.swift
//  ToDDo
//
//  Created by Drew Sullivan on 5/16/19.
//  Copyright © 2019 Drew Sullivan. All rights reserved.
//

import Foundation

struct ToDoItem {

    var title: String
    var itemDescription: String?
    var itemTimestamp: Double?
    var location: Location?
    var checked: Bool

    init(title: String, itemDescription: String? = nil, itemTimestamp: Double? = nil, location: Location? = nil, checked: Bool = false) {
        self.title = title
        self.itemDescription = itemDescription
        self.itemTimestamp = itemTimestamp
        self.location = location
        self.checked = checked
    }

}

extension ToDoItem: Equatable { }
