//
//  ItemCell.swift
//  ToDDo
//
//  Created by Drew Sullivan on 5/20/19.
//  Copyright © 2019 Drew Sullivan. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    let titleLabel = UILabel()
    let locationLabel = UILabel()
    let dateLabel = UILabel()
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(titleLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(dateLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configCell(withItem item: ToDoItem, checked: Bool = false) {
        if checked {
            let attributedString = NSAttributedString(string: item.title, attributes: [NSAttributedString.Key.strikethroughStyle:NSUnderlineStyle.single.rawValue])
            titleLabel.attributedText = attributedString
            locationLabel.text = nil
            dateLabel.text = nil
        } else {
            titleLabel.text = item.title

            if let location = item.location {
                locationLabel.text = "Latitude: \(String(describing: location.coordinate?.latitude)), Longitude: \(String(describing: location.coordinate?.longitude))"
            }

            if let timestamp = item.itemTimestamp {
                let date = Date(timeIntervalSince1970: timestamp)
                dateLabel.text = dateFormatter.string(from: date)
            }
        }
    }
}
