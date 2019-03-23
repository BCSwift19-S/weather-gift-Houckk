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
    
    struct DailyForecast{
        var dailyMaxTemp: Double
        var dailyMinTemp: Double
        var dailyDate: Double
        var dailySummary: String
        var dailyIcon: String
    }
    
    var name = ""
    var coordinates = ""
    var currentTemp = "--"
    var currentSummary = "--"
    var currentIcon = ""
    var currentTime = 0.0
    var timeZone = ""
    var dailyForecastArray = [DailyForecast]()
    
    
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
                if let icon = json["currently"]["icon"].string {
                    //print("***** Temperature inside getWeather = \(temperature)")
                    self.currentIcon = icon
                } else {
                    print("Could not return an icon")
                }
                if let timeZone = json["timezone"].string {
                    // print ("TIMEZONE for \(self.name) is \(timeZone)")
                    //print("***** Temperature inside getWeather = \(temperature)")
                    self.timeZone = timeZone
                } else {
                    print("Could not return a timeZone")
                }
                if let time = json["currently"]["time"].double {
                    //print ("TIME for \(self.name) is \(time)")
                    //print("***** Temperature inside getWeather = \(temperature)")
                    self.currentTime = time
                } else {
                    print("Could not return a time")
                }
                let dailyDataArray = json["daily"]["data"]
                self.dailyForecastArray = []
                for day in 1...dailyDataArray.count-1 {
                    let maxTemp = json["daily"]["data"][day]["temperatureHigh"].doubleValue
                    let minTemp = json["daily"]["data"][day]["temperatureLow"].doubleValue
                    let dateValue = json["daily"]["data"][day]["time"].doubleValue
                    let icon = json["daily"]["data"][day]["icon"].stringValue
                    let dailySummary = json["daily"]["data"][day]["summary"].stringValue
                    let newDailyForecast = DailyForecast(dailyMaxTemp: maxTemp, dailyMinTemp: minTemp, dailyDate: dateValue, dailySummary: dailySummary, dailyIcon: icon)
                    self.dailyForecastArray.append(newDailyForecast)
                }
            case .failure(let error):
                print(error)
            }
            completed()
        }
    }
}
