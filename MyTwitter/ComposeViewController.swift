//
//  ComposeViewController.swift
//  MyTwitter
//
//  Created by Hung Do on 2/25/17.
//  Copyright © 2017 Hung Do. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {
    

    @IBOutlet weak var onCancel: UIBarButtonItem!
    @IBOutlet weak var tweetOutlet: UIButton!

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var tweetText: UITextView!
    
    var tweets: Tweet!
    var reply: Bool?

    var editTextField = UITapGestureRecognizer()
    var endEdit = UITapGestureRecognizer()
    
    @IBAction func tweetButton(_ sender: Any) {
        let tweetStatus = tweetText.text
        
        TwitterClient.sharedInstance?.postTweetFunction(statusText: tweetStatus!)
        dismiss(animated: true, completion: nil)
        
    
    }
    
    @IBAction func exitTweet(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetText.delegate = self
        
        //Reply
        

        
        
        
        //NavBar
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 0.00/255.0, green: 172.0/255.0, blue: 237.0/255.0, alpha: 1.0)
        
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        //Button
        tweetOutlet.layer.cornerRadius = 7; // this value vary as per your desire
        tweetOutlet.clipsToBounds = true;
        
        let logo = UIImage(named: "twitterlogo")
        navigationItem.titleView = UIImageView(image: logo)
        
        editTextField.addTarget(self, action: #selector(ComposeViewController.textViewDidBeginEditing))
        tweetText.addGestureRecognizer(editTextField)
        
        endEdit.addTarget(self, action: #selector(ComposeViewController.textViewDidEndEditing))
        self.view.addGestureRecognizer(endEdit)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textViewDidBeginEditing() {

        
        tweetText.becomeFirstResponder()
        tweetText.text = nil
        tweetText.textColor = UIColor.black
        
    }
    
    func textViewDidEndEditing() {
        self.view.endEditing(true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tweetText.setContentOffset(CGPoint.zero, animated: false)
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
