//
//  TVShowsTableViewCell.swift
//  DeepThought
//
//  Created by Dave Walls on 12/09/2015.
//  Copyright © 2015 Dave Walls. All rights reserved.
//

import UIKit

class TVShowsTableViewCell: UITableViewCell {

    // MARK: Properties
    @IBOutlet weak var episodeUILabel: UILabel!
    @IBOutlet weak var showUILabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
