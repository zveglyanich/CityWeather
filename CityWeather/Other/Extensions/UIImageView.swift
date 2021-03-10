//
//  UIImageView.swift
//  CityWeather
//
//  Created by Pavel Zveglyanich on 3/2/21.
//

import Foundation
import UIKit

extension UIImageView {
    func createImageViewWithTranslatesAutoresizingMask() -> UIImageView {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
