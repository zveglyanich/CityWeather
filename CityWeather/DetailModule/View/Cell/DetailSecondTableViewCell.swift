//
//  DetailSecondTableViewCell.swift
//  CityWeather
//
//  Created by Pavel Zveglyanich on 2/3/21.
//

import UIKit

class DetailSecondTableViewCell: UITableViewCell {
    
    let tempCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.backgroundColor = .clear
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        collectionview.register(DetailSecondCollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        return collectionview
    }()
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        tempCollectionView.delegate = dataSourceDelegate
        tempCollectionView.dataSource = dataSourceDelegate
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tempCollectionView.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubview(tempCollectionView)
        addConstraintsWithFormat("V:|-10-[v0]-10-|", views: tempCollectionView)
        addConstraintsWithFormat("H:|-20-[v0]-10-|", views: tempCollectionView)
        
    }
}

class DetailSecondCollectionViewCell: WeatherCollectionViewCell {
    
}
