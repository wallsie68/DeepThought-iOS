//
//  SocketsTableViewController.swift
//  DeepThought
//
//  Created by Dave Walls on 20/09/2015.
//  Copyright © 2015 Dave Walls. All rights reserved.
//

import UIKit

class SocketsTableViewController: UITableViewController {

    // MARK: Properties
    var sockets = [Sockets]()
    
    func loadSockets() {
        
        let jsonUrl = "http://DeepThought.local/automation/socketList.php"
        
        let nsUrl = NSURL(string: jsonUrl)
        let data = NSData(contentsOfURL: nsUrl!)
        do {
            let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
            
            let sockets = jsonData["sockets"] as! [[String : AnyObject]]
            
            for socket in sockets {
                let name = socket["socket"] as! String
                let status = socket["status"] as! String
                let on = socket["on"] as! String
                let off = socket["off"] as! String
                
                print("\(name) - \(status) - \(on) - \(off)")
                
                let stat: Bool
                if status == "1" { stat = true } else { stat = false }
                
                let socket = Sockets(socket: "\(name)", status: stat, on: "\(on)", off: "\(off)")!
                self.sockets += [socket]
            }
            
        } catch _ {
            // Error
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

        loadSockets()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sockets.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cellIdentifier = "SocketsTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! SocketsTableViewCell
        
        // Configure the cell...
        
        let socket = sockets[indexPath.row]
        
        cell.socketLabel.text = socket.socket
        cell.socketSwitch.setOn(socket.status, animated: true)
        
        cell.on = socket.on
        cell.off = socket.off
        cell.name = socket.socket
        
        return cell    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
