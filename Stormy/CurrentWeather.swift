//
//  CurrentWeather.swift
//  Stormy
//
//  Created by Gabriel Coronel on 10/11/15.
//  Copyright © 2015 Gabriel Coronel. All rights reserved.
//

import Foundation
import UIKit

enum Icon: String {
    case ClearDay = "clear-day"
    case ClearNight = "clear-night"
    case Rain = "rain"
    case Snow = "snow"
    case Sleet = "sleet"
    case Wind = "wind"
    case Fog = "fog"
    case Cloudy = "cloudy"
    case PartlyCloudyDay = "partly-cloudy-day"
    case PartlyCloudyNight = "partly-cloudy-night"
}

struct CurrentWeather {
    
    var currentTime: String?
    var temperature: Int?
    var humidity: Int?
    var precipProbability: Int?
    var summary: String?
    var icon: UIImage? = UIImage(named: "default.png")
    
    init(weatherDictionary: NSDictionary) {
//        let currentWeather = weatherDictionary["currently"] as! NSDictionary
        
        temperature = weatherDictionary["temperature"] as? Int
        if let humidityFloat = weatherDictionary["humidity"] as? Double {
            humidity = Int(humidityFloat * 100)
        }
        if let precipFloat = weatherDictionary["precipProbability"] as? Double {
            precipProbability = Int(precipFloat * 100)
        }
        
        summary = weatherDictionary["summary"] as? String
        if let iconString = weatherDictionary["icon"] as? String {
            icon = weatherImageFromIconString(iconString)
        }
    }
    
    func weatherImageFromIconString(iconString: String) -> UIImage? {
        var imageName: String = "default.png"
        
        if let iconValue = Icon(rawValue: iconString) {
            switch iconValue {
            case .ClearDay:
                imageName = "clear-day.png"
            case .ClearNight:
                imageName = "clear-night.png"
            case .Rain:
                imageName = "rain.png"
            case .Snow:
                imageName = "snow.png"
            case .Sleet:
                imageName = "sleet.png"
            case .Wind:
                imageName = "wind.png"
            case .Fog:
                imageName = "fog.png"
            case .Cloudy:
                imageName = "cloudy.png"
            case .PartlyCloudyDay:
                imageName = "cloudy-day.png"
            case .PartlyCloudyNight:
                imageName = "cloudy-night.png"
            }
        }
        return UIImage(named: imageName)
    }
}