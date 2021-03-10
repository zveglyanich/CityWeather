//
//  WeatherDataModel.swift
//  CityWeather
//
//  Created by Pavel Zveglyanich on 1/15/21.
//

import UIKit
import SwiftyJSON

enum FormatDate {
    case dayFormat
    case timeFormat
}

struct WeatherDataModel {
    
    var tempNow: Int
    var tempFeelsLike: Int
    var tempMax: Int
    var tempMin: Int
    var city: String
    var humidity: Int
    var windDegree: String
    var windSpeed: Float
    var weatherIconeName: String
    var description: String
    var condition: Int
    var hourlyWeather: [(time: String, temp: Int, weather: String)]
    var dailyWeather: [(day: String, tempDay: Int, tempNight: Int, weather: String)]
    
    static let timeStyleDateFormatter = DateFormatter().createCustomDateFormatter(style: .timeFormat) //Remark #33
    static let dateStyleDateFormatter = DateFormatter().createCustomDateFormatter(style: .dayFormat) //Remark #33
    
    init(jsonOfCity: JSON, jsonOfHourlyDailyWeather: JSON) {
        
        let mainData = jsonOfCity["main"]
        
        let temperature = mainData["temp"].intValue
        let tempFeelsLike = mainData["feels_like"].intValue
        let tempMax = mainData["temp_max"].intValue
        let tempMin = mainData["temp_min"].intValue
        let city = jsonOfCity["name"].stringValue
        let humidity = mainData["humidity"].intValue
        let windDegree = jsonOfCity["wind"]["deg"].intValue
        let windSpeed = jsonOfCity["wind"]["speed"].floatValue
        let condition = jsonOfCity["weather"][0]["id"].intValue
        let description = jsonOfCity["weather"][0]["description"].stringValue

        let hourlyWeather : [(time: String, temp: Int, weather: String)] = jsonOfHourlyDailyWeather["hourly"].compactMap { (_, JSON) -> (time: String, temp: Int, weather: String) in
            let weatherTime = WeatherDataModel.createTimeResult(result: JSON["dt"].intValue, inFormate: .timeFormat)
            let weatherTemp = JSON["temp"].intValue
            let weatherCondition = WeatherDataModel.updateWeatherIcon(condition: JSON["weather"][0]["id"].intValue)
            let hourlydictionary = (time: weatherTime, temp: weatherTemp, weather: weatherCondition)
            return hourlydictionary
        }
        let dailyWeather : [(day: String, tempDay: Int, tempNight: Int, weather: String)] = jsonOfHourlyDailyWeather["daily"].compactMap { (_, JSON) -> (day: String, tempDay: Int, tempNight: Int, weather: String) in
            let day = WeatherDataModel.createTimeResult(result: JSON["dt"].intValue, inFormate: .dayFormat)
            let tempDay = JSON["temp"]["day"].intValue
            let tempNight = JSON["temp"]["night"].intValue
            let weather = WeatherDataModel.updateWeatherIcon(condition: JSON["weather"][0]["id"].intValue)
            let dailydictionary = (day: day, tempDay: tempDay, tempNight: tempNight, weather: weather)
            return dailydictionary
        }
        self.tempNow = temperature
        self.tempFeelsLike = tempFeelsLike
        self.tempMax = tempMax
        self.tempMin = tempMin
        self.city = city
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.description = description
        self.condition = condition
        self.hourlyWeather = hourlyWeather
        self.dailyWeather = dailyWeather
        self.weatherIconeName = WeatherDataModel.updateWeatherIcon(condition: condition)
        self.windDegree = WeatherDataModel.updateWindDegree(condition: windDegree)
    }
    
    static func createTimeResult (result: Int, inFormate: FormatDate) -> String { //Remark #33
        let date = Date(timeIntervalSince1970: Double(result))
        switch inFormate {
        case .dayFormat:
            let dateString = dateStyleDateFormatter.string(from: date)
            let startIndex = dateString.range(of: ",", options: .caseInsensitive)!.lowerBound
            return String(dateString[startIndex...])
        case .timeFormat:
            let stringDate = timeStyleDateFormatter.string(from: date)
            let endindex = stringDate.index(stringDate.endIndex, offsetBy: -6)
            return String(stringDate[...endindex])
        }
    }
    static func updateWeatherIcon(condition: Int?) -> String {
        guard let condition = condition else { return "warm"}
        switch (condition) {
        case 0...299 : return "thunder"
        case 300...499 : return "showers"
        case 500...510 : return "sun rain"
        case 511 : return "snowy"
        case 512...599 : return "heavy rain"
        case 600...699 : return "snowy"
        case 700...730, 732...770 : return "fog"
        case 731, 771 : return "windy"
        case 772...781 : return "stormy"
        case 800 : return "sunny"
        case 801 : return "sunny to cloudy"
        case 802 : return "cloudy"
        case 803...804 : return "overcast"
        default : return "warm"
        }
    }
    
    static func updateWindDegree(condition: Int?) -> String {
        guard let condition = condition else { return "data is missing"}
        switch (condition) {
        case 1...44 : return "NNE"
        case 45 : return "NE"
        case 46...89 : return "ENE"
        case 90 : return "E"
        case 91...134 : return "ESE"
        case 135 : return "SE"
        case 136...179 : return "SSE"
        case 180 : return "S"
        case 181...224 : return "SSW"
        case 225 : return "SW"
        case 226...269 : return "WSW"
        case 270 : return "W"
        case 271...314 : return "WNW"
        case 315 : return "NW"
        case 316...359 : return "NNW"
        case 0, 360 : return "N"
        default : return "Calm"
        }
    }
}
