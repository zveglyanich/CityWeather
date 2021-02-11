//
//  DetailDefaultTableViewCell.swift
//  CityWeather
//
//  Created by Pavel Zveglyanich on 2/3/21.
//

import UIKit

class DetailDefaultTableViewCell: UITableViewCell {

    let nameLabel = UILabel().createLabel(textAlignment: .left, numberOfLines: 1, font: UIFont.systemFont(ofSize: 13.0), textColor: .white)

    let valueLabel = UILabel().createLabel(textAlignment: .left, numberOfLines: 1, font: UIFont.systemFont(ofSize: 18.0), textColor: .white)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        [nameLabel, valueLabel].forEach { addSubview($0) }
        addConstraintsWithFormat("H:|-20-[v0]-20-|", views: nameLabel)
        addConstraintsWithFormat("H:|-20-[v0]-20-|", views: valueLabel)
        addConstraintsWithFormat("V:|-10-[v0(25)]-5-[v1(40)]-10-|", views: nameLabel, valueLabel)
        
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
