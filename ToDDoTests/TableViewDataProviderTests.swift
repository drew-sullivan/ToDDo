//
//  TableViewDataProviderTests.swift
//  ToDDoTests
//
//  Created by Drew Sullivan on 5/17/19.
//  Copyright © 2019 Drew Sullivan. All rights reserved.
//

import XCTest
@testable import ToDDo

class TableViewDataProviderTests: XCTestCase {

    var sut: TableViewDataProvider!
    var tableView: UITableView!
    var itemListViewController: ItemListViewController!

    override func setUp() {
        super.setUp()

        sut = TableViewDataProvider()
        sut.itemManager = ItemManager()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        itemListViewController = storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as? ItemListViewController
        itemListViewController.loadViewIfNeeded()

        tableView = itemListViewController.tableView
        tableView.dataSource = sut
    }

    override func tearDown() {
        sut = nil

        super.tearDown()
    }

    func test_numSections_isTwo() {
        let numSections = tableView.numberOfSections
        XCTAssertEqual(numSections, 2)
    }

    func test_numRows_inSection1_isToDoCount() {
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 0)
        sut.itemManager?.addItem(ToDoItem(title: "Foo"))
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
    }

    func test_numRows_inSection2_isDoneCount() {
        sut.itemManager?.addItem(ToDoItem(title: "Foo"))
        sut.itemManager?.addItem(ToDoItem(title: "Bar"))
        sut.itemManager?.addCheckToItem(at: 0)
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)

        sut.itemManager?.addCheckToItem(at: 0)
        tableView.reloadData()

        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 2)
    }

    func test_cellForRow_ReturnCustomItemCell() {
        sut.itemManager?.addItem(ToDoItem(title: "Foo"))
        tableView.reloadData()

        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is ItemCell)
    }

    func test_cellForRow_dequesesCellFromTableView() {
        let mockTableView = MockTableView()
        mockTableView.dataSource = sut
        mockTableView.register(ItemCell.self, forCellReuseIdentifier: "ItemCell")
        sut.itemManager?.addItem(ToDoItem(title: "Foo"))
        mockTableView.reloadData()

        let _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))

        XCTAssertTrue(mockTableView.cellWasDequeued)
    }

}

extension TableViewDataProviderTests {

    class MockTableView: UITableView {
        var cellWasDequeued = false

        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellWasDequeued = true
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
    }

}
