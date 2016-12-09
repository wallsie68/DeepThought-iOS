
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
    


    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        let url = NSURL(string:"https://thingspeak.com/channels/22830/feed.json?key=09IMPB7648R7T8AQ&&results=1")!
        let conf = URLSessionConfiguration.default
        let session = URLSession(configuration: conf)
        let task = session.dataTask(with: url as URL) { (data, res, error) -> Void in
            if error != nil {
                print("dataTask fail: \(error)")
                return
            }
            
//            print("\(data!)")

            let jsonText = NSString(data: data!,
                encoding: String.Encoding.ascii.rawValue)
            
            print("\(jsonText!)")
            
            let json: NSData? = jsonText!.data(using: String.Encoding.utf8.rawValue)! as NSData?
            
            do {
                let jsonData = try JSONSerialization.jsonObject(with: json! as Data, options:JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                
//                print("\(jsonData)")
                
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
            
            DispatchQueue.main.async( execute: { () -> Void in
                
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
