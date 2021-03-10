//
//  UIButton.swift
//  CityWeather
//
//  Created by Pavel Zveglyanich on 3/2/21.
//

import Foundation
import UIKit

extension UIButton {
    func createCustomButton (title: String?, for stateTitle: UIControl.State, color: UIColor?, for stateColor: UIControl.State) -> UIButton {
        self.setTitle(title, for: stateTitle)
        self.setTitleColor(color, for: stateColor)
        self.translatesAutoresizingMaskIntoConstraints = false
        return self

    }
}
