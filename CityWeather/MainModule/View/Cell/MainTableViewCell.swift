//
//  WeatherTableViewCell.swift
//  Weather
//
//  Created by Pavel Zveglyanich on 12/28/20.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    static let cellId = "cellID"
    
    let cityLabel = UILabel().createCustomLabel(textAlignment: NSTextAlignment.left, numberOfLines: 1, font: UIFont.systemFont(ofSize: 18.0), textColor: .white)
    
    let cityTextField = UITextField().createTextFieldWithTranslatesAutoresizingMask()
    
    let iconWeatherImage = UIImageView().createImageViewWithTranslatesAutoresizingMask()
    
    let tempLabel = UILabel().createCustomLabel(textAlignment: NSTextAlignment.left, numberOfLines: 1, font: UIFont.systemFont(ofSize: 18.0), textColor: .white)
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.backgroundColor = .none
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        collectionview.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeatherCollectionViewCell.cellId)
        return collectionview
    }()
    
    let weatherDescriptionButton = UIButton().createCustomButton(title: "More details >", for: .normal, color: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            setupViewsForHighCell()
        } else {
            setupViews()
        }
    }
    func setupViews() {
        [cityLabel, iconWeatherImage, tempLabel, collectionView, weatherDescriptionButton].forEach { addSubview($0) }
        iconWeatherImage.isHidden = false
        tempLabel.isHidden = false
        weatherDescriptionButton.isHidden = true
        addConstraintsWithFormat("V:|-10-[v0(40)]-10-|", views: cityLabel)
        addConstraintsWithFormat("V:|-10-[v0(40)]-10-|", views: iconWeatherImage)
        addConstraintsWithFormat("V:|-10-[v0(40)]-10-|", views: tempLabel)
        addConstraintsWithFormat("H:|-20-[v0]-20-[v1(40)]-20-[v2(40)]-10-|", views: cityLabel, iconWeatherImage, tempLabel)
    }
    
    func setupViewsForHighCell() {
        iconWeatherImage.isHidden = true
        tempLabel.isHidden = true
        weatherDescriptionButton.isHidden = false
        addConstraintsWithFormat("V:|-10-[v0(40)]-10-|", views: weatherDescriptionButton)
        addConstraintsWithFormat("H:|-20-[v0]-10-[v1(150)]-10-|", views: cityLabel, weatherDescriptionButton)
        addConstraintsWithFormat("V:|-60-[v0]-10-|", views: collectionView)
        addConstraintsWithFormat("H:|-20-[v0]-10-|", views: collectionView)
    }
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.setContentOffset(collectionView.contentOffset, animated:false)
        collectionView.reloadData()
    }
    func createTextFieldToSubview () {
        addSubview(cityTextField)
        addConstraintsWithFormat("V:|-10-[v0(40)]-10-|", views: cityTextField)
        addConstraintsWithFormat("H:|-20-[v0]-20-|", views: cityTextField)
    }
    
}
