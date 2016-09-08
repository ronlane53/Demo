//
//  MasterViewController.swift
//  DroneStrike
//
//  Created by Ron Lane on 7/24/16.
//  Copyright © 2016 Ron Lane. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
}

    // MARK: - Extensions
extension MasterViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strikes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! StrikeTableViewCell
        let strike = strikes[indexPath.row]
        cell.countryLabel.text   = strike.country
        cell.townLabel.text      = strike.town
        cell.locationLabel.text  = strike.location
        cell.targetLabel.text    = strike.target
        cell.deathsLabel.text    = strike.deaths! + " deaths recorded"
        return cell
    }
}

extension MasterViewController: StrikeDelegate {
    func reloadData() {
        self.tableView.reloadData()
    }
}

extension UILabel {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}

extension UIButton {
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(CGColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue!.CGColor
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
