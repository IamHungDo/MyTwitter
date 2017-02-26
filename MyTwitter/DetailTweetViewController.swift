//
//  DetailTweetViewController.swift
//  MyTwitter
//
//  Created by Hung Do on 2/23/17.
//  Copyright © 2017 Hung Do. All rights reserved.
//

import UIKit

class DetailTweetViewController: UIViewController {
    
    @IBOutlet weak var favOutlet: UIButton!
    @IBOutlet weak var retweetOutlet: UIButton!
    
    
    var tweets: Tweet!
    var retweetFlag = false
    var favFlag = false

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var favCount: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var profilePic: UIImageView!



    override func viewDidLoad() {
        super.viewDidLoad()
        
    userNameLabel.text = tweets.userName
    screenNameLabel.text = "@\(tweets.screenName!)"
    descriptionLabel.text = tweets.text
    timeStampLabel.text = tweets.timeStampString
    profilePic.setImageWith(tweets.profileURL as URL)
        
    let retweetStr = String(tweets.retweetCount)
        retweetCount.text = retweetStr
    let favStr = String(tweets.favoritesCount)
        favCount.text = favStr
    

    }
    
    
    @IBAction func retweetButton(_ sender: Any) {
        if retweetFlag == false {
            retweetOutlet.setImage(UIImage(named:"retweet-icon-green"), for: UIControlState.normal)
            
            TwitterClient.sharedInstance?.retweetFunction(id: tweets.id!, success: { (tweets:[Tweet]) in
                print("success")
            }, failure: { (error: NSError) in
                print("fail")
            })
            
            retweetCount.text = String(tweets.retweetCount + 1)
            retweetFlag = true
            
        } else {
            retweetOutlet.setImage(UIImage(named:"retweet-icon"), for: UIControlState.normal)
            
            TwitterClient.sharedInstance?.unRetweetFunction(id: tweets.id!, success: { (tweets:[Tweet]) in
                print("success")
            }, failure: { (error: NSError) in
                print("fail")
            })
            retweetCount.text = String(tweets.retweetCount)
            retweetFlag = false
            
        }
        

    }
    
    @IBAction func favButton(_ sender: Any) {
        if favFlag == false {
            favOutlet.setImage(UIImage(named:"favor-icon-red"), for: UIControlState.normal)
            
            TwitterClient.sharedInstance?.favFuction(id: tweets.id!, success: { (tweets:[Tweet]) in
                print("success")
            }, failure: { (error: NSError) in
                print("fail")
            })
            favCount.text = String(tweets.favoritesCount + 1)
            favFlag = true
            
        } else {
            favOutlet.setImage(UIImage(named:"favor-icon"), for: UIControlState.normal)
            
            TwitterClient.sharedInstance?.deFavFuction(id: tweets.id!, success: { (tweets:[Tweet]) in
                print("success")
            }, failure: { (error: NSError) in
                print("fail")
            })
            
            favCount.text = String(tweets.favoritesCount)
            favFlag = false
        }

    }
    
    @IBAction func replyButton(_ sender: Any) {
        
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
