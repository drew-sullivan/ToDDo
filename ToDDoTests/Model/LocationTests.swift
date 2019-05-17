//
//  LocationTests.swift
//  ToDDoTests
//
//  Created by Drew Sullivan on 5/16/19.
//  Copyright © 2019 Drew Sullivan. All rights reserved.
//

import XCTest
import CoreLocation

@testable import ToDDo

class LocationTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_whenGivenName_setsName() {
        let name = "Foo"
        let item = Location(name: name)
        XCTAssert(item.name == name)
    }

    func test_init_setsCoordinate() {
        let coordinate = CLLocationCoordinate2D(latitude: 1, longitude: 2)
        let location = Location(name: "", coordinate: coordinate)
        XCTAssertEqual(location.coordinate, coordinate)
    }

    func test_locationsCanBeCompared() {
        let location1 = Location(name: "Foo", coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: 0.0)!, longitude: CLLocationDegrees(exactly: 0.0)!))
        let location2 = Location(name: "Bar", coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: 1.0)!, longitude: CLLocationDegrees(exactly: 1.0)!))
        let location3 = location2
        XCTAssertNotEqual(location1, location2)
        XCTAssertEqual(location2, location3)
    }

}
