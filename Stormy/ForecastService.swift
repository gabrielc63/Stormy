//
//  ForecastService.swift
//  Stormy
//
//  Created by Gabriel Coronel on 10/11/15.
//  Copyright © 2015 Gabriel Coronel. All rights reserved.
//

import Foundation

struct ForecastService {
    
    let forecastAPIKey: String
    let forecastBaseURL: NSURL?
    
    init (APIKey: String) {
        forecastAPIKey = APIKey
        forecastBaseURL = NSURL(string: "https://api.forecast.io/forecast/\(forecastAPIKey)/")
    }
    
    func getForecast(lat: Double, long: Double, completion: (CurrentWeather? -> Void)) {
        if let forecastURL = NSURL(string: "\(lat),\(long)?units=si", relativeToURL: forecastBaseURL) {
            let networkOperation = NetworkOperation(url: forecastURL)
            networkOperation.downloadJSON {
                (let JSONDictionary) in
                let currentWeather = self.currentWeatherFromJSON(JSONDictionary)
                completion(currentWeather)
            }
        } else {
            print("Could not construct URL")
        }
    }
    
    func currentWeatherFromJSON(jsonDictionary: [String: AnyObject]?) -> CurrentWeather? {
        if let currentWeatherDictionary = jsonDictionary?["currently"] as? [String: AnyObject] {
            return CurrentWeather(weatherDictionary: currentWeatherDictionary)
        } else {
            print("json dictionary returned nil")
            return nil
        }
    }
}