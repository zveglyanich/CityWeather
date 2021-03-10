//
//  WeatherCollectionViewCell.swift
//  CityWeather
//
//  Created by Pavel Zveglyanich on 1/17/21.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    static let cellId = "cellID"
    
    let tempHourlyLabel : UILabel = {
        let label = UILabel().createCustomLabel(textAlignment: .center, numberOfLines: 3, font: UIFont.systemFont(ofSize: 11.0), textColor: .white)
        label.contentMode = .scaleAspectFill
        label.clipsToBounds = true
        return label
    }()
    
    let iconHourlyWeatherImage = UIImageView().createImageViewWithTranslatesAutoresizingMask()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tempHourlyLabel)
        addSubview(iconHourlyWeatherImage)
        addConstraintsWithFormat("V:|-[v0(60)]-[v1(30)]-|", views: tempHourlyLabel,iconHourlyWeatherImage)
        addConstraintsWithFormat("H:|-[v0]-|", views: tempHourlyLabel)
        addConstraintsWithFormat("H:|-[v0]-|", views: iconHourlyWeatherImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
