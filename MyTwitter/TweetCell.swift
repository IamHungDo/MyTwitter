//
//  TweetCell.swift
//  MyTwitter
//
//  Created by Hung Do on 2/16/17.
//  Copyright © 2017 Hung Do. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBAction func favButton(_ sender: Any) {
        
    }
    @IBAction func retweetButton(_ sender: Any) {
        
    }
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favCount: UILabel!
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
            
            let retweetStr = String(tweetsInCell.retweetCount)
            retweetCount.text = retweetStr
            let favStr = String(tweetsInCell.favoritesCount)
            favCount.text = favStr

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
