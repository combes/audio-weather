//
//  ForecastViewController.swift
//  AudioWeather
//
//  Created by Christopher Combes on 6/20/17.
//  Copyright © 2017 Christopher Combes. All rights reserved.
//

import UIKit
import SwiftyJSON

class ForecastViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var weatherObject: WeatherObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        
        tableView.layer.backgroundColor = UIColor.clear.cgColor
        tableView.backgroundColor = UIColor.clear
        
        let data = WeatherLoader().data
        if data != JSON.null {
            weatherObject = WeatherObject(json: data)
            tableView.reloadData()
        }
    }

    // MARK: UITableViewDataSource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (weatherObject?.forecast.count)!
    }
    
    // MARK: UITableViewDelegate
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ForecastTableCell
        
        if let forecast = weatherObject?.forecast[indexPath.row] {
            cell.configure(forecast: forecast)
        }
        
        return cell
        
    }
}
