//
//  ItemManagerTests.swift
//  ToDDoTests
//
//  Created by Drew Sullivan on 5/16/19.
//  Copyright © 2019 Drew Sullivan. All rights reserved.
//

import XCTest
@testable import ToDDo

class ItemManagerTests: XCTestCase {

    var sut: ItemManager!

    override func setUp() {
        sut = ItemManager()
    }

    override func tearDown() {
        sut = nil
    }

    func test_toDoCount_isInitiallyZero() {
        XCTAssertEqual(sut.toDoCount, 0)
    }

    func test_doneCount_isInitiallyZero() {
        XCTAssertEqual(sut.doneCount, 0)
    }

    func test_addItem_incrementsToDoCountByOne() {
        sut.addItem(ToDoItem(title: "Foo"))
        XCTAssertEqual(sut.toDoCount, 1)
    }

    func test_itemAt_returnsItemAtGivenIndex() {
        let item = ToDoItem(title: "Foo")
        sut.addItem(item)
        let retrievedItem = sut.item(at: 0)
        XCTAssertEqual(retrievedItem, item)
    }

    func test_addCheckToItemAt_RemovedItemFromToDoItems() {
        let item = ToDoItem(title: "")
        sut.addItem(item)
        XCTAssertEqual(sut.toDoCount, 1)
        XCTAssertEqual(sut.doneCount, 0)

        sut.addCheckToItem(at: 0)
        XCTAssertEqual(sut.toDoCount, 0)
        XCTAssertEqual(sut.doneCount, 1)
    }

    func test_doneItemAt_returnItemAtGivenIndex() {
        var item = ToDoItem(title: "")
        sut.addItem(item)
        sut.addCheckToItem(at: 0)
        let returnedItem = sut.doneItem(at: 0)
        item.checked = true
        XCTAssertEqual(returnedItem, item)
    }

    func test_removeAllItems_removesAllItems() {
        sut.addItem(ToDoItem(title: "Foo"))
        sut.addItem(ToDoItem(title: "Bar"))
        XCTAssertEqual(sut.toDoCount, 2)
        sut.removeAllItems()
        XCTAssertEqual(sut.toDoCount, 0)
    }

    func test_addItem_doesNotAddItem_whenItemIsAlreadyInToDos() {
        let item = ToDoItem(title: "Foo")
        sut.addItem(item)
        let returnedItem = sut.item(at: 0)
        XCTAssertEqual(sut.toDoCount, 1)

        sut.addItem(item)
        XCTAssertEqual(sut.toDoCount, 1)
    }

}
