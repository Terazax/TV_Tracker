//
//  SeasonTableViewCell.swift
//  TV Tracker App
//
//  Created by Michael Thomsen on 1/20/17.
//  Copyright © 2017 Michael Thomsen. All rights reserved.
//

import UIKit



class SeasonTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    
    @IBOutlet weak var seasonLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

