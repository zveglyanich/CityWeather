//
//  UITableView.swift
//  CityWeather
//
//  Created by Pavel Zveglyanich on 3/2/21.
//

import Foundation
import UIKit

extension UITableView {
    func createCustomTableview() -> UITableView {
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
