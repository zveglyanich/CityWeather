//
//  DetailThirdTableViewCell.swift
//  CityWeather
//
//  Created by Pavel Zveglyanich on 2/3/21.
//

import UIKit

class DetailThirdTableViewCell: UITableViewCell {
    
    var stackView: UIStackView = {
        let stackView = addSubViewsToStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        addSubview(stackView)
        stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20.0).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10.0).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0).isActive = true
        
        for indexSubView in 0..<7 {
            let subviewStackView = stackView.arrangedSubviews[indexSubView] as! UIStackView
            let labelDay = subviewStackView.arrangedSubviews[0] as! UILabel
            let iconWeather = subviewStackView.arrangedSubviews[1] as! UIImageView
            let labelTempDay = subviewStackView.arrangedSubviews[2] as! UILabel
            let labelTempNight = subviewStackView.arrangedSubviews[3] as! UILabel
            addConstraintsWithFormat("H:|-10-[v0]-10-[v1(30)]-50-[v2(30)]-20-[v3(30)]-20-|", views: labelDay, iconWeather, labelTempDay, labelTempNight)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func addSubViewsToStackView() -> UIStackView {
        
        var subStackViews = [UIStackView]()
        for _ in 0...6  {
            let labelOne = UILabel().createLabel(textAlignment: .left, numberOfLines: 1, font: UIFont.systemFont(ofSize: 13.0), textColor: .white)
            let labelTwo = UILabel().createLabel(textAlignment: .center, numberOfLines: 1, font: UIFont.systemFont(ofSize: 13.0), textColor: .white)
            let labelThree = UILabel().createLabel(textAlignment: .center, numberOfLines: 1, font: UIFont.systemFont(ofSize: 13.0), textColor: .gray)
            let iconWeatherImage = UIImageView().translatesAutoresizingMask()
            
            let subStackView = UIStackView(arrangedSubviews: [labelOne, iconWeatherImage, labelTwo, labelThree]).createStackView(axis: .horizontal, distribution: .fillEqually, alignment: .fill, spacing: 5)
            
            subStackViews.append(subStackView)
        }
        return UIStackView(arrangedSubviews: subStackViews).createStackView(axis: .vertical, distribution: .fillEqually, alignment: .fill, spacing: 0)
        
    }
}
