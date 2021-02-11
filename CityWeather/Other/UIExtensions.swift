//
//  extension UIElement.swift
//  CityWeather
//
//  Created by Pavel Zveglyanich on 2/8/21.
//

import Foundation
import UIKit

extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

extension UILabel {
    
    func createLabel (textAlignment: NSTextAlignment, numberOfLines: Int, font: UIFont, textColor: UIColor) -> UILabel {
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
        self.font = font
        self.textColor = textColor
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}

extension UIImageView {
    func translatesAutoresizingMask() -> UIImageView {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}

extension UITextField {
    func translatesAutoresizingMask() -> UITextField {
        self.textColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}

extension UIStackView {
    func createStackView(axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution , alignment:  UIStackView.Alignment, spacing: CGFloat) -> UIStackView {
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
        return self
    }
}

extension UITableView {
    func createCustomTableview() -> UITableView {
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
