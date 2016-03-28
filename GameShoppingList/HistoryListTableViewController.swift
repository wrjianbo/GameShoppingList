//
//  HistoryListTableViewController.swift
//  GameShoppingList
//
//  Created by Tianbo Ji on 16/3/27.
//  Copyright © 2016年 Tianbo Ji. All rights reserved.
//

import UIKit
import CoreData

class HistoryListTableViewController: UITableViewController,NSFetchedResultsControllerDelegate {
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var frc_History : NSFetchedResultsController! = nil
    var managedHistoryObject : HistoryList! = nil
    func FetchRequest() ->NSFetchRequest{
        
        let request = NSFetchRequest(entityName: "HistoryList")
        //how to sort and what to query
        let sortor = NSSortDescriptor(key: "date", ascending: false)
        
        request.sortDescriptors = [sortor]
        //        let predict = NSPredicate(format: "%K == %@","name","Sabin Tabirca")
        //        request.predicate = predict
        return request
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        frc_History = NSFetchedResultsController(fetchRequest: FetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        frc_History.delegate = self
        
        do{
            
            try frc_History.performFetch()
            
        }catch{
            
            print("fetch core data error")
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return frc_History.sections![section].numberOfObjects
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellofhistory", forIndexPath: indexPath)
        managedHistoryObject = frc_History.objectAtIndexPath(indexPath) as! HistoryList
        
        var time = String(managedHistoryObject.date!)
        let index = time.endIndex.advancedBy(-6)
        time = time.substringToIndex(index)
        cell.textLabel?.text = time
        cell.detailTextLabel?.text = "€" + String(managedHistoryObject.paid!)
        // Configure the cell...
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "segue_for_historydetail"){
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
            
            managedHistoryObject = frc_History.objectAtIndexPath(indexPath!) as! HistoryList
            let controller = segue.destinationViewController as! HistoryDetailsViewController
            controller.managedHistoryObject = managedHistoryObject
            
        }
        
    }
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
