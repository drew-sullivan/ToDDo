//
//  ToDoItemTests.swift
//  ToDDoTests
//
//  Created by Drew Sullivan on 5/16/19.
//  Copyright © 2019 Drew Sullivan. All rights reserved.
//

import XCTest

@testable import ToDDo

class ToDoItemTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_init_whenGivenTitle_setsTitle() {
        let title = "Foo"
        let item = ToDoItem(title: title)
        XCTAssert(item.title == title)
    }

    func test_init_whenGivenDescription_setsDescription() {
        let desc = "Bar"
        let item = ToDoItem(title: "", itemDescription: desc)
        XCTAssert(item.itemDescription == desc)
    }

    func test_init_whenGivenTimestamp_setsTimestamp() {
        let timestamp = 3.14
        let item = ToDoItem(title: "", itemDescription: nil, itemTimestamp: timestamp)
        XCTAssert(item.itemTimestamp == timestamp)
    }

    func test_init_whenGivenLocation_setsLocation() {
        let location = Location(name: "Foo")
        let item = ToDoItem(title: "", location: location)
        XCTAssert(item.location == location)
    }

    func test_init_setsChecked() {
        let item = ToDoItem(title: "")
        XCTAssertEqual(item.checked, false)
    }

    func test_equalItemsAreEqual() {
        let item1 = ToDoItem(title: "")
        let item2 = item1
        XCTAssertEqual(item1, item2)
    }

}
