//
//  ViewController.swift
//  CityWeather
//
//  Created by Pavel Zveglyanich on 1/20/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    var presenter: DetailViewPresenterProtocol!
    private let numberOfRowsInSection = 5
    var weatherCity: CityData?
    
    let tableView = UITableView().createCustomTableview()
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setWeather()
        view.backgroundColor = .none
        tableView.tableFooterView = UIView()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
        self.view.insertSubview(backgroundImage, at: 0)
        
        createTableViewConstraint()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(DetailFirstTableViewCell.self, forCellReuseIdentifier: DetailFirstTableViewCell.cellId) //Remark #36
        tableView.register(DetailSecondTableViewCell.self, forCellReuseIdentifier: DetailSecondTableViewCell.cellId) //Remark #36
        tableView.register(DetailThirdTableViewCell.self, forCellReuseIdentifier: DetailThirdTableViewCell.cellId) //Remark #36
        tableView.register(DetailDefaultTableViewCell.self, forCellReuseIdentifier: DetailDefaultTableViewCell.cellId) //Remark #36
    }
    private func createTableViewConstraint() {
        view.addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20.0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20.0).isActive = true
    }
}

extension DetailViewController: DetailViewProtocol {
    func setWeatherOfCity(weatherDataModel: CityData?) {
        self.weatherCity = weatherDataModel
    }
}
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return 220
        case 1: return 110
        case 2: return 230
        default: return 80
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailFirstTableViewCell.cellId, for: indexPath) as! DetailFirstTableViewCell //Remark #36
            cell.selectionStyle = .none
            
            if let weather = weatherCity {
                cell.cityAndFeelsLikeLabel.text = "\(weather.city)\nFeels like \(weather.tempFeelsLike)°"
                cell.iconWeatherImage.image = UIImage(named: weather.weatherIconeName)
                cell.descriptionLabel.text = weather.descriptionWeather
            }
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailSecondTableViewCell.cellId, for: indexPath) as! DetailSecondTableViewCell //Remark #36
            cell.selectionStyle = .none
            cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: 1)
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailThirdTableViewCell.cellId, for: indexPath) as! DetailThirdTableViewCell //Remark #36
            cell.selectionStyle = .none
            
            if let weather = weatherCity {
                for index in 0...DetailThirdTableViewCell.countOfStringOnStackView { //Remark #35, 37
                    let labelDay = cell.views[index].subviews[0] as! UILabel
                    let imageviewIconWeather = cell.views[index].subviews[1] as! UIImageView
                    let labelTempDay = cell.views[index].subviews[2] as! UILabel
                    let labelTempNight = cell.views[index].subviews[3] as! UILabel
                    
                    labelDay.text = weather.dailyWeather[index].dailyWeatherDay
                    imageviewIconWeather.image = UIImage(named: weather.dailyWeather[index].dailyWeatherIcon)
                    labelTempDay.text = "\(weather.dailyWeather[index].dailyWeatherTempDay)°"
                    labelTempNight.text = "\(weather.dailyWeather[index].dailyWeatherTempNight)°"
                }
            }
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailDefaultTableViewCell.cellId, for: indexPath) as! DetailDefaultTableViewCell //Remark #36
            cell.selectionStyle = .none
            if let weather = weatherCity {
                cell.nameLabel.text = "HUMIDITY"
                cell.valueLabel.text = "\(weather.humidity)%"
            }
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailDefaultTableViewCell.cellId, for: indexPath) as! DetailDefaultTableViewCell //Remark #36
            cell.selectionStyle = .none
            if let weather = weatherCity {
                cell.nameLabel.text = "WIND"
                cell.valueLabel.text = "\(weather.windDegree) \(weather.windSpeed) m/s"
            }
            return cell
            
        default:  return UITableViewCell()
        }
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/8, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherCity?.hourlyWeather.count == nil ? 0 : weatherCity!.hourlyWeather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailSecondCollectionViewCell.cellId, for: indexPath) as! DetailSecondCollectionViewCell
        
        if let weatherData = weatherCity {
            let weatherHourly = weatherData.hourlyWeather[indexPath.row]
            let time = weatherHourly.hourlyWeatherTime
            let temp = weatherHourly.hourlyWeatherTemp
            let imageString = weatherHourly.hourlyWeatherIcon
            cell.tempHourlyLabel.text = "\(time)\n\(temp)°\n"
            cell.iconHourlyWeatherImage.image = UIImage(named: imageString)
        }
        return cell
    }
}


