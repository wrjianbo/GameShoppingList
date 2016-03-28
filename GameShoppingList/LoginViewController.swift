//
//  LoginViewController.swift
//  GameShoppingList
//
//  Created by Tianbo Ji on 16/3/26.
//  Copyright © 2016年 Tianbo Ji. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var loginMessage: UILabel!
    
    //
    var defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        password.secureTextEntry = true
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginBtn(sender: AnyObject) {
        if (password.text == "a" && username.text != ""){
            loginMessage.text = ""
            defaults.setObject(username.text!.uppercaseString, forKey: "currentUser")
            loginMessage.text = "Welcome " + defaults.stringForKey("currentUser")!
            self.performSegueWithIdentifier("login_segue", sender: self)
        }
        else{
            loginMessage.text = "Empty username or wrong password"
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
