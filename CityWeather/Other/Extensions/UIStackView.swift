//
//  UIStackView.swift
//  CityWeather
//
//  Created by Pavel Zveglyanich on 3/2/21.
//

import Foundation
import UIKit

extension UIStackView {
    func createCustomStackView(axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution , alignment:  UIStackView.Alignment, spacing: CGFloat) -> UIStackView {
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
        return self
    }
}
