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

    func configure(withDelegate delegate: ForecastModelProtocol)
    {
        day.text = delegate.day
        high.text = delegate.high
        low.text = delegate.low
        condition.text = delegate.conditionText
    }
}
