//
//  TVShows.swift
//  DeepThought
//
//  Created by Dave Walls on 12/09/2015.
//  Copyright © 2015 Dave Walls. All rights reserved.
//


import UIKit

class TVShows: NSObject {
    // MARK: Properties
    
    var episode: String
    var show: String
    
    // MARK: Types
    
    struct PropertyKey {
        static let episodeKey = "episode"
        static let showKey = "show"
    }
    
    // MARK: Initialization
    
    init?(episode: String, show: String) {
        // Initialize stored properties.
        self.episode = episode
        self.show = show
        
        super.init()
    }
}