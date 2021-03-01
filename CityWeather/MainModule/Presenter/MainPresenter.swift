//
//  MainPresenter.swift
//  CityWeather
//
//  Created by Pavel Zveglyanich on 1/15/21.
//

import UIKit
import RealmSwift

//Output
protocol MainViewprotocol: class {
    func succes()
    func failure(error: Error)
    
}

//input
protocol MainViewPresenterProtocol: class {
    init(view: MainViewprotocol, networService: NetworkServiceProtocol, storageService: Storageprotocol, router: MainRouterProtocol)
    func getWeather(city: String)
    func uploadListOfCities()
    func saveListOfCities(city: String, tempNow: Int, tempFeelsLike: Int, tempMax: Int, tempMin: Int, humidity: Int, windDegree: String, windSpeed: Float, weatherIconeName: String, descriptionWeather: String, condition: Int, hourlyWeather: [(time: String, temp: Int, weather: String)], dailyWeather: [(day: String, tempDay: Int, tempNight: Int, weather: String)])
    func deleteCityInListOfCities(indexPath: IndexPath)
    var weatherOfCity: WeatherDataModel? {get set}
    var listOfCities: Results<CityData>! {get}
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
    
    func getWeather(city: String) {
        networService.getRequest(city: city) { [weak self] weatherData in
            guard let self = self else {return }
            DispatchQueue.main.async {
                switch weatherData {
                case .success(let result):
                    self.weatherOfCity = result
                    self.updateValues()
                    self.uploadListOfCities()
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
        listOfCities = storageService.realm.objects(CityData.self)
    }
    func saveListOfCities(city: String,
                          tempNow: Int,
                          tempFeelsLike: Int,
                          tempMax: Int,
                          tempMin: Int,
                          humidity: Int,
                          windDegree: String,
                          windSpeed: Float,
                          weatherIconeName: String,
                          descriptionWeather: String,
                          condition: Int,
                          hourlyWeather: [(time: String, temp: Int, weather: String)],
                          dailyWeather: [(day: String, tempDay: Int, tempNight: Int, weather: String)]) {
        let cityHourlyWeather =  List<CityHourlyWeather>()
        for index in 0..<hourlyWeather.count {
            let elementHourlyWeather = CityHourlyWeather(value: [hourlyWeather[index].time, hourlyWeather[index].temp, hourlyWeather[index].weather])
            cityHourlyWeather.append(elementHourlyWeather)
        }
        let cityDailyWeather =  List<CityDailyWeather>()
        for index in 0..<dailyWeather.count {
            let elementDailyWeather = CityDailyWeather(value: [dailyWeather[index].day, dailyWeather[index].tempDay, dailyWeather[index].tempNight, dailyWeather[index].weather])
            cityDailyWeather.append(elementDailyWeather)
        }
        let id = listOfCities.count
        let cityData = CityData(value: [id, city, tempNow, tempFeelsLike, tempMax, tempMin, humidity, windDegree, windSpeed, weatherIconeName, descriptionWeather, condition, cityHourlyWeather, cityDailyWeather])
        storageService.saveCity(cityData)
        uploadListOfCities()
    }
    func deleteCityInListOfCities(indexPath: IndexPath) {
        storageService.deleteCity(listOfCities[indexPath.row])
        
    }
    func updateValues() {
        if let data = weatherOfCity {
            saveListOfCities(city: data.city,
                             tempNow: data.tempNow,
                             tempFeelsLike: data.tempFeelsLike,
                             tempMax: data.tempMax,
                             tempMin: data.tempMin,
                             humidity: data.humidity,
                             windDegree: data.windDegree,
                             windSpeed: data.windSpeed,
                             weatherIconeName: data.weatherIconeName,
                             descriptionWeather: data.description,
                             condition: data.condition,
                             hourlyWeather: data.hourlyWeather,
                             dailyWeather: data.dailyWeather)
        }
    }
}
