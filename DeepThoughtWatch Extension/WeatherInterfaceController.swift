//
//  InterfaceController.swift
//  DeepThoughtWatch Extension
//
//  Created by Dave Walls on 11/09/2015.
//  Copyright © 2015 Dave Walls. All rights reserved.
//

import WatchKit

class WeatherInterfaceController: WKInterfaceController {

    var temp = "\u{00B0}C"
    
    @IBOutlet var TemperatureWKInterfaceLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        let url = NSURL(string:"http://thingspeak.com/channels/22830/feed.json?key=09IMPB7648R7T8AQ&&results=1")!
        let conf = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: conf)
        let task = session.dataTaskWithURL(url) { (data, res, error) -> Void in
            if let e = error {
                print("dataTaskWithURL fail: \(e.debugDescription)")
                return
            }
            
            print("\(data!)")
            
            do {
                let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers) as! NSDictionary
                
                print("\(jsonData)")
                
                let vals = jsonData["feeds"] as! [[String : AnyObject]]
                
                for val in vals {
                    let temperature = val["field1"] as! String
                    self.temp = "\(temperature)\u{00B0}C"
                }
                
            } catch let error as NSError {
                print("json error: \(error.localizedDescription)")
                print("json error: \(error)")
                self.temp = "Error"
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                self.TemperatureWKInterfaceLabel.setText(self.temp)
                
            })
        }
        task.resume()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
