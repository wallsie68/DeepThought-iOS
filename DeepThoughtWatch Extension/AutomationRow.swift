//
//  AutomationRow.swift
//  DeepThought
//
//  Created by Dave Walls on 13/09/2015.
//  Copyright © 2015 Dave Walls. All rights reserved.
//

import WatchKit

class AutomationRow: NSObject {
    
    @IBOutlet var socketSwitch: WKInterfaceSwitch!
    
    var name: String!
    var on: String!
    var off: String!
    
    @IBAction func socketAction(value: Bool) {
        
//        print("Switch \(name) - \(on) - \(off) - \(value)")
        
        let jsonUrl: String!
        if value {
            jsonUrl = "http://DeepThought.local/automation/power.php?e=" + on
        } else {
            jsonUrl = "http://DeepThought.local/automation/power.php?e=" + off
        }
        
        let nsUrl = NSURL(string: jsonUrl)
        
//        let data = NSData(contentsOfURL: nsUrl!)
//        do {
//            try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
//        } catch _ {
            // Error
//        }
        
        
        // Asynchronous
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(nsUrl!, completionHandler: {data, response, error -> Void in
            if(error != nil) {
                // If there is an error in the web request, print it to the console
                print(error!.localizedDescription)
            }
            
            //            do {
            //                try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
            //            } catch _ {
            // Error
            //            }
        })
        
        // The task is just an object with all these properties set
        // In order to actually make the web request, we need to "resume"
        task.resume()

    }
    
}