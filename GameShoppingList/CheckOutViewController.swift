//
//  CheckOutViewController.swift
//  GameShoppingList
//
//  Created by Tianbo Ji on 16/3/27.
//  Copyright © 2016年 Tianbo Ji. All rights reserved.
//

import UIKit
import CoreData

class CheckOutViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,NSFetchedResultsControllerDelegate{
    @IBOutlet weak var checkoutTV: UITableView!
    
    @IBOutlet weak var total: UILabel!
    
    @IBOutlet weak var discount: UILabel!
    
    @IBOutlet weak var couponTF: UITextField!

    @IBAction func topupBtn(sender: AnyObject) {
        let alertViewController = UIAlertController(title: "Top Up", message: "How much do you want to top up?", preferredStyle: .Alert)
        alertViewController.addTextFieldWithConfigurationHandler {
                (textField: UITextField!) -> Void in
                textField.placeholder = "0.00"
        }
        let okAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.Default){
            (action: UIAlertAction!) -> Void in
            self.topupBalance(Double(alertViewController.textFields!.first!.text!)!)
        }
        let cancelAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.Default){
            (action: UIAlertAction!) -> Void in
        }
        alertViewController.addAction(okAction)
        alertViewController.addAction(cancelAction)
        self.presentViewController(alertViewController, animated: true, completion: nil)
        
    }
   
    @IBOutlet weak var balanceLabel: UILabel!
    


    @IBOutlet weak var youShouldPayLabel: UILabel!
    
    @IBAction func applyBtn(sender: AnyObject) {
        applyCouponCode()
    }
    func applyCouponCode(){
        let x = couponTF.text
        
        if checkCouponCode(x!){
           discountNum = 30
            let index2 = x!.startIndex.advancedBy(6)
            let couponSuffix = x!.substringFromIndex(index2)
            couponCode = x!
            discountNum = Int(couponSuffix)
            var m : Double! = Double(couponSuffix)
            m = (100.00 - Double(discountNum)) / 100.00
            paidmoney = Double(NSString(format: "%.2f", totalmoney * m) as String)
            youShouldPayLabel.text =  "€" + String(paidmoney)
            discount.text = String(discountNum) + "%"
            let alertViewController = UIAlertController(title: "Coupon apply successfully!", message: "Your code is :" + couponCode + "\n It gives you " + couponSuffix + "% off" , preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.Default){
                (action: UIAlertAction!) -> Void in
                print("you choose ok")
            }
            alertViewController.addAction(okAction)
            self.presentViewController(alertViewController, animated: true, completion: nil)
        }
        else{
            let alertViewController = UIAlertController(title: "Invaild Code", message: "Coupon format is 'couponXX'. \n 'XX' is a number between 00 and 99 \n For example, coupon20", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.Default){
                (action: UIAlertAction!) -> Void in
                self.couponTF.text = ""
            }
            alertViewController.addAction(okAction)
            self.presentViewController(alertViewController, animated: true, completion: nil)
        }
    }
    
    
    func checkCouponCode(s:String)-> Bool{
//        let index = .endIndex.advancedBy(-4)
//        let shortName = imageNameWithJpg!.substringToIndex(index)
//        let index = s.startIndex.advancedBy(6)
//        let price = s.substringFromIndex(index)
        if s.characters.count == 8{
            let index1 = s.endIndex.advancedBy(-2)
            let couponPrefix = s.substringToIndex(index1)
            if couponPrefix == "coupon"{
                let index2 = s.startIndex.advancedBy(6)
                let couponSuffix = s.substringFromIndex(index2)
                let suffixNum = Int(couponSuffix)
                if suffixNum != nil{
                    return true
                }
                else {
                    return false
                }
            }
            else{
                return false
            }
            
        }
        else{
            return false
        }
    }
    
    
    
    
    var discountNum : Int! = 0
    var couponCode : String = "No Coupon Code Used"
    
    var defaults = NSUserDefaults.standardUserDefaults()
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var managedGameObject : ShoppingList! = nil
    var frc : NSFetchedResultsController! = nil
    var gameObject : [ShoppingList] = []
    var totalmoney : Double! = 0.00
    var paidmoney : Double! = 0.00
    
    
    var managedHistoryObject : HistoryList!
    var frc_History : NSFetchedResultsController! = nil
    func FetchRequest() ->NSFetchRequest{
        
        let request = NSFetchRequest(entityName: "HistoryList")
        //how to sort and what to query
        let sortor = NSSortDescriptor(key: "date", ascending: false)
        
        request.sortDescriptors = [sortor]
        //        let predict = NSPredicate(format: "%K == %@","name","Sabin Tabirca")
        //        request.predicate = predict
        return request
    }

    var frc_User : NSFetchedResultsController! = nil
    func UserFetchRequest() ->NSFetchRequest{
        
        let request = NSFetchRequest(entityName: "User")
        //how to sort and what to query
        let sortor = NSSortDescriptor(key: "name", ascending: false)
        
        request.sortDescriptors = [sortor]
        request.predicate = NSPredicate(format: "name == %@" , defaults.stringForKey("currentUser")! )
        //        let predict = NSPredicate(format: "%K == %@","name","Sabin Tabirca")
        //        request.predicate = predict
        return request
    }
    var userObject : [User] = []
    
    var balance : Double! = 0.00
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkoutTV.delegate = self
        checkoutTV.dataSource = self
        gameObject = frc.fetchedObjects as! [ShoppingList]
        for game in gameObject {
            totalmoney = totalmoney + (game.number?.doubleValue)! * (game.price?.doubleValue)!
        }
        total?.text = "€" + String(NSString(format: "%.2f", totalmoney))
        discount.text = String(discountNum) + "%"
        var m : Double! = 0.00
        m = (100.00 - Double(discountNum)) / 100.00
        
        youShouldPayLabel.text =  "€" + String(NSString(format: "%.2f", totalmoney * m))
        frc_History = NSFetchedResultsController(fetchRequest: FetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        frc_User = NSFetchedResultsController(fetchRequest: UserFetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        frc_History.delegate = self
        frc_User.delegate = self
        do{
            try frc_History.performFetch()
            try frc_User.performFetch()
            
        }catch{
            print("fetch core data error")
        }
        paidmoney = totalmoney
        userObject = frc_User.fetchedObjects as! [User]
        
        balance = Double(NSString(format: "%.2f", userObject[0].balance!.doubleValue) as String)
        balanceLabel.text = "Balance:€" + String(NSString(format: "%.2f", balance))
        
                // Do any additional setup after loading the view.
    }

    
    @IBAction func checkOut(sender: UIButton) {
        if totalmoney > 0 && balance >= paidmoney{
            let tableEntity = NSEntityDescription.entityForName("HistoryList", inManagedObjectContext: context)
            managedHistoryObject = HistoryList(entity: tableEntity!, insertIntoManagedObjectContext: context)
            var x : String = String()
            for game in gameObject {
                x = x + game.name! + "\n"
                x = x + "  Price:        €" + String(game.price!) + "\n"
                x = x + "  Number:   " + String(game.number!) + "\n" + " " + "\n"
                context.deleteObject(game)
            }
            managedHistoryObject!.games = x
            print(managedHistoryObject!.games!)
            managedHistoryObject!.amount = totalmoney
            managedHistoryObject!.date = NSDate()
            managedHistoryObject!.buyer = defaults.stringForKey("currentUser")!
            managedHistoryObject!.coupon = couponCode
            managedHistoryObject!.discount = discountNum
            managedHistoryObject!.paid = paidmoney
            balance = balance - paidmoney
            userObject[0].balance = balance
            do{
                try context.save()
            }catch{
                print("core data can not save after delete")
            }
        }
        else if totalmoney > 0 && balance < paidmoney{
            let alertViewController = UIAlertController(title: "Balance not enough", message: "Do you want to top up €" + String(self.paidmoney - self.balance) + " now?", preferredStyle: .Alert)
            alertViewController.addTextFieldWithConfigurationHandler {
                (textField: UITextField!) -> Void in
                textField.placeholder = "0.00"
                textField.text = String(self.paidmoney - self.balance)
            }
            let okAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.Default){
                (action: UIAlertAction!) -> Void in
                
                self.topupBalance(Double((alertViewController.textFields?.first?.text)!)!)
            }
            let cancelAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.Default){
                (action: UIAlertAction!) -> Void in
            }
            alertViewController.addAction(okAction)
            alertViewController.addAction(cancelAction)
            self.presentViewController(alertViewController, animated: true, completion: nil)
        }
        else {
            let alertViewController = UIAlertController(title: "Empty Shooping List", message: "Please go to store and pick some games", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.Default){
                (action: UIAlertAction!) -> Void in
                
            }
            alertViewController.addAction(okAction)
            self.presentViewController(alertViewController, animated: true, completion: nil)
        }
//
//        
//        let view = self.storyboard?.instantiateViewControllerWithIdentifier("home") as? TableViewController
//        self.navigationController?.pushViewController(view!, animated: true)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return frc.sections![section].numberOfObjects
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellofcheckout", forIndexPath: indexPath)
        managedGameObject = frc.objectAtIndexPath(indexPath) as! ShoppingList
        let imageNameWithJpg = managedGameObject.image
        let index = imageNameWithJpg!.endIndex.advancedBy(-4)
        let shortName = imageNameWithJpg!.substringToIndex(index)

        cell.textLabel?.text = shortName.uppercaseString
        cell.detailTextLabel?.text = "€" + String(managedGameObject.price!) + " X " + String(managedGameObject.number!)
        if indexPath.row % 2 == 0{
            cell.backgroundColor = UIColor.lightTextColor()
        }
        else{
            cell.backgroundColor = UIColor.init(colorLiteralRed: 240/255, green: 240/255, blue: 240/255, alpha: 1)

        }
        
        // Configure the cell...
        
        return cell
    }
    
    func topupBalance(d:Double){
        balance = balance + d
        userObject[0].balance = balance
        do{
            try context.save()
        }catch{
            print("core data can not save after delete")
        }
        balanceLabel.text = "Balance:€" + String(NSString(format: "%.2f", balance))
        
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
