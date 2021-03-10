//
//  UITextField.swift
//  CityWeather
//
//  Created by Pavel Zveglyanich on 3/2/21.
//

import Foundation
import UIKit

extension UITextField {
    func createTextFieldWithTranslatesAutoresizingMask() -> UITextField {
        self.textColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
