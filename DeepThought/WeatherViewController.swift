//
//  WeatherViewController.swift
//  DeepThought
//
//  Created by Dave Walls on 07/09/2015.
//  Copyright © 2015 Dave Walls. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var temperatureUILabel: UILabel!
    
    func loadWeather() -> String {
        
        let jsonUrl = "http://thingspeak.com/channels/22830/feed.json?key=09IMPB7648R7T8AQ&&results=1"
        
        let nsUrl = NSURL(string: jsonUrl)
        let data = NSData(contentsOfURL: nsUrl!)
        
        do {
            let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
            
            let vals = jsonData["feeds"] as! [[String : AnyObject]]
            
            for val in vals {
                let temperature = val["field1"] as! String
                print("Phone: \(temperature)")
                
                return ("\(temperature) \u{00B0}C")
        }
        } catch _ {
            // Error
            return ("Error")
        }
        
        return ("Error")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillEnterForeground:", name: UIApplicationWillEnterForegroundNotification, object: nil)

        temperatureUILabel.text = loadWeather()
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    func applicationWillEnterForeground(notification: NSNotification) {
        temperatureUILabel.text = loadWeather()
    }

}

