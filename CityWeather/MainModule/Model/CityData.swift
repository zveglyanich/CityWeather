//
//  WeatherOfCityData.swift
//  CityWeather
//
//  Created by Pavel Zveglyanich on 1/21/21.
//

import  RealmSwift

class CityData: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var city: String = ""
    @objc dynamic var tempNow: Int = 0
    @objc dynamic var tempFeelsLike: Int = 0
    @objc dynamic var tempMax: Int = 0
    @objc dynamic var tempMin: Int = 0
    @objc dynamic var humidity: Int = 0
    @objc dynamic var windDegree: String = ""
    @objc dynamic var windSpeed: Float = 0
    @objc dynamic var weatherIconeName: String = ""
    @objc dynamic var descriptionWeather: String = ""
    @objc dynamic var condition: Int = 0
    var hourlyWeather = List<CityHourlyWeather>()
    var dailyWeather = List<CityDailyWeather>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
class CityHourlyWeather: Object {
    @objc dynamic var hourlyWeatherTime: String = ""
    @objc dynamic var hourlyWeatherTemp: Int = 0
    @objc dynamic var hourlyWeatherIcon: String = ""
}
class CityDailyWeather: Object {
    @objc dynamic var dailyWeatherDay: String = ""
    @objc dynamic var dailyWeatherTempDay: Int = 0
    @objc dynamic var dailyWeatherTempNight: Int = 0
    @objc dynamic var dailyWeatherIcon: String = ""
}

