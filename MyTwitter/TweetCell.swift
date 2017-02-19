//
//  TweetCell.swift
//  MyTwitter
//
//  Created by Hung Do on 2/16/17.
//  Copyright © 2017 Hung Do. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    
    var tweetsInCell: Tweet! {
        didSet {
            descriptionLabel.text = tweetsInCell.text
            userNameLabel.text = tweetsInCell.userName
            profilePic.setImageWith(tweetsInCell.profileURL as URL)
            screenNameLabel.text = "@\(tweetsInCell.screenName!)"
            timeStampLabel.text = "· \(tweetsInCell.timeStampString!)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profilePic.layer.cornerRadius = 5
        profilePic.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
