//
//  ItemCelTests.swift
//  ToDDoTests
//
//  Created by Drew Sullivan on 5/20/19.
//  Copyright © 2019 Drew Sullivan. All rights reserved.
//

import XCTest
import CoreLocation
@testable import ToDDo

class ItemCellTests: XCTestCase {

    var tableView: UITableView!
    let dataSource = FakeDataSource()
    var cell: ItemCell!

    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as! ItemListViewController

        controller.loadViewIfNeeded()

        tableView = controller.tableView
        tableView?.dataSource = dataSource

        cell = tableView?.dequeueReusableCell(withIdentifier: "ItemCell", for: IndexPath(row: 0, section: 0)) as? ItemCell
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_hasNameLabel() {
        XCTAssertTrue(cell.titleLabel.isDescendant(of: cell.contentView))
    }

    func test_hasLocationLabel() {
        XCTAssertTrue(cell.locationLabel.isDescendant(of: cell.contentView))
    }

    func test_configCell_setsTitle() {
        cell.configCell(withItem: ToDoItem(title: "Foo"))
        XCTAssertEqual(cell.titleLabel.text, "Foo")
    }

    func test_configCell_setsDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let date = dateFormatter.date(from: "05/20/2019")
        let timestamp = date?.timeIntervalSince1970
        cell.configCell(withItem: ToDoItem(title: "Foo", itemTimestamp: timestamp))
        XCTAssertEqual(cell.dateLabel.text, "05/20/2019")
    }

    func test_configCell_setsLocationLabel() {
        let coordinate = CLLocationCoordinate2D(latitude: 1.0, longitude: 1.0)
        let location = Location(name: "Bar", coordinate: coordinate)
        let item = ToDoItem(title: "Foo", location: location)
        cell.configCell(withItem: item)
        XCTAssertNotNil(item.location?.coordinate?.latitude)
        XCTAssertNotNil(item.location?.coordinate?.longitude)
        XCTAssertEqual(cell.locationLabel.text, "Latitude: \(String(describing: item.location?.coordinate?.latitude)), Longitude: \(String(describing: item.location?.coordinate?.longitude))")
    }

    func test_whenItemIsChecked_itIsStruckThrough() {
        let location = Location(name: "Bar")
        let item = ToDoItem(title: "Foo", itemDescription: nil, itemTimestamp: 1456150025, location: location)
        cell.configCell(withItem: item, checked: true)

        let attributedString = NSAttributedString(string: "Foo", attributes: [NSAttributedString.Key.strikethroughStyle:NSUnderlineStyle.single.rawValue])

        XCTAssertEqual(cell.titleLabel.attributedText, attributedString)
        XCTAssertNil(cell.locationLabel.text)
        XCTAssertNil(cell.dateLabel.text)
    }

}

extension ItemCellTests {

    class FakeDataSource: NSObject, UITableViewDataSource {

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }

    }
}
