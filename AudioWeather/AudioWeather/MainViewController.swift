//
//  MainViewController.swift
//  AudioWeather
//
//  Created by Christopher Combes on 6/16/17.
//  Copyright © 2017 Christopher Combes. All rights reserved.
//

import AVFoundation
import UIKit
import SwiftyJSON
import RevealingSplashView

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
    @IBOutlet weak var locationBackground: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Start refresh immediately
        WeatherLoader().refresh()

        // Set navigation bar to transparent
        navigationController?.makeTransparent()

        let searchItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(showSearch))
        navigationItem.rightBarButtonItem = searchItem
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateFieldsFromNotification), name: .weatherNotification, object: nil)
        
        // Show splash view for snazzyness
        let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "storm")!, iconInitialSize: CGSize(width: 70, height: 70), backgroundColor: UIColor.white)
        
        self.view.addSubview(revealingSplashView)
        
        revealingSplashView.duration = 1.9
        revealingSplashView.useCustomIconColor = false
        revealingSplashView.animationType = SplashAnimationType.popAndZoomOut
        
        revealingSplashView.startAnimation(){
            self.setNeedsStatusBarAppearanceUpdate()
            print("Completed")
        }
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
    
    func updateFieldsWith(model: WeatherModel) {
        let viewModel = WeatherViewModel(model: model)
        city.text = viewModel.city
        condition.text = viewModel.conditionText
        temperature.text = viewModel.temperature
        windDirection.text = viewModel.windDirection
        windChill.text = viewModel.windChill
        windSpeed.text = viewModel.windSpeed
        sunrise.text = viewModel.sunrise
        sunset.text = viewModel.sunset        

        locationBackground.image = viewModel.backgroundImage()
        
        // Rotate wind vane based on wind speed.
        // Using a fudge factor of 120 / speed which provides ample visible animation.
        if let speedValue = Double(model.windSpeed) {
            self.windX.rotate360Degrees(duration: 120 / speedValue)
        }
    }
    
    func updateFieldsMainThread() {
        
        if !isInternetAvailable() {
            showNetworkOutage(view: self.view)
        }

        let data = WeatherLoader().data
        let model = WeatherModel(json: data)
        updateFieldsWith(model: model)
        
        WeatherVoice.shared.speakWeather(model)
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

