//
//  HistoryDetailsViewController.swift
//  GameShoppingList
//
//  Created by Tianbo Ji on 16/3/28.
//  Copyright © 2016年 Tianbo Ji. All rights reserved.
//

import UIKit
import CoreData

class HistoryDetailsViewController: UIViewController,NSFetchedResultsControllerDelegate {
    var managedHistoryObject : HistoryList! = nil
    var gameObject : [HistoryList] = []
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var frc_History : NSFetchedResultsController! = nil
    func FetchRequest() ->NSFetchRequest{
        
        let request = NSFetchRequest(entityName: "HistoryList")
        //how to sort and what to query
        let sortor = NSSortDescriptor(key: "amount", ascending: true)
        
        request.sortDescriptors = [sortor]
        //        let predict = NSPredicate(format: "%K == %@","name","Sabin Tabirca")
        //        request.predicate = predict
//        request.predicate = NSPredicate(format: "name == " + , <#T##args: CVarArgType...##CVarArgType#>)
        return request
    }
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var tv: UITextView!
    
    @IBAction func deleteBtn(sender: AnyObject) {

        gameObject = frc_History.fetchedObjects as! [HistoryList]
        for game in gameObject {
            context.deleteObject(game)
        }
        do{
            try context.save()
        }catch{
            print("core data can not save after delete")
        }
    }
    
    @IBOutlet weak var amountLabel: UILabel!
 
    
    @IBOutlet weak var discountNumLabel: UILabel!
    
    @IBOutlet weak var couponLabel: UILabel!
    
    @IBOutlet weak var paidLabel: UILabel!
    
    @IBOutlet weak var buyerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        frc_History = NSFetchedResultsController(fetchRequest: FetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        frc_History.delegate = self
        do{
            
            try frc_History.performFetch()
            
        }catch{
            
            print("fetch core data error")
        }
        
        
        tv.text = managedHistoryObject.games!
        var time = String(managedHistoryObject.date!)
        let index = time.endIndex.advancedBy(-6)
        time = time.substringToIndex(index)
        dateLabel.text = "Date:  " + time
        amountLabel.text = "€" + String(managedHistoryObject.amount!)
        discountNumLabel.text = String(managedHistoryObject.discount!) + "%"
        couponLabel.text = managedHistoryObject.coupon!
        buyerLabel.text = managedHistoryObject.buyer!
        paidLabel.text = "€" + String(managedHistoryObject.paid!)
        print(String(managedHistoryObject.amount!) + "\n" + managedHistoryObject.buyer!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
