//
//  SocketsTableViewCell.swift
//  DeepThought
//
//  Created by Dave Walls on 20/09/2015.
//  Copyright © 2015 Dave Walls. All rights reserved.
//

import UIKit

class SocketsTableViewCell: UITableViewCell {

    @IBOutlet weak var socketLabel: UILabel!
    @IBOutlet weak var socketSwitch: UISwitch!
    
    var name: String!
    var on: String!
    var off: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func socketSwitchAction(_ sender: UISwitch) {
        
        let value: Bool = sender.isOn
        
        print("Switch \(name) - \(on) - \(off) - \(value)")
        
        let jsonUrl: String!
        
        if value {
            jsonUrl = "http://DeepThought.local/automation/power.php?e=" + on
        } else {
            jsonUrl = "http://DeepThought.local/automation/power.php?e=" + off
        }
        
        let nsUrl = URL(string: jsonUrl)
        
        // Synchronous

//        let data = NSData(contentsOfURL: nsUrl!)
        
//        do {
//            try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
//        } catch _ {
//            // Error
//        }

        // Asynchronous
        
        let session = URLSession.shared
        let task = session.dataTask(with: nsUrl!, completionHandler: {data, response, error -> Void in
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
