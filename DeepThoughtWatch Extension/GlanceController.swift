//
//  GlanceController.swift
//  DeepThoughtWatch Extension
//
//  Created by Dave Walls on 11/09/2015.
//  Copyright © 2015 Dave Walls. All rights reserved.
//

import WatchKit

class GlanceController: WKInterfaceController {

    var temp = "\u{00B0}C"
    var temp2 = "\u{00B0}C"
 
    @IBOutlet var TemperatureWKInterfaceLabel: WKInterfaceLabel!
    @IBOutlet var TemperatureWKInterfaceLabel2: WKInterfaceLabel!
    
    func loadWeather() {
        let jsonUrl = "http://thingspeak.com/channels/22830/feed.json?key=09IMPB7648R7T8AQ&&results=1"
        
        let nsUrl = NSURL(string: jsonUrl)
        let data = NSData(contentsOfURL: nsUrl!)
        
        do {
            let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
            
            let vals = jsonData["feeds"] as! [[String : AnyObject]]
            
            for val in vals {
                let temperature = val["field1"] as! String
//                print("Local: \(temperature)")
                
                temp = "\(temperature)"
            }
            
        } catch _ {
            // Error
        }
    }

    func loadWeather2() {
        let jsonUrl = "http://api.openweathermap.org/data/2.5/weather?q=wendover,uk"
        
        let nsUrl = NSURL(string: jsonUrl)
        let data = NSData(contentsOfURL: nsUrl!)
        
        do {
            let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
            
            let val = jsonData["main"] as! NSDictionary
            
//            let temperature = val["temp"]
            var temperature = val["temp"] as! Double
            temperature = temperature - 273.15
//            print("API: \(temperature)")
            let temp3 = NSString(format: "%.1f", temperature)

            temp2 = "\(temp3)"
            
        } catch _ {
            // Error
        }
    }
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    
//        loadWeather()
//        loadWeather2()
        
        TemperatureWKInterfaceLabel.setText("\(temp)\u{00B0}C")
        TemperatureWKInterfaceLabel2.setText("\(temp2)\u{00B0}C")
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
