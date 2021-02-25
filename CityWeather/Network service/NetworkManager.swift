//
//  NetworkManager.swift
//  CityWeather
//
//  Created by Pavel Zveglyanich on 1/16/21.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol NetworkServiceProtocol {
    func getRequest (city: String, completion: @escaping (Result<WeatherDataModel?, Error>) -> Void)
}

class NetworkManager: NetworkServiceProtocol {
    
    let apiKey = "8596f2c90ca55a77da5105414c00c009"
    let units = "metric"
    let baseURL = "https://api.openweathermap.org/data/2.5/"
    
    func getRequest(city: String, completion: @escaping (Result<WeatherDataModel?, Error>) -> Void) {
        
        let paramStringForCity = "weather?q=\(city)&apikey=\(apiKey)&units=\(units)"
        let urlForCity = baseURL + paramStringForCity
        
        guard let urlCity = URL(string: urlForCity)  else { return print ("incorrection URL of City")}
        AF.request(urlCity).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                let jsonOfCity = JSON(response.value!)
                
                let lon = JSON(response.value)["coord"]["lon"].doubleValue
                let lat = JSON(response.value)["coord"]["lat"].doubleValue
                let paramStringForLatLon = "onecall?lat=\(lat)&lon=\(lon)&exclude=current&appid=\(self.apiKey)&units=\(self.units)"
                let urlForLatLon = self.baseURL + paramStringForLatLon
                
                guard let urlLatLon = URL(string: urlForLatLon)  else { return print ("incorrection URL of lat/lon City")}
                AF.request(urlLatLon).validate().responseJSON { response in
                    switch response.result {
                    case .success:
                        let json = JSON(response.value!)
                        let weatherDataModel = WeatherDataModel(jsonOfCity: jsonOfCity, jsonOfHourlyDailyWeather: json)
                        completion(.success(weatherDataModel))
                    case .failure(let error): completion(.failure(error))
                    }
                }
            case .failure(let error): completion(.failure(error))
            }
        }
    }
    
}

