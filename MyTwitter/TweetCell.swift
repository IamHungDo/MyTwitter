//
//  TweetCell.swift
//  MyTwitter
//
//  Created by Hung Do on 2/16/17.
//  Copyright © 2017 Hung Do. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favCount: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var retweetOutlet: UIButton!
    @IBOutlet weak var favOutlet: UIButton!
    
    var retweetFlag = false
    var favFlag = false
    
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
            
            retweetOutlet.setImage(UIImage(named:"retweet-icon"), for: UIControlState.normal)
            favOutlet.setImage(UIImage(named: "favor-icon"), for: UIControlState.normal)

        }
    }
    
    @IBAction func retweetButton(_ sender: Any) {
        if retweetFlag == false {
        retweetOutlet.setImage(UIImage(named:"retweet-icon-green"), for: UIControlState.normal)
        
        TwitterClient.sharedInstance?.retweetFunction(id: tweetsInCell.id!, success: { (tweets:[Tweet]) in
            print("success")
        }, failure: { (error: NSError) in
            print("fail")
        })
        
        retweetCount.text = String(tweetsInCell.retweetCount + 1)
        retweetFlag = true
            
        } else {
        retweetOutlet.setImage(UIImage(named:"retweet-icon"), for: UIControlState.normal)
            
            TwitterClient.sharedInstance?.unRetweetFunction(id: tweetsInCell.id!, success: { (tweets:[Tweet]) in
                print("success")
            }, failure: { (error: NSError) in
                print("fail")
            })
            retweetCount.text = String(tweetsInCell.retweetCount)
            retweetFlag = false
            
        }
        
        
    }
    
    @IBAction func favButton(_ sender: Any) {
        if favFlag == false {
        favOutlet.setImage(UIImage(named:"favor-icon-red"), for: UIControlState.normal)
        
        TwitterClient.sharedInstance?.favFuction(id: tweetsInCell.id!, success: { (tweets:[Tweet]) in
            print("success")
        }, failure: { (error: NSError) in
            print("fail")
        })
            favCount.text = String(tweetsInCell.favoritesCount + 1)
            favFlag = true
            
        } else {
            favOutlet.setImage(UIImage(named:"favor-icon"), for: UIControlState.normal)
            
            TwitterClient.sharedInstance?.deFavFuction(id: tweetsInCell.id!, success: { (tweets:[Tweet]) in
                print("success")
            }, failure: { (error: NSError) in
                print("fail")
            })
            
            favCount.text = String(tweetsInCell.favoritesCount)
            favFlag = false
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
