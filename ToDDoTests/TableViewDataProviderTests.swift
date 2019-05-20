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
        tableView.delegate = sut
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
        let mockTableView = MockTableView.mockTableView(withDataSource: sut)

        sut.itemManager?.addItem(ToDoItem(title: "Foo"))
        mockTableView.reloadData()

        let _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))

        XCTAssertTrue(mockTableView.cellWasDequeued)
    }

    func test_cellForRow_callConfigCell() {
        let mockTableView = MockTableView.mockTableView(withDataSource: sut)

        let item = ToDoItem(title: "Foo")
        sut.itemManager?.addItem(item)
        mockTableView.reloadData()

        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockItemCell
        XCTAssertEqual(cell.caughtItem, item)
    }

    func test_cellForRow_section2_callsConfigCellWithDoneItem() {
        let mockTableView = MockTableView.mockTableView(withDataSource: sut)

        let item1 = ToDoItem(title: "Foo")
        var item2 = ToDoItem(title: "Bar")
        sut.itemManager?.addItem(item1)
        sut.itemManager?.addItem(item2)
        sut.itemManager?.addCheckToItem(at: 1)
        item2.checked = true
        mockTableView.reloadData()

        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! MockItemCell
        XCTAssertEqual(cell.caughtItem, item2)
    }

    func test_deleteButton_in1stSection_showsTitleCheck() {
        let deleteButtonTitle = tableView.delegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0, section: 0))

        XCTAssertEqual(deleteButtonTitle, "Check")
    }

    func test_deleteButton_in2ndSection_showsTitleUncheck() {
        let deleteButtonTitle = tableView.delegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0, section: 1))

        XCTAssertEqual(deleteButtonTitle, "Uncheck")
    }

    func test_checkingAnItem_checksItInTheItemManager() {
        sut.itemManager?.addItem(ToDoItem(title: "Foo"))
        tableView.dataSource?.tableView?(tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 0))

        XCTAssertEqual(sut.itemManager?.toDoCount, 0)
        XCTAssertEqual(sut.itemManager?.doneCount, 1)
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
    }

    func test_uncheckingAnItem_unchecksItInTheItemManager() {
        sut.itemManager?.addItem(ToDoItem(title: "Foo"))
        sut.itemManager?.addCheckToItem(at: 0)
        tableView.reloadData()
        tableView.dataSource?.tableView?(tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 1))
        
        XCTAssertEqual(sut.itemManager?.toDoCount, 1)
        XCTAssertEqual(sut.itemManager?.doneCount, 0)
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 0)

    }

}

extension TableViewDataProviderTests {

    class MockTableView: UITableView {
        var cellWasDequeued = false

        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellWasDequeued = true

            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }

        class func mockTableView(withDataSource dataSource: UITableViewDataSource) -> MockTableView {
            let mockTableView = MockTableView(frame: CGRect(x: 0, y: 0, width: 320, height: 480), style: .plain)
            mockTableView.dataSource = dataSource
            mockTableView.register(MockItemCell.self, forCellReuseIdentifier: "ItemCell")
            return mockTableView
        }
    }

    class MockItemCell: ItemCell {
        var caughtItem: ToDoItem?

        override func configCell(withItem item: ToDoItem) {
            caughtItem = item
        }
    }

}
