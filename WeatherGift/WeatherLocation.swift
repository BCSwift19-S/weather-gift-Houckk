//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Kenyan Houck on 3/25/19.
//  Copyright © 2019 Kenyan Houck. All rights reserved.
//

import Foundation

class WeatherLocation{
    var name: String
    var coordinates: String
    
    
    init(name: String, coordinates: String)
    {
        self.name = name
        self.coordinates = coordinates
    }
}
