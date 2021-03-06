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
    @IBOutlet weak var locationBackground: UIImageView!
    
    var weatherObject: WeatherModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set navigation bar to transparent
        navigationController?.makeTransparent()
        
        tableView.layer.backgroundColor = UIColor.clear.cgColor
        tableView.backgroundColor = UIColor.clear
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTable), name: .weatherNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateTable()
    }
    
    // MARK: Helper methods
    func updateTable() {
        DispatchQueue.main.async {
            let data = WeatherLoader().data
            if data != JSON.null {
                self.weatherObject = WeatherModel(json: data)
                if let object = self.weatherObject {
                    let viewModel = WeatherViewModel(model: object)
                    self.locationBackground.image = viewModel.backgroundImage()
                    WeatherVoice.shared.speakForecast(object)
                }
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
            cell.configure(withDelegate: ForecastViewModel(model: forecast))
        }
        
        return cell
        
    }
}
