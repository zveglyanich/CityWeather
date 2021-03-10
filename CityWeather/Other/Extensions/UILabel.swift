//
//  UILabel.swift
//  CityWeather
//
//  Created by Pavel Zveglyanich on 3/2/21.
//

import Foundation
import UIKit

extension UILabel {
    func createCustomLabel (textAlignment: NSTextAlignment, numberOfLines: Int, font: UIFont, textColor: UIColor) -> UILabel {
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
        self.font = font
        self.textColor = textColor
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
