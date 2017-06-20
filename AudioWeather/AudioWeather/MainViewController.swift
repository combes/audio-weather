//
//  MainViewController.swift
//  AudioWeather
//
//  Created by Christopher Combes on 6/16/17.
//  Copyright © 2017 Christopher Combes. All rights reserved.
//

import UIKit
import SwiftyJSON

class MainViewController: UIViewController {

    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var windDirection: UILabel!
    @IBOutlet weak var windChill: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        let data = WeatherLoader().data
        if data == JSON.null {
            // Clear data fields to indicate data has not been loaded yet.
            clearFields()
        } else {
            // Update data fields with most current data
            updateFields()
        }
        
        WeatherLoader().refresh()
        
        let searchItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(showSearch))
        navigationItem.rightBarButtonItem = searchItem
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateFields), name: .weatherNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // TODO: A View-Model is appropriate here.
    func clearFields() {
        city.text = "--"
        condition.text = "--"
        temperature.text = "-°F"
        windDirection.text = "-°"
        windChill.text = "-°"
        windSpeed.text = "- mph"
        sunrise.text = "-- am"
        sunset.text = "-- pm"
    }
    
    // TODO: A View-Model is appropriate here.
    func updateFieldsMainThread() {
        let data = WeatherLoader().data
        guard data != JSON.null else {
            clearFields()
            return
        }
        
        guard let object = WeatherObject(json: data) else {
            clearFields()
            return
        }
        
        city.text = object.city
        condition.text = object.conditionText
        temperature.text = String(format: "%@°%@", object.temperature, object.temperatureUnit)
        windDirection.text = String(format: "%@°", object.windDirection)
        windChill.text = String(format: "%@°%@", object.windChill, object.temperatureUnit)
        windSpeed.text = String(format: "%.0f %@", object.windSpeed, object.speedUnit)
        sunrise.text = object.sunrise
        sunset.text = object.sunset
    }
    
    // MARK: Action methods
    func showSearch() {
        performSegue(withIdentifier: "search", sender: self)
    }

    // MARK: Helper methods
    func updateFields() {
        DispatchQueue.main.async {
            self.updateFieldsMainThread()
        }
    }
}

