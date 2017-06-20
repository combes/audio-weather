//
//  WeatherLoader.swift
//  AudioWeather
//
//  Created by Christopher Combes on 6/19/17.
//  Copyright © 2017 Christopher Combes. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Notification.Name {
    static let weatherNotification = Notification.Name("com.audioweather.updated")
}

class WeatherLoader {
    // Keys for user defaults
    let weatherDataKey = "com.audioweather.data"
    let weatherLocationKey = "com.audioweather.location"
    
    /// Default location
    let defaultLocation = "Austin TX"
    
    /// Allow only one refresh at a time
    private static var refreshing = false
    let internalQueue = DispatchQueue(label: "serialQueue")
    let semaphore = DispatchSemaphore(value: 1)
    
    /// Cache weather in user defaults
    var data:JSON {
        get {
            if let d = UserDefaults.standard.object(forKey: weatherDataKey) {
                let dataObject = d as! Data
                return NSKeyedUnarchiver.unarchiveObject(with: dataObject) as! JSON
            }
            return JSON.null
        }
        set {
            UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: newValue.dictionaryObject as Any), forKey: weatherDataKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    /// Location is stored in user defaults.
    var location:String {
        get {
            if let l = UserDefaults.standard.string(forKey: weatherLocationKey) {
                return l
            }
            return defaultLocation
        }
        set {
            UserDefaults.standard.set(newValue, forKey: weatherLocationKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    /// Refresh weather data and notify listeners
    func refresh() {
        internalQueue.async {
            self.semaphore.wait()
            
            if (!WeatherLoader.refreshing)
            {
                WeatherLoader.refreshing = true
                
                WeatherAPIManager().weatherForLocation(self.location, onCompletion: { (json) in
                    // Cache result
                    self.data = json
                    // Notify listeners
                    NotificationCenter.default.post(name: .weatherNotification, object: json)
                    // Allow future refresh
                    WeatherLoader.refreshing = false
                })
            }
            
            self.semaphore.signal()
        }
    }
}
