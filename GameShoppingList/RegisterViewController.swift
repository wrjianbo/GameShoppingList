//
//  RegisterViewController.swift
//  GameShoppingList
//
//  Created by Tianbo Ji on 16/3/30.
//  Copyright © 2016年 Tianbo Ji. All rights reserved.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController,NSFetchedResultsControllerDelegate {

    
    @IBOutlet weak var nameLabel: UITextField!
    
    @IBOutlet weak var passwordLabel: UITextField!
    
    @IBOutlet weak var repeatLabel: UITextField!
    
    @IBAction func registerBtn(sender: AnyObject) {
        if checkPassword()&&checkUsername(){
            
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
                if gameObject != []{
                    let alertViewController = UIAlertController(title: "User Exist", message: "rename", preferredStyle: .Alert)
                    let okAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.Default){
                        (action: UIAlertAction!) -> Void in
                        print("retry")
                    }
                    alertViewController.addAction(okAction)
                    self.presentViewController(alertViewController, animated: true, completion: nil)
                }
                else{
                    let alertViewController = UIAlertController(title: "Successful", message: "rename", preferredStyle: .Alert)
                    let okAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.Default){
                        (action: UIAlertAction!) -> Void in
                        self.saveUser()
                        let view = self.storyboard?.instantiateViewControllerWithIdentifier("login") as? LoginViewController
                        self.navigationController?.pushViewController(view!, animated: true)
                        
                    }
                    alertViewController.addAction(okAction)
                    self.presentViewController(alertViewController, animated: true, completion: nil)
                    print("yyy")
                }
                

            }
            else{
              print("zzz")
            }
//            let view = self.storyboard?.instantiateViewControllerWithIdentifier("login") as? LoginViewController
//            self.navigationController?.pushViewController(view!, animated: true)
            
        }
        else if !checkPassword(){
            let alertViewController = UIAlertController(title: "Password does not match", message: "retry", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.Default){
                (action: UIAlertAction!) -> Void in
                print("a")
            }
            alertViewController.addAction(okAction)
            self.presentViewController(alertViewController, animated: true, completion: nil)
        }
        else {
            let alertViewController = UIAlertController(title: "Username cannot be empty", message: "retry", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.Default){
                (action: UIAlertAction!) -> Void in
                print("a")
            }
            alertViewController.addAction(okAction)
            self.presentViewController(alertViewController, animated: true, completion: nil)
        }
    }
    
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var managedUserObject : User!
    var frc_User : NSFetchedResultsController! = nil
    
    func FetchRequest() ->NSFetchRequest{
        
        let request = NSFetchRequest(entityName: "User")
        
        request.predicate = NSPredicate(format: "name == %@" , nameLabel.text!.uppercaseString )
        //how to sort and what to query
        let sortor = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sortor]
        //        let predict = NSPredicate(format: "%K == %@","name","Sabin Tabirca")
        //        request.predicate = predict
        return request
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordLabel.secureTextEntry = true
        repeatLabel.secureTextEntry = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkPassword()-> Bool{
        if passwordLabel.text == repeatLabel.text && passwordLabel.text != ""{
            return true
        }
        else {
            return false
        }
    }
    
    func checkUsername()-> Bool{
        if nameLabel.text != "" && nameLabel.text != nil{
            return true
        }
        else {
            return false
        }
    }
    
    func saveUser(){
        let tableEntity = NSEntityDescription.entityForName("User", inManagedObjectContext: context)
        managedUserObject = User(entity: tableEntity!, insertIntoManagedObjectContext: context)
        managedUserObject.name = nameLabel.text!.uppercaseString
        managedUserObject.password = passwordLabel.text!
        managedUserObject.balance = 100.00
        do{
            try context.save()
        }catch{
            print("core data can not save after delete")
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
