//
//  Details.swift
//  GameShoppingList
//
//  Created by Tianbo Ji on 16/3/26.
//  Copyright © 2016年 Tianbo Ji. All rights reserved.
//

import UIKit

class Details: UIViewController {
    @IBOutlet weak var gName: UILabel!
    @IBOutlet weak var gType: UILabel!
    @IBOutlet weak var gPrice: UILabel!
    @IBOutlet weak var gPlatform: UILabel!
    @IBOutlet weak var gDor: UILabel!
    
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dislikeLabel: UILabel!
    @IBOutlet weak var dislikeButton: UIButton!
    
    
    @IBAction func openwebBtn(sender: UIButton) {
        
    }
    
    @IBAction func logoutBtn(sender: AnyObject) {
        self.performSegueWithIdentifier("logout_segue", sender: self)
    }
    @IBOutlet weak var likeButton: UIButton!
    var defaults = NSUserDefaults.standardUserDefaults()
    var likeKey : String!
    var dislikeKey : String!
    var userLike : String!
    var userDislike : String!
    var game : Game!
    
    override func viewWillAppear(animated: Bool) {
        // game is push
        
        //setup the outlets
        if game != nil{
            gName.text = game.name
            gType.text = game.type
            gPrice.text = game.price
            gPlatform.text = game.platform
            gDor.text = game.dor
            likeKey = game.name + "LikeKey"
            dislikeKey = game.name + "DislikeKey"
            userLike = defaults.stringForKey("currentUser")! + game.name + "Like"
            userDislike = defaults.stringForKey("currentUser")! + game.name + "Dislike"
            likeLabel.text = String(defaults.integerForKey(likeKey))
            dislikeLabel.text = String(defaults.integerForKey(dislikeKey))
            if(defaults.boolForKey(userLike)){
                likeButton.setTitleColor(UIColor.redColor(),forState: .Normal)
            }
            if(defaults.boolForKey(userDislike)){
                dislikeButton.setTitleColor(UIColor.redColor(),forState: .Normal)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "User:'" + defaults.stringForKey("currentUser")! + "'"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "back", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        let likeTapGesture = UITapGestureRecognizer(target: self, action: "likeTap:")
        let likeLongGesture = UILongPressGestureRecognizer(target: self, action: "likeLongPress:")
        let dislikeTapGesture = UITapGestureRecognizer(target: self, action: "dislikeTap:")
        let dislikeLongGesture = UILongPressGestureRecognizer(target: self, action: "dislikeLongPress:")
        likeTapGesture.numberOfTapsRequired = 1
        likeLongGesture.minimumPressDuration = 1.5
        dislikeTapGesture.numberOfTapsRequired = 1
        dislikeLongGesture.minimumPressDuration = 1.5
        likeButton.addGestureRecognizer(likeTapGesture)
        likeButton.addGestureRecognizer(likeLongGesture)
        dislikeButton.addGestureRecognizer(dislikeTapGesture)
        dislikeButton.addGestureRecognizer(dislikeLongGesture)
        
        
    }
    func likeTap(sender: UITapGestureRecognizer) {
        if(sender.state == UIGestureRecognizerState.Ended && !(defaults.boolForKey(userLike) || defaults.boolForKey(userDislike)) ){
            likeButton.setTitleColor(UIColor.redColor(),forState: .Normal)
            defaults.setBool(true, forKey: userLike)
            defaults.setInteger(defaults.integerForKey(likeKey) + 1, forKey: likeKey)
            likeLabel.text = String(defaults.integerForKey(likeKey))
        }
    }
    
    func likeLongPress(sender : UILongPressGestureRecognizer) {
        if(sender.state == UIGestureRecognizerState.Began && defaults.boolForKey(userLike)){
            likeButton.setTitleColor(UIColor.blueColor(),forState: .Normal)
            defaults.setBool(false, forKey: userLike)
            defaults.setInteger(defaults.integerForKey(likeKey) - 1, forKey: likeKey)
            likeLabel.text = String(defaults.integerForKey(likeKey))
        }
    }
    func dislikeTap(sender: UITapGestureRecognizer) {
        if(sender.state == UIGestureRecognizerState.Ended && !(defaults.boolForKey(userLike) || defaults.boolForKey(userDislike))){
            dislikeButton.setTitleColor(UIColor.redColor(),forState: .Normal)
            defaults.setBool(true, forKey: userDislike)
            defaults.setInteger(defaults.integerForKey(dislikeKey) + 1, forKey: dislikeKey)
            dislikeLabel.text = String(defaults.integerForKey(dislikeKey))
        }
    }
    
    func dislikeLongPress(sender : UILongPressGestureRecognizer) {
        if(sender.state == UIGestureRecognizerState.Began && defaults.boolForKey(userDislike)){
            dislikeButton.setTitleColor(UIColor.blueColor(),forState: .Normal)
            defaults.setBool(false, forKey: userDislike)
            defaults.setInteger(defaults.integerForKey(dislikeKey) - 1, forKey: dislikeKey)
            dislikeLabel.text = String(defaults.integerForKey(dislikeKey))
        }
    }
    
    //    @IBAction func likeButton(sender: UIButton) {
    //        defaults.setInteger(defaults.integerForKey(likeKey) + 1, forKey: likeKey)
    //        likeLabel.text = String(defaults.integerForKey(likeKey))
    //    }
    //    @IBAction func dislikeButton(sender: UIButton) {
    //
    //    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "web_segue"){
            let controller = segue.destinationViewController as! WebViewController
            controller.webUrl = game.url
        }
        //push data
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}