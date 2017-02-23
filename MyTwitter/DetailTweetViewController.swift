//
//  DetailTweetViewController.swift
//  MyTwitter
//
//  Created by Hung Do on 2/23/17.
//  Copyright © 2017 Hung Do. All rights reserved.
//

import UIKit



class DetailTweetViewController: UIViewController {
    
    
    var tweets: Tweet!

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var favCount: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    @IBAction func replyButton(_ sender: Any) {
    }

    @IBAction func favButton(_ sender: Any) {
        
    }
    @IBAction func retweetButton(_ sender: Any) {
    }
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
