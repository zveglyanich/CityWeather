//
//  MainViewController extensions.swift
//  CityWeather
//
//  Created by Pavel Zveglyanich on 2/8/21.
//

import Foundation
import UIKit

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.listOfCities.count == 0 || numberOfRows != 0 ? numberOfRows : presenter.listOfCities.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.cellId, for: indexPath) as! MainTableViewCell
        
        cell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        cell.cityTextField.delegate = self
        cell.selectionStyle = .none
        if indexPath.row < presenter.listOfCities.count  {
            let weatherDataModel = presenter.listOfCities[indexPath.row]
            cell.cityLabel.text = weatherDataModel.city
            cell.iconWeatherImage.image = UIImage(named: weatherDataModel.weatherIconeName)
            cell.tempLabel.text = "\(weatherDataModel.tempNow)°"
            cell.weatherDescriptionButton.tag = indexPath.row
            cell.weatherDescriptionButton.addTarget(self, action: #selector(tapOnButton(sender:)), for: .touchUpInside)
        }
        return cell
    }
    @objc func tapOnButton(sender: UIButton) {
        let cityData = presenter.listOfCities[sender.tag]
        presenter.tapOnTheCellCityWeather(weatherDataModel: cityData)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == selectedIndexPath {
            selectedIndexPath = nil
            tableView.reloadRows(at: [indexPath], with: .automatic)
        } else {
            tableView.cellForRow(at: indexPath)?.reloadInputViews()
            selectedIndexPath = indexPath
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == self.selectedIndexPath {
            return bigSizeHeightCell
        } else {
            return smallSizeHeightCell
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.deleteCityInListOfCities(indexPath: indexPath)
            numberOfRows -= 1
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return presenter.listOfCities.count != numberOfRows
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        textField.invalidateIntrinsicContentSize()
    }
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/8, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfRows == presenter.listOfCities.count ? presenter.listOfCities[collectionView.tag].hourlyWeather.count : 0
    }
    
    //MARK: fix correct view on cell collectionview about indexpath
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.cellId, for: indexPath) as! WeatherCollectionViewCell
        let weatherHourly = presenter.listOfCities[collectionView.tag].hourlyWeather[indexPath.row]
        let time = weatherHourly.hourlyWeatherTime
        let temp = weatherHourly.hourlyWeatherTemp
        let imageString = weatherHourly.hourlyWeatherIcon
        cell.tempHourlyLabel.text = "\(time)\n\(temp)°\n"
        cell.iconHourlyWeatherImage.image = UIImage(named: imageString)
        return cell
    }
}
