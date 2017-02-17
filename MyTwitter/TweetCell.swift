//
//  TweetCell.swift
//  MyTwitter
//
//  Created by Hung Do on 2/16/17.
//  Copyright © 2017 Hung Do. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    
    @IBOutlet weak var descriptionLabel: UILabel!

    var tweetsInCell: Tweet! {
        didSet {
            descriptionLabel.text = tweetsInCell.text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
