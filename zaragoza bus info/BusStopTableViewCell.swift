//
//  BusStopTableViewCell.swift
//  zaragoza bus info
//
//  Created by David Henner on 05/01/2017.
//  Copyright © 2017 david. All rights reserved.
//

import Foundation
import UIKit

class BusStopTableViewCell : UITableViewCell {
    var busStop: BusStop? {
        didSet {
            listenEstimates()
        }
    }
    
    @IBOutlet weak var stopNumber: UILabel!
    @IBOutlet weak var stopTitle: UILabel!
    
    @IBOutlet weak var stack1: UIStackView!
    @IBOutlet weak var lineNb1: UILabel!
    @IBOutlet weak var direction1: UILabel!
    @IBOutlet weak var estimate1: UILabel!
    
    @IBOutlet weak var stack2: UIStackView!
    @IBOutlet weak var lineNb2: UILabel!
    @IBOutlet weak var direction2: UILabel!
    @IBOutlet weak var estimate2: UILabel!
    
    @IBOutlet weak var mapView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.stopNumber.layer.masksToBounds = true
        self.stopNumber.layer.cornerRadius = 8.0
    }

    // Checks if the estimates loaded
    func listenEstimates() {
        if let estimates = busStop?.estimates {
            if !estimates.isEmpty {
                DispatchQueue.main.async {
                    self.stack1.isHidden = self.setEstimate(lineNb: self.lineNb1, direction: self.direction1, estimatedTime: self.estimate1, estimate: estimates[0])
                    if (estimates.count > 1) {
                        self.stack2.isHidden = self.setEstimate(lineNb: self.lineNb2, direction: self.direction2, estimatedTime: self.estimate2, estimate: estimates[1])
                    }
                    else {
                        self.stack2.isHidden = true
                    }
                }
            }
            else {
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                    self.listenEstimates()
                })
            }
        }
        else {
            stack1.isHidden = true
            stack2.isHidden = true
        }
    }
    
    // Sets the labels for an estimate
    func setEstimate(lineNb: UILabel, direction: UILabel, estimatedTime: UILabel, estimate: Estimate) -> Bool{
        if let line = estimate.line, let dir = estimate.direction, let time = estimate.estimate {
            lineNb.text = line
            
            direction.text = dir
            
            if (time <= 10) {
                estimatedTime.textColor = UIColor.init(red: 0, green: 153/255, blue: 0, alpha: 1)
            }
            else if (time <= 20) {
                estimatedTime.textColor = UIColor.orange
            }
            else {
                estimatedTime.textColor = UIColor.red
            }
            estimatedTime.text = String(time)
            return false
        }
        else {
            return true
        }
    }
}
