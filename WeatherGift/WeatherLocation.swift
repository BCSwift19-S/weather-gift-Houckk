//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Kenyan Houck on 3/16/19.
//  Copyright © 2019 Kenyan Houck. All rights reserved.
//

import Foundation
import Alamofire

class WeatherLocation {
    var name = ""
    var coordinates = ""
    
    
    func getWeather(){
        
        let weatherURL = urlBase + urlAPIKey + coordinates
        print(weatherURL)
        
        Alamofire.request(weatherURL).responseJSON { response in print(response)
            
        }
    }
}
