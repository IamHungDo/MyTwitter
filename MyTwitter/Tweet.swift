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
    var timeStamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        let timestampString = dictionary["created_at"] as? String as NSString?

        
        if let timestampString = timestampString {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        timeStamp = formatter.date(from: timestampString as String) as NSDate?
        }
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
