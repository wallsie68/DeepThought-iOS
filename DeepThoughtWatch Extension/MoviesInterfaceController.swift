//
//  MoviesInterfaceController.swift
//  DeepThought
//
//  Created by Dave Walls on 14/09/2015.
//  Copyright © 2015 Dave Walls. All rights reserved.
//

import WatchKit

class MoviesInterfaceController: WKInterfaceController {

    // MARK: Classes
    
    class Movies: NSObject {
        
        // Properties
    
        var movie: String
    
        // Types
        
        struct PropertyKey {
            static let movieKey = "movie"
        }
        
        // Initialization
        
        init?(movie: String) {
            // Initialize stored properties.
            self.movie = movie
    
            super.init()
        }
    }
    
    // MARK: Declarations
    
    @IBOutlet var MoviesTable: WKInterfaceTable!

    var movies = [Movies]()
    
    // MARK: Functions
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        movies.removeAll()

        let url = NSURL(string:"http://10.0.1.4/entertainment/movieJSON.php")!
        let conf = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: conf)
        let task = session.dataTaskWithURL(url) { (data, res, error) -> Void in
            if let e = error {
                print("dataTaskWithURL fail: \(e.debugDescription)")
                return
            }
            
            do {
                let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary

                let movies = jsonData["movies"] as! [[String : AnyObject]]
                
                for movie in movies {
                    let movie = movie["movie"] as! String
                    
                    let mov = Movies(movie: "\(movie)")!
                    self.movies += [mov]
                }
                
            } catch let error as NSError {
                print("json error: \(error.localizedDescription)")
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                self.MoviesTable.setNumberOfRows(self.movies.count, withRowType: "MovieRow")
                
                var i = 0
                for movie in self.movies {
                    let row = self.MoviesTable.rowControllerAtIndex(i) as? MovieRow
                    row!.movieLabel.setText(movie.movie)
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
