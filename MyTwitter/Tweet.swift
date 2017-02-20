//
//  Tweet.swift
//  MyTwitter
//
//  Created by Hung Do on 2/12/17.
//  Copyright © 2017 Hung Do. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: String?
    var timeStampString: String?
    var timeStamp: Date?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var userName: String?
    var screenName: String?
    var user: User?
    var profileURL: NSURL!
    
    
    
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        userName = user?.name
        profileURL = user?.profileURL
        screenName = user?.screenName
        
        
        
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
    
        timeStampString = dictionary["created_at"] as? String
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timeStamp = formatter.date(from: timeStampString!)
            timeStampString = formatter.string(from: timeStamp!)

        
    }
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
            
        }
        return tweets
}

}
