//
//  ForecastTableCell.swift
//  AudioWeather
//
//  Created by Christopher Combes on 6/20/17.
//  Copyright © 2017 Christopher Combes. All rights reserved.
//

import UIKit

class ForecastTableCell: UITableViewCell {
    
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var high: UILabel!
    @IBOutlet weak var low: UILabel!
    @IBOutlet weak var condition: UILabel!    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        day.text = "--"
        high.text = "-°F"
        low.text = "-°F"
        condition.text = "--"
    }

    func configure(forecast: ForecastObject) {
        day.text = forecast.day
        high.text = String(format: "%@°F", forecast.high)
        low.text = String(format: "%@°F", forecast.low)
        condition.text = forecast.text
    }
}
