//
//  TweetsViewController.swift
//  MyTwitter
//
//  Created by Hung Do on 2/13/17.
//  Copyright © 2017 Hung Do. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    @IBAction func composeButton(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Compose") as! ComposeViewController
        
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    
    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet]!
    var isMoreDataLoading = false
    var loadingMoreView:InfiniteScrollActivityView?
    var id: Int!
    
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()
        
        //Nav Bar
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 0.00/255.0, green: 172.0/255.0, blue: 237.0/255.0, alpha: 1.0)
        
        let logo = UIImage(named: "twitterlogo")
        navigationItem.titleView = UIImageView(image: logo)
        
        //Refresh function
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(TweetsViewController.refreshControlAction(refreshControl:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        //Set up infinite scroll
        
        let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.isHidden = true
        tableView.addSubview(loadingMoreView!)
        
        var insets = tableView.contentInset;
        insets.bottom += InfiniteScrollActivityView.defaultHeight;
        tableView.contentInset = insets
        
        
        
        //Home timeline
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
        cell.selectionStyle = .none
        
        return cell
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    //View Did Scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !isMoreDataLoading {
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                
                isMoreDataLoading = true
                
                let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                
                self.id = self.tweets[self.tweets.count - 1].id!
                
                loadMoreData()
            }
        }
        
    }
    
    func loadMoreData() {
        
        TwitterClient.sharedInstance?.loadMoreTweets(id: id, success: { (tweets: [Tweet]) in
            
            for tweet in tweets {
                self.tweets?.append(tweet)
                
            }
            self.loadingMoreView!.stopAnimating()
            self.isMoreDataLoading = false
            self.tableView.reloadData()
            
        }, failure: {
            
            (error: Error) in
            
            print(error)
        })
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "tweetToDetail") {
            
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            let tweetsData = tweets[(indexPath?.row)!]
            
            let detailViewController = segue.destination as! DetailTweetViewController
            
            detailViewController.tweets = tweetsData
            
        }
        
        
        
    }
    
}
