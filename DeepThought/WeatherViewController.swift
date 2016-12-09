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
        
        let nsUrl = URL(string: jsonUrl)
        let data = try? Data(contentsOf: nsUrl!)
        
        do {
            let jsonData = try JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions.mutableContainers ) as! NSDictionary
            
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(UIApplicationDelegate.applicationWillEnterForeground(_:)), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)

        temperatureUILabel.text = loadWeather()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func applicationWillEnterForeground(_ notification: Notification) {
        temperatureUILabel.text = loadWeather()
    }

}

