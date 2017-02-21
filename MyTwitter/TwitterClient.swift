//
//  TwitterClient.swift
//  MyTwitter
//
//  Created by Hung Do on 2/13/17.
//  Copyright © 2017 Hung Do. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com") as URL!, consumerKey: "7L0jVECeb0NSQwM2tDSLkexov", consumerSecret: "LeGBmYzZ2pC2QAiRpyZ9exvgHknkrb6gnPZLsdGCyZidvBb3xd")
    

    
    //Current account
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (NSError) -> ()) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let userDictionary = response as? NSDictionary
            let user = User(dictionary: userDictionary! as! Dictionary<String, Any> as NSDictionary)
            
            success(user)
            
            print("name: \(user.name)")
            print("screename: \(user.screenName)")
            print("profile url: \(user.profileURL)")
            print("description: \(user.tagline)")
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error as NSError)
        })
        
    }
    
    //Login
    var loginSuccess: (() ->())?
    var loginFailure: ((NSError) ->())?
    
    func login(success: @escaping () -> (), failure: @escaping (NSError) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        deauthorize()
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string: "mytwitter://oauth") as URL!, scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
            if requestToken != nil {
                let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\((requestToken?.token)!)")!
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            }
        }, failure: { (error) in
            print("error: \(error?.localizedDescription)")
            self.loginFailure?(error as! NSError)
        })
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification) , object: nil)
    }
    //HandleOpenUrl
    func handleOpenUrl(url: NSURL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) in
            
            self.currentAccount(success: { (user: User) -> () in
                User.currentUser = user
                self.loginSuccess?()
            }, failure: { (error: NSError) -> () in
                self.loginFailure?(error)
            })
            
            self.loginSuccess?()
            
        }, failure: { (error) in
            print("error: \(error?.localizedDescription)")
            self.loginFailure?(error as! NSError)
        })
    }
    
    
    //Hometimeline
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (NSError) ->()) {
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            success(tweets)
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error as NSError)
        })
    }
    
    func loadMoreTweets(id: Int, success: @escaping ([Tweet])-> (), failure: @escaping (NSError) -> ()){
        get("1.1/statuses/home_timeline.json?max_id=\(id)", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            
            let dictionaries  = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            success(tweets)
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error as NSError)
        })
    }
    func retweetFunction(id: Int, success: @escaping ([Tweet])-> (), failure: @escaping (NSError) -> ()) {
        
        post("1.1/statuses/retweet/\(id).json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask!, response: Any?) -> Void in
            print("success retweet")
        }) { (task: URLSessionDataTask?, error: Error!) in
            print(error.localizedDescription)
            print("I failed retweeting")
        }
    }
    

}
