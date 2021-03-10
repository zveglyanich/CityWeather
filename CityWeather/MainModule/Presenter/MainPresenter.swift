//
//  MainPresenter.swift
//  CityWeather
//
//  Created by Pavel Zveglyanich on 1/15/21.
//

import UIKit
import RealmSwift

protocol MainViewprotocol: class {
    func succes()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: class {
    init(view: MainViewprotocol, networService: NetworkServiceProtocol, storageService: Storageprotocol, router: MainRouterProtocol)
    func createRequestToGetData(fromText: String)
    func uploadListOfCities()
    func deleteCityInListOfCities(indexPath: IndexPath)
    var weatherOfCity: WeatherDataModel? { get set }
    var listOfCities: Results<CityData>! { get }
    func tapOnTheCellCityWeather(weatherDataModel: CityData?)
}

class MainPresenter: MainViewPresenterProtocol {
    
    weak var view: MainViewprotocol?
    var router: MainRouterProtocol?
    let networService: NetworkServiceProtocol
    let storageService: Storageprotocol
    var weatherOfCity: WeatherDataModel?
    var listOfCities: Results<CityData>!
    
    required init(view: MainViewprotocol, networService: NetworkServiceProtocol, storageService: Storageprotocol, router: MainRouterProtocol) {
        self.view = view
        self.router = router
        self.networService = networService
        self.storageService = storageService
        self.uploadListOfCities()
    }
    
    func createRequestToGetData(fromText: String) { //Remark #21
        networService.getRequest(city: fromText) { [weak self] weatherData in
            guard let self = self else {return }
            DispatchQueue.main.async {
                switch weatherData {
                case .success(let result):
                    self.weatherOfCity = result
                    self.uploadListOfCities()
                    self.updateValues()
                    self.view?.succes()
                case .failure(let error): self.view?.failure(error: error)
                }
            }
        }
    }
    
    func tapOnTheCellCityWeather(weatherDataModel: CityData?) {
        if let routerForDetailVC = router {
            routerForDetailVC.showDetailWeather(builder: MainModelBuilder.createDetailModule(weatherDataModel: weatherDataModel, router: routerForDetailVC))
        }
    }
    func uploadListOfCities() {
        listOfCities = storageService.realm?.objects(CityData.self)

    }
    func deleteCityInListOfCities(indexPath: IndexPath) {
        do {
            try storageService.deleteCity(listOfCities[indexPath.row])
        } catch let error {
            view?.failure(error: error)
        }
        
        
        
    }
    func updateValues() {
        if let data = weatherOfCity {
    
            let datacityHourlyWeather =  List<CityHourlyWeather>()
            for index in 0..<data.hourlyWeather.count {
                let elementHourlyWeather = CityHourlyWeather(value: [data.hourlyWeather[index].time,
                                                                     data.hourlyWeather[index].temp,
                                                                     data.hourlyWeather[index].weather])
                datacityHourlyWeather.append(elementHourlyWeather)
            }
    
            let datacityDailyWeather =  List<CityDailyWeather>()
            for index in 0..<data.dailyWeather.count {
                let elementDailyWeather = CityDailyWeather(value: [data.dailyWeather[index].day,
                                                                   data.dailyWeather[index].tempDay,
                                                                   data.dailyWeather[index].tempNight,
                                                                   data.dailyWeather[index].weather])
                datacityDailyWeather.append(elementDailyWeather)
            }
    
            let dataID = listOfCities.count
            let cityData = CityData(value: [dataID,
                                            data.city,
                                            data.tempNow,
                                            data.tempFeelsLike,
                                            data.tempMax,
                                            data.tempMin,
                                            data.humidity,
                                            data.windDegree,
                                            data.windSpeed,
                                            data.weatherIconeName,
                                            data.description,
                                            data.condition,
                                            datacityHourlyWeather,
                                            datacityDailyWeather])
            do {
                try storageService.saveCity(cityData)
            } catch let error {
                view?.failure(error: error)
            }
            uploadListOfCities()
        }
    }
}
