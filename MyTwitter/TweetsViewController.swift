//
//  TweetsViewController.swift
//  MyTwitter
//
//  Created by Hung Do on 2/13/17.
//  Copyright © 2017 Hung Do. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    }
    @IBOutlet weak var tableView: UITableView!

    var tweets: [Tweet]!
    
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()
        
        //Nav Bar
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 0.00/255.0, green: 172.0/255.0, blue: 237.0/255.0, alpha: 1.0)
        
        let logo = UIImage(named: "twitterlogo")
        navigationItem.titleView = UIImageView(image: logo)
        
        
        

        
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            
            for tweet in tweets {
                print(tweet.text!)
            }
            self.tableView.reloadData()

            
        }, failure: { (error: NSError) in
            print(error.localizedDescription)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.tweets != nil {
        return self.tweets.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        cell.tweetsInCell = tweets[indexPath.row]
        return cell
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
