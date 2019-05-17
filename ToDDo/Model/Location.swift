//
//  Location.swift
//  ToDDo
//
//  Created by Drew Sullivan on 5/16/19.
//  Copyright © 2019 Drew Sullivan. All rights reserved.
//

import Foundation
import CoreLocation

struct Location {

    let name: String
    let coordinate: CLLocationCoordinate2D?

    init(name: String, coordinate: CLLocationCoordinate2D? = nil) {
        self.name = name
        self.coordinate = coordinate
    }
    
}

extension Location: Equatable { }

extension CLLocationCoordinate2D: Equatable {

    public static func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
    
}
