//
//  TVShowsInterfaceController.swift
//  DeepThought
//
//  Created by Dave Walls on 12/09/2015.
//  Copyright © 2015 Dave Walls. All rights reserved.
//

import WatchKit

class TVShowsInterfaceController: WKInterfaceController {

    // MARK: Classes

    class TVShows: NSObject {
        
        // Properties
        
        var episode: String
        var show: String
        
        // Types
        
        struct PropertyKey {
            static let episodeKey = "episode"
            static let showKey = "show"
        }
        
        // Initialization
        
        init?(episode: String, show: String) {
            // Initialize stored properties.
            self.episode = episode
            self.show = show
            
            super.init()
        }
    }
    
    // MARK: Declarations
    
    @IBOutlet var TVShowTable: WKInterfaceTable!

    var tvshows = [TVShows]()
    
    // MARK: Functions
    

    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        tvshows.removeAll()
        
        let url = NSURL(string:"http://10.0.1.4/entertainment/tvJSON.php")!
        let conf = URLSessionConfiguration.default
        let session = URLSession(configuration: conf)
        let task = session.dataTask(with: url as URL) { (data, res, error) -> Void in
            if error != nil {
                print("dataTask fail: \(error)")
                return
            }
            
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions.mutableContainers ) as! NSDictionary
                
                let tvshows = jsonData["tvshows"] as! [[String : AnyObject]]
                
                for tvshow in tvshows {
                    let show = tvshow["show"] as! String
                    let episode = tvshow["episode"] as! String
                    
                    let tvshow = TVShows(episode: "\(episode)", show: "\(show)")!
                    self.tvshows += [tvshow]

                }
                
            } catch let error as NSError {
                print("json error: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async( execute: { () -> Void in
                
                self.TVShowTable.setNumberOfRows(self.tvshows.count, withRowType: "TVShowRow")
                
                var i = 0
                for tvshow in self.tvshows {
                    let row = self.TVShowTable.rowController(at: i) as? TVShowRow
                    row!.episodeLabel.setText(tvshow.episode)
                    row!.showLabel.setText(tvshow.show)
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
