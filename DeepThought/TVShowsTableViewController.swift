//
//  TVShowsTableViewController.swift
//  DeepThought
//
//  Created by Dave Walls on 07/09/2015.
//  Copyright © 2015 Dave Walls. All rights reserved.
//

import UIKit

class TVShowsTableViewController: UITableViewController {

    // MARK: Properties
    var tvshows = [TVShows]()

    func loadTVShows() {
        
        let jsonUrl = "http://10.0.1.4/entertainment/tvJSON.php"
    
        let nsUrl = NSURL(string: jsonUrl)
        let data = NSData(contentsOfURL: nsUrl!)
        do {
            let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
    
            let tvshows = jsonData["tvshows"] as! [[String : AnyObject]]
    
            for tvshow in tvshows {
                let show = tvshow["show"] as! String
                let episode = tvshow["episode"] as! String
    
                print("\(show) - \(episode)")
                let tvshow = TVShows(episode: "\(episode)", show: "\(show)")!
                self.tvshows += [tvshow]
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
        
        loadTVShows()  
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
        return tvshows.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cellIdentifier = "TVShowsTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TVShowsTableViewCell
        
        // Configure the cell...
        
        // Fetches the appropriate meal for the data source layout.
        let tvshow = tvshows[indexPath.row]
        
        cell.episodeUILabel.text = tvshow.episode
        cell.showUILabel.text = tvshow.show
        
        return cell
    }
    

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
