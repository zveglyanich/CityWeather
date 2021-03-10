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
    
    static let shared = NetworkManager() //remark #6
    
    private let apiKey = "8596f2c90ca55a77da5105414c00c009"
    private let units = "metric"
    private var baseURL: URLComponents = { //remark #8
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        return urlComponents
    }()
    
    private init () {} //remark #6
    
    func getRequest(city: String, completion: @escaping (Result<WeatherDataModel?, Error>) -> Void) {
        
        var jsonOfCity: JSON?
        
        self.baseURL.path = "/data/2.5/weather"
        baseURL.queryItems = [URLQueryItem(name: "q", value: city),
                              URLQueryItem(name: "apikey", value: apiKey),
                              URLQueryItem(name: "units", value: units)] //remark #8
        guard let urlCity = baseURL.url  else {
            return completion(.failure(AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: 400)))) //remark #9
        }
        
        AF.request(urlCity).validate().responseJSON { [weak self] response in
            switch response.result {
            case .success:
                guard response.value != nil else { //remark #11
                    return completion(.failure(AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: 500))))
                }
                jsonOfCity = JSON(response.value!)
                getRequestFromLatLon()
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        func getRequestFromLatLon () {   //remark #12
            
            self.baseURL.path = "/data/2.5/onecall"
            guard let lat = jsonOfCity?["coord"]["lat"].doubleValue,  //remark #11
                  let lon = jsonOfCity?["coord"]["lon"].doubleValue
            else {
                return completion(.failure(AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: 500))))
            }
            self.baseURL.queryItems = [URLQueryItem(name: "lat", value: String(lat)),
                                       URLQueryItem(name: "lon", value: String(lon)),
                                       URLQueryItem(name: "exclude", value: "current"),
                                       URLQueryItem(name: "appid", value: self.apiKey),
                                       URLQueryItem(name: "units", value: self.units)] //remark #8
            guard let urlLatLon = self.baseURL.url  else {
                return completion(.failure(AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: 400)))) //remark #9
            }
            
            AF.request(urlLatLon).validate().responseJSON { [weak self] response in //remark #12
                switch response.result {
                case .success:
                    guard response.value != nil else {  //remark #11
                        return completion(.failure(AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: 500))))
                    }
                    let json = JSON(response.value!)
                    let weatherDataModel = WeatherDataModel(jsonOfCity: jsonOfCity!, jsonOfHourlyDailyWeather: json)
                    completion(.success(weatherDataModel))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}



 
