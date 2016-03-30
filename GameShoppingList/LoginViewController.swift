//
//  LoginViewController.swift
//  GameShoppingList
//
//  Created by Tianbo Ji on 16/3/26.
//  Copyright © 2016年 Tianbo Ji. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController,NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var loginMessage: UILabel!
    
    //
    var defaults = NSUserDefaults.standardUserDefaults()
    var balance = 0.00
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var managedUserObject : User!
    var frc_User : NSFetchedResultsController! = nil
    
    func FetchRequest() ->NSFetchRequest{
        
        let request = NSFetchRequest(entityName: "User")
        
        request.predicate = NSPredicate(format: "name == %@" , username.text!.uppercaseString )
        //how to sort and what to query
        let sortor = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sortor]
        //        let predict = NSPredicate(format: "%K == %@","name","Sabin Tabirca")
        //        request.predicate = predict
        return request
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        password.secureTextEntry = true
        username.text = defaults.stringForKey("currentUser")!
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginBtn(sender: AnyObject) {
        if (username.text != "" && checkUsernameAndPassword()){
            loginMessage.text = ""
            defaults.setObject(username.text!.uppercaseString, forKey: "currentUser")
//            loginMessage.text = "Welcome " + defaults.stringForKey("currentUser")!
            let alertViewController = UIAlertController(title: "Welcome! " + defaults.stringForKey("currentUser")!, message: "Your cueerent balence is €" + String(balance), preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.Default){
                (action: UIAlertAction!) -> Void in
                self.performSegueWithIdentifier("login_segue", sender: self)
            }
            alertViewController.addAction(okAction)
            self.presentViewController(alertViewController, animated: true, completion: nil)
//            self.performSegueWithIdentifier("login_segue", sender: self)
        }
        else{
            loginMessage.text = "Empty username or wrong password"
        }
    }
    
    func checkUsernameAndPassword()->Bool {
        frc_User = NSFetchedResultsController(fetchRequest: FetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        frc_User.delegate = self
        do{
            
            try frc_User.performFetch()
            
        }catch{
            
            print("fetch core data error")
        }
        if frc_User.fetchedObjects != nil{
            var gameObject : [User] = []
            gameObject = frc_User.fetchedObjects! as! [User]
            if gameObject != [] && gameObject[0].password! == password.text!{
                balance = (gameObject[0].balance?.doubleValue)!
                return true
            }
            else{
                return false
            }
            
            
        }
        else{
            return false
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
