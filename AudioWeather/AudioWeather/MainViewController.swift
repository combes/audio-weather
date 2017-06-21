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
    @IBOutlet weak var windX: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Start refresh immediately
        WeatherLoader().refresh()
        
        let searchItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(showSearch))
        navigationItem.rightBarButtonItem = searchItem
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateFieldsFromNotification), name: .weatherNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        updateFieldsMainThread()
    }
    
    // MARK: UI Methods
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
        
        if !isInternetAvailable() {
            showNetworkOutage(view: self.view)
        }
    }
    
    // TODO: A View-Model is appropriate here.
    func updateFieldsMainThread() {
        let data = WeatherLoader().data
        guard data != JSON.null else {
            // Clear data fields to indicate data has not been loaded yet.
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
        
        // Rotate wind vane based on wind speed.
        // Using a fudge factor of 120 / speed which provides ample visible animation.
        self.windX.rotate360Degrees(duration: 120 / object.windSpeed)
    }
    
    // MARK: Animations
    func animateLabelColors() {
        UIView.transition(with: self.view, duration: 1.0, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            self.city.textColor = UIColor.red
            self.condition.textColor = UIColor.red
            self.temperature.textColor = UIColor.red
        }) { (completed) in
            self.city.textColor = UIColor.white
            self.condition.textColor = UIColor.white
            self.temperature.textColor = UIColor.white
        }
    }
    
    // MARK: Action methods
    func showSearch() {
        performSegue(withIdentifier: "search", sender: self)
    }

    // MARK: Helper methods
    func updateFieldsFromNotification() {
        DispatchQueue.main.async {
            self.updateFieldsMainThread()
            // Animate labels only when data is refreshed from server
            self.animateLabelColors()
        }
    }
}

