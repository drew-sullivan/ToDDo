//
//  ItemListViewControllerTests.swift
//  ToDDoTests
//
//  Created by Drew Sullivan on 5/17/19.
//  Copyright © 2019 Drew Sullivan. All rights reserved.
//

import XCTest
@testable import ToDDo

class ItemListViewControllerTests: XCTestCase {

    var sut: ItemListViewController!

    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as! ItemListViewController
        sut = vc
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        sut = nil
    }

    func test_tableView_exists_afterViewDidLoad() {
        XCTAssertNotNil(sut.tableView)
    }

    func test_tableViewRegistersCell() {
        sut.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "test")
        let cell = sut.tableView.dequeueReusableCell(withIdentifier: "test")
        XCTAssertNotNil(cell)
    }

    func test_loadingView_setsTableViewDelegate() {
        XCTAssertTrue(sut.tableView.delegate is TableViewDataProvider)
    }

    func test_loadingView_setsTableViewDataSource() {
        XCTAssertTrue(sut.tableView.dataSource is TableViewDataProvider)
    }

    func test_datasourceAndDelegate_areSameInstance() {
        XCTAssertEqual(sut.tableView.dataSource as? TableViewDataProvider, sut.tableView?.delegate as? TableViewDataProvider)
    }

}
