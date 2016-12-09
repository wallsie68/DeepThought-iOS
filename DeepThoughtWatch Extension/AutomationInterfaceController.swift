//
//  AutomationInterfaceController.swift
//  DeepThought
//
//  Created by Dave Walls on 13/09/2015.
//  Copyright © 2015 Dave Walls. All rights reserved.
//

import WatchKit

class AutomationInterfaceController: WKInterfaceController {

    // MARK: Classes
    
    class Sockets: NSObject {
        
        // Properties
        var socket: String
        var status: Bool
        var on: String
        var off: String
        
        // Types
        struct PropertyKey {
            static let socketKey = "socket"
            static let statusKey = "status"
            static let onKey = "on"
            static let offKey = "off"
        }
        
        // Initialization
        init?(socket: String, status: Bool, on: String, off: String) {
            // Initialize stored properties.
            self.socket = socket
            self.status = status
            self.on = on
            self.off = off
            
            super.init()
        }
    }
    
    // MARK: Declarations
    
    @IBOutlet var AutomationTable: WKInterfaceTable!
    
    var sockets = [Sockets]()

    // MARK: Functions
    


    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()

        sockets.removeAll()
        
        let url = NSURL(string:"http://DeepThought.local/automation/socketList.php")!
        let conf = URLSessionConfiguration.default
        let session = URLSession(configuration: conf)
        let task = session.dataTask(with: url as URL) { (data, res, error) -> Void in
            if error != nil {
                print("dataTask fail: \(error))")
                return
            }
            
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions.mutableContainers ) as! NSDictionary
                
                let sockets = jsonData["sockets"] as! [[String : AnyObject]]
                
                for socket in sockets {
                    let sock = socket["socket"] as! String
                    let status = socket["status"] as! String
                    let on = socket["on"] as! String
                    let off = socket["off"] as! String
                    
                    let stat: Bool
                    if status == "1" { stat = true } else { stat = false }
                    
                    let socket = Sockets(socket: "\(sock)", status: stat, on: "\(on)", off: "\(off)")!
                    self.sockets += [socket]                    
                }
                
            } catch let error as NSError {
                print("json error: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async( execute: { () -> Void in
        
                self.AutomationTable.setNumberOfRows(self.sockets.count, withRowType: "AutomationRow")
        
                var i = 0
                for socket in self.sockets {
                    let row = self.AutomationTable.rowController(at: i) as? AutomationRow
                    row!.socketSwitch.setTitle(socket.socket)
                    row!.socketSwitch.setOn(socket.status)
                    row!.name = socket.socket
                    row!.on = socket.on
                    row!.off = socket.off
                    i = i + 1
                }
                
            })
        }
        task.resume()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()        
    }
}
