//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Kenyan Houck on 3/16/19.
//  Copyright © 2019 Kenyan Houck. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherLocation {
    var name = ""
    var coordinates = ""
    var currentTemp = "--"
    var currentSummary = "--"
    
    
    func getWeather(completed: @escaping() -> ()){
        
        let weatherURL = urlBase + urlAPIKey + coordinates
        
        
        Alamofire.request(weatherURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let temperature = json["currently"]["temperature"].double {
                    //print("***** Temperature inside getWeather = \(temperature)")
                    let roundedTemp = String(format: "%3.f", temperature)
                    self.currentTemp = roundedTemp + "°"
                } else {
                    print("Could not return a temp")
                }
                if let weatherSummary = json["daily"]["summary"].string {
                    //print("***** Temperature inside getWeather = \(temperature)")
                    self.currentSummary = weatherSummary
                } else {
                    print("Could not return a forecase summary")
                }
            case .failure(let error):
                print(error)
            }
            completed()
        }
    }
}
