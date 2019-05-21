//
//  DetailViewController.swift
//  ToDDo
//
//  Created by Drew Sullivan on 5/21/19.
//  Copyright © 2019 Drew Sullivan. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

    var titleLabel: UILabel!
    var mapView: MKMapView!
    var dateLabel: UILabel!
    var locationLabel: UILabel!
    var descriptionLabel: UILabel!
    var checkButton: UIButton!
    var itemInfo: (ItemManager, Int)!
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let itemInfo = itemInfo else { return }
        let toDoItem = itemInfo.0.item(at: itemInfo.1)

        titleLabel = UILabel()
        titleLabel.text = toDoItem.title
        view.addSubview(titleLabel)

        if let coordinate = toDoItem.location?.coordinate {
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
            mapView = MKMapView()
            mapView.region = region
            view.addSubview(mapView)
        }

        if let timestamp = toDoItem.itemTimestamp {
            let date = Date(timeIntervalSince1970: timestamp)
            dateLabel = UILabel()
            dateLabel.text = dateFormatter.string(from: date)
            view.addSubview(dateLabel)
        }

        locationLabel = UILabel()
        locationLabel.text = toDoItem.location?.name
        view.addSubview(locationLabel)

        descriptionLabel = UILabel()
        descriptionLabel.text = toDoItem.itemDescription
        view.addSubview(descriptionLabel)

        checkButton = UIButton()
        checkButton.titleLabel?.text = "Check"
        view.addSubview(checkButton)
    }
}
