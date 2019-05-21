//
//  DetailViewControllerTests.swift
//  ToDDoTests
//
//  Created by Drew Sullivan on 5/21/19.
//  Copyright © 2019 Drew Sullivan. All rights reserved.
//

import XCTest
@testable import ToDDo
import CoreLocation

class DetailViewControllerTests: XCTestCase {

    var sut: DetailViewController!
    var item: ToDoItem!

    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        sut.loadViewIfNeeded()

        let coordinate = CLLocationCoordinate2D(latitude: 51.2277, longitude: 6.7735)
        let location = Location(name: "Foo", coordinate: coordinate)
        item = ToDoItem(title: "Bar", itemDescription: "Baz", itemTimestamp: 1456150025, location: location)
        let itemManager = ItemManager()
        itemManager.addItem(item)
        sut.itemInfo = (itemManager, 0)

        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_hasTitleLabel() {
        XCTAssertTrue(sut.titleLabel.isDescendant(of: sut.view) )
    }

    func test_hasMapView() {
        XCTAssertTrue(sut.mapView.isDescendant(of: sut.view))
    }

    func test_hasDateLabel() {
        XCTAssertTrue(sut.dateLabel.isDescendant(of: sut.view))
    }

    func test_hasLocationLabel() {
        XCTAssertTrue(sut.locationLabel.isDescendant(of: sut.view))
    }

    func test_hasDescriptionLabel() {
        XCTAssertTrue(sut.descriptionLabel.isDescendant(of: sut.view))
    }

    func test_hasCheckButton() {
        XCTAssertTrue(sut.checkButton.isDescendant(of: sut.view))
    }

    func test_settingItemInfo_setsTitleLabel() {
        XCTAssertEqual(sut.titleLabel.text, "Bar")
    }

    func test_settingItemInfo_setsMapView() {
        XCTAssertEqual(sut.mapView.centerCoordinate.latitude, item.location?.coordinate?.latitude ?? 3.14, accuracy: 0.001)
        XCTAssertEqual(sut.mapView.centerCoordinate.longitude, item.location?.coordinate?.longitude ?? 3.14, accuracy: 0.001)
    }

    func test_settingItemInfo_setsDateLabel() {
        XCTAssertEqual(sut.dateLabel.text, "02/22/2016")
    }

    func test_settingItemInfo_setsLocationLabel() {
        XCTAssertEqual(sut.locationLabel.text, "Foo")
    }

    func test_settingItemInfo_setsDescriptionLabel() {
        XCTAssertEqual(sut.descriptionLabel.text, "Baz")
    }

}
