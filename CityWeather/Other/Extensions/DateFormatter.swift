//
//  DateFormatter.swift
//  CityWeather
//
//  Created by Pavel Zveglyanich on 3/4/21.
//

import Foundation

extension DateFormatter { //Remark #33
    func createCustomDateFormatter(style: FormatDate) -> DateFormatter {
        let dateFormat = DateFormatter()
        dateFormat.timeZone = .current
        switch style {
        case .dayFormat:
            dateFormat.timeStyle = DateFormatter.Style.none
            dateFormat.dateStyle = DateFormatter.Style.full
            return dateFormat
        case .timeFormat:
            dateFormat.timeStyle = DateFormatter.Style.short
            dateFormat.dateStyle = DateFormatter.Style.none
            return dateFormat
        }
    }
}
