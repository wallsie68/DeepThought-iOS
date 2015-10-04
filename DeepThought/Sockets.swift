//
//  Sockets.swift
//  DeepThought
//
//  Created by Dave Walls on 20/09/2015.
//  Copyright © 2015 Dave Walls. All rights reserved.
//

import UIKit

class Sockets: NSObject {

    // MARK: Properties
    var socket: String
    var status: Bool
    var on: String
    var off: String
    
    // MARK: Types
    struct PropertyKey {
        static let socketKey = "socket"
        static let statusKey = "status"
        static let onKey = "on"
        static let offKey = "off"
    }
    
    // MARK: Initialization
    init?(socket: String, status: Bool, on: String, off: String) {
        // Initialize stored properties.
        self.socket = socket
        self.status = status
        self.on = on
        self.off = off
        
        super.init()
    }
}