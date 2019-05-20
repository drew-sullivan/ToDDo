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

    override func setUp() {
        super.setUp()

        sut = TableViewDataProvider()
        sut.itemManager = ItemManager()

        tableView = UITableView()
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
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 0)
        sut.itemManager?.addItem(ToDoItem(title: "Foo"))
        tableView.reloadData()
        sut.itemManager?.addCheckToItem(at: 0)
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
    }

}
