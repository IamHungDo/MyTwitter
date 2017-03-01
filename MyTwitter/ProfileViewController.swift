//
//  ProfileViewController.swift
//  MyTwitter
//
//  Created by Hung Do on 2/25/17.
//  Copyright © 2017 Hung Do. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var tweetCount: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var bannerView: UIImageView!

    var user: User!
    var tweets: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Nav Bar
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 0.00/255.0, green: 172.0/255.0, blue: 237.0/255.0, alpha: 1.0)
        
        let logo = UIImage(named: "twitterlogo")
        navigationItem.titleView = UIImageView(image: logo)
        
        self.navigationController?.navigationBar.tintColor = .white
        
        //Data
        
        
        userNameLabel.text = tweets.userName
        screenNameLabel.text = "@\(tweets.screenName!)"
        taglineLabel.text = user.tagline
        profilePic.setImageWith(tweets.profileURL as URL)
        
        let followerStr = String(user.followerCount)
        followersCount.text = followerStr
        
        let followingStr = String(user.followCount)
        followingCount.text = followingStr
        
        let tweetsCount = String(user.tweetCount)
        tweetCount.text = tweetsCount
        
        if user.profileBanner != nil {
        bannerView.setImageWith(user.profileBanner as! URL)
        } else {
            
        }
        
        profilePic.layer.cornerRadius = 5
        profilePic.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
