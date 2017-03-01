//
//  User.swift
//  MyTwitter
//
//  Created by Hung Do on 2/12/17.
//  Copyright © 2017 Hung Do. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String?
    var screenName: String?
    var profileURL: NSURL?
    var tagline: String?
    var profileBanner: NSURL?
    var tweetCount: Int
    var followCount: Int
    var followerCount: Int
    
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        tagline = dictionary["description"] as? String
        tweetCount = dictionary["statuses_count"] as! Int
        followCount = dictionary["followers_count"] as! Int
        followerCount = dictionary["friends_count"] as! Int
        
        let profileBannerString = dictionary["profile_banner_url"] as? String as NSString?
        if let profileBannerString = profileBannerString {
            profileBanner = NSURL(string: profileBannerString as String)
        }
        
        let profileUrlString = dictionary["profile_image_url_https"] as! String as NSString?
        if let profileUrlString = profileUrlString {
            profileURL = NSURL(string: profileUrlString as String)
            
        }
    }
    
    static var _currentUser: User?
    static let userDidLogoutNotification = "UserDidLogout"

    
    class var currentUser: User? {
        get {
            if _currentUser == nil
            {
                let defaults = UserDefaults.standard
                if let userData = defaults.object(forKey: "currentUserData") as? NSData
                {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData as Data, options: [])
                    _currentUser = User(dictionary: dictionary as! NSDictionary)
                }
                
            }
            return _currentUser

        }
        
        
        set(user) {
            _currentUser = user
            let defaults = UserDefaults.standard
            
            if let user = user {
             let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
            
            defaults.synchronize()
            
        }
    }
    
    
}

