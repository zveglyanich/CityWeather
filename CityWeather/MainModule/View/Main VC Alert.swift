//
//  Alert.swift
//  CityWeather
//
//  Created by Pavel Zveglyanich on 2/8/21.
//

import Foundation


import Foundation
import UIKit

class Alert{
    
    func showAlert(error: Error) -> UIAlertController {
       var title = ""
        var message = ""
        
        if let response = error.asAFError?.responseCode {
            switch response {
            case 400...499:
                title = "Incorrect request"
                message = "Please enter the correct city name"
            case 500...599:
                title = "Internal Server Error"
                message = "Send your request later"
            default:
                message = "Uknown Error"
            }
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okAction)
        return alert
    }

}
