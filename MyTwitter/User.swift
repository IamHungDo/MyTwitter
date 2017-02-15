//
//  User.swift
//  MyTwitter
//
//  Created by Hung Do on 2/12/17.
//  Copyright © 2017 Hung Do. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: NSString?
    var screenName: NSString?
    var profileURL: NSURL?
    var tagline: NSString?
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as! String as NSString?
        screenName = dictionary["screen_name"] as! String as NSString?
        tagline = dictionary["description"] as! String as NSString?
        
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
                if let userData = defaults.object(forKey: "currentUserData") as? Data
                {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: [])
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
                defaults.set(nil, forKey: "currentUserData")
            }
            
            defaults.set(user, forKey: "currentUser")
            defaults.synchronize()
            
        }
    }
    
    
}

