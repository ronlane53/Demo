//
//  Strike.swift
//  DroneStrike
//
//  Created by Ron Lane on 7/24/16.
//  Copyright © 2016 Ron Lane. All rights reserved.
//

import Foundation

    // MARK: - Protocols
    protocol StrikeDelegate {
        func reloadData()
    }

    // MARK: - Trigger
    var delegate: StrikeDelegate? {
        didSet {
            Strike.loadStrikes()
        }
    }

    // MARK: - Model
    var strikes = [Strike]()

class Strike: NSObject {
    
    // MARK: - Properties
    var    number: Int?
    var   country: String?
    var      date: NSDate?
    var narrative: String?
    var      town: String?
    var  location: String?
    var    deaths: String?
    var civilians: String?
    var  children: String?
    var    target: String?
    var  latitude: String?
    var longitude: String?
    
    // MARK: - Constants
    enum Constants: String {
        case Path = "http://api.dronestre.am/data"
    }
    
    // MARK: - Methods
    class func loadStrikes() {
        let path    = Constants.Path.rawValue
        let url     = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        let task    = session.dataTaskWithURL(url!) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) in
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves)
                for dict in json["strike"] as! [[String: AnyObject]] {
                    let strike = Strike()
                    strike.number    = dict["number"   ] as? Int
                    strike.country   = dict["country"  ] as? String
                    strike.date      = dict["date"     ] as? NSDate
                    strike.narrative = dict["narrative"] as? String
                    strike.town      = dict["town"     ] as? String
                    strike.location  = dict["location" ] as? String
                    strike.deaths    = dict["deaths"   ] as? String
                    strike.civilians = dict["civilians"] as? String
                    strike.children  = dict["children" ] as? String
                    strike.target    = dict["target"   ] as? String
                    strike.latitude  = dict["lat"      ] as? String
                    strike.longitude = dict["lon"      ] as? String
                    strikes.append(strike)
                }
            } catch {
                print(error)
            }
            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                dispatch_async(dispatch_get_main_queue()) {
                    delegate!.reloadData()
                }
            }
        }
        task.resume()
    }
}
