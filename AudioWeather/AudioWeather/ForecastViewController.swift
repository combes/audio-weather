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
        
        updateTable()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTable), name: .weatherNotification, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func updateTable() {
        DispatchQueue.main.async {
            let data = WeatherLoader().data
            if data != JSON.null {
                self.weatherObject = WeatherObject(json: data)
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: UITableViewDataSource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let object = weatherObject {
            return object.forecast.count
        }
        return 0
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
