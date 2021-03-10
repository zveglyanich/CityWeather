//
//  DetailPresenter.swift
//  CityWeather
//
//  Created by Pavel Zveglyanich on 1/20/21.
//

import Foundation

protocol DetailViewProtocol: class {
    func setWeatherOfCity(weatherDataModel: CityData?)
}

protocol DetailViewPresenterProtocol: class  {
    init (view: DetailViewProtocol, weatherDataModel: CityData?, router: MainRouterProtocol)
    func setWeather()
}

class DetailPresenter: DetailViewPresenterProtocol {
    weak var view: DetailViewProtocol?
    var router: MainRouterProtocol?
    var weatherOfCity: CityData?
    required init(view: DetailViewProtocol, weatherDataModel: CityData?, router: MainRouterProtocol) {
        self.view = view
        self.weatherOfCity = weatherDataModel
        self.router = router
    }
    
    func setWeather() {
        self.view?.setWeatherOfCity(weatherDataModel: weatherOfCity)
    }

}
