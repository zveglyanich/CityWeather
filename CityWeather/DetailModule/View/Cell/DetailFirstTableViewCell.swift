//
//  DetailFirstTableViewCell.swift
//  CityWeather
//
//  Created by Pavel Zveglyanich on 2/3/21.
//

import UIKit

class DetailFirstTableViewCell: UITableViewCell {
    
    static let cellId = "DetailFirstTableViewCell" //Remark #36
    
    let cityAndFeelsLikeLabel = UILabel().createCustomLabel(textAlignment: .center, numberOfLines: 3, font: UIFont.systemFont(ofSize: 18.0), textColor: .white)
    
    let iconWeatherImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let descriptionLabel = UILabel().createCustomLabel(textAlignment: .center, numberOfLines: 1, font: UIFont.systemFont(ofSize: 18.0), textColor: .white)

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupViews()
    }
    func setupViews() {
        [cityAndFeelsLikeLabel, iconWeatherImage, descriptionLabel].forEach { addSubview($0) }
        addConstraintsWithFormat("H:|-20-[v0]-20-|", views: cityAndFeelsLikeLabel)
        addConstraintsWithFormat("H:|-20-[v0]-20-|", views: descriptionLabel)
        addConstraintsWithFormat("H:[v0(110)]", views: iconWeatherImage)
        iconWeatherImage.centerXAnchor.constraint(equalToSystemSpacingAfter: superview!.centerXAnchor, multiplier: 0).isActive = true
        addConstraintsWithFormat("V:|-10-[v0(60)]-5-[v1(110)]-5-[v2(20)]-10-|", views: cityAndFeelsLikeLabel, iconWeatherImage, descriptionLabel)
    }
}
