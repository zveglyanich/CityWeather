//
//  DetailThirdTableViewCell.swift
//  CityWeather
//
//  Created by Pavel Zveglyanich on 2/3/21.
//

import UIKit

class DetailThirdTableViewCell: UITableViewCell {
    
    static let cellId = "DetailThirdTableViewCell" //Remark #36
    static let countOfStringOnStackView = 6 //Remark #37
    
    let views : [UIView] = { //Remark #35
        var views = [UIView]()
        
        for _ in 0...DetailThirdTableViewCell.countOfStringOnStackView {
            let labelDay = UILabel().createCustomLabel(textAlignment: .left, numberOfLines: 1, font: UIFont.systemFont(ofSize: 13.0), textColor: .white)
            let imageviewIconWeather = UIImageView().createImageViewWithTranslatesAutoresizingMask()
            let labelTempDay = UILabel().createCustomLabel(textAlignment: .center, numberOfLines: 1, font: UIFont.systemFont(ofSize: 13.0), textColor: .white)
            let labelTempNight = UILabel().createCustomLabel(textAlignment: .center, numberOfLines: 1, font: UIFont.systemFont(ofSize: 13.0), textColor: .gray)
            let view = UIView()
            
            view.addSubview(labelDay)
            view.addSubview(imageviewIconWeather)
            view.addSubview(labelTempDay)
            view.addSubview(labelTempNight)
            views.append(view)
        }
        return views
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        //Remark #35
        let stackView = UIStackView(arrangedSubviews: views).createCustomStackView(axis: .vertical, distribution: .fillEqually, alignment: .fill, spacing: 0)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20.0).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10.0).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0).isActive = true
        
        for index in 0...DetailThirdTableViewCell.countOfStringOnStackView  { //Remark #35
            let labelDay = stackView.arrangedSubviews[index].subviews[0]
            let imageviewIconWeather = stackView.arrangedSubviews[index].subviews[1]
            let labelTempDay = stackView.arrangedSubviews[index].subviews[2]
            let labelTempNight = stackView.arrangedSubviews[index].subviews[3]
            
            addConstraintsWithFormat("H:|-10-[v0]-10-[v1(30)]-50-[v2(30)]-20-[v3(30)]-20-|", views: labelDay, imageviewIconWeather, labelTempDay, labelTempNight)
            addConstraintsWithFormat("V:|-0-[v0]-0-|", views: labelDay)
            addConstraintsWithFormat("V:|-0-[v0]-0-|", views: imageviewIconWeather)
            addConstraintsWithFormat("V:|-0-[v0]-0-|", views: labelTempDay)
            addConstraintsWithFormat("V:|-0-[v0]-0-|", views: labelTempNight)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
