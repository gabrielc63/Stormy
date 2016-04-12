//
//  ViewController.swift
//  Stormy
//
//  Created by Gabriel Coronel on 10/11/15.
//  Copyright © 2015 Gabriel Coronel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
  @IBOutlet weak var currentTemperatureLabel: UILabel!
  @IBOutlet weak var currentHumidityLabel: UILabel!
  @IBOutlet weak var currentPrecipitationLabel: UILabel!
  @IBOutlet weak var currentWeatherIcon: UIImageView!
  @IBOutlet weak var currentWeatherSummary: UILabel!
  @IBOutlet weak var refreshButton: UIButton!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
  private var forecastAPIKey = ""
  let coordinate: (lat: Double, long: Double) = (-27.4806,-58.8341)
    

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    retrieveWeather()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return .LightContent
  }
  
  func retrieveWeather() {
    let path = NSBundle.mainBundle().pathForResource("keys", ofType: "plist")
    let dict = NSDictionary(contentsOfFile: path!)
    forecastAPIKey = dict?.objectForKey("clientKey") as! String
    
    let forecastService = ForecastService(APIKey: forecastAPIKey)
    forecastService.getForecast(coordinate.lat, long: coordinate.long) {
      (let currently) in
        if let currentWeather = currently {
          dispatch_async(dispatch_get_main_queue()) {
            if let temperature = currentWeather.temperature {
              self.currentTemperatureLabel.text = "\(temperature)º"
            }
          
            if let humidity = currentWeather.humidity {
              self.currentHumidityLabel.text = "\(humidity)%"
            }
          
            if let precipitation = currentWeather.precipProbability {
              self.currentPrecipitationLabel.text = "\(precipitation)%"
            }
          
            if let icon = currentWeather.icon {
              self.currentWeatherIcon.image = icon
            }
          
            if let summary = currentWeather.summary {
              self.currentWeatherSummary.text = summary
            }
            
            self.toggleRefreshAnimation(false)
          }
        }
    
    }

  }
  
  @IBAction func refreshWeather() {
    toggleRefreshAnimation(true)
    retrieveWeather()
  }
  
  func toggleRefreshAnimation(on: Bool) {
    refreshButton.hidden = on
    if on {
      activityIndicator.startAnimating()
    } else {
      activityIndicator.stopAnimating()
    }
    
  }

}

