//
//  ShoppingListTableViewController.swift
//  GameShoppingList
//
//  Created by Tianbo Ji on 16/3/27.
//  Copyright © 2016年 Tianbo Ji. All rights reserved.
//

import UIKit
import CoreData

class ShoppingListTableViewController: UITableViewController,NSFetchedResultsControllerDelegate {
    var shoppingList : ShoppingList!
    var game : Game!
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var managedGameObject : ShoppingList! = nil
    var frc : NSFetchedResultsController! = nil
    func FetchRequest() ->NSFetchRequest{
        
        let request = NSFetchRequest(entityName: "ShoppingList")
        //how to sort and what to query
        let sortor = NSSortDescriptor(key: "name", ascending: true)
        
        request.sortDescriptors = [sortor]
        //        let predict = NSPredicate(format: "%K == %@","name","Sabin Tabirca")
        //        request.predicate = predict
        return request
    }

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frc = NSFetchedResultsController(fetchRequest: FetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        frc.delegate = self
        
        do{
            
            try frc.performFetch()
            
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
        return frc.sections![section].numberOfObjects
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell2", forIndexPath: indexPath)
        managedGameObject = frc.objectAtIndexPath(indexPath) as! ShoppingList
        cell.textLabel?.text = managedGameObject.name
        cell.detailTextLabel?.text = "Price:€" + String(managedGameObject.price!) + "       Number:" + String(managedGameObject.number!)
        cell.imageView?.image = UIImage(named: managedGameObject.image!)
        // Configure the cell...
        if indexPath.row % 2 == 0{
            cell.backgroundColor = UIColor.init(colorLiteralRed: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        }
        else{
            cell.backgroundColor = UIColor.clearColor()
            
        }

        return cell
    }
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.reloadData()
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // fetch managed object and save
            managedGameObject = frc.objectAtIndexPath(indexPath) as! ShoppingList
            
            context.deleteObject(managedGameObject)
            
            do{
                try context.save()
            }catch{
                print("core data can not save after delete")
            }
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "segue_for_checkout"){
            let controller = segue.destinationViewController as! CheckOutViewController
            controller.frc = self.frc

        }
        else if segue.identifier == "segue_for_update"{
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
            
            managedGameObject = frc.objectAtIndexPath(indexPath!) as! ShoppingList

            let controller = segue.destinationViewController as! UpdateViewController
            controller.managedGameObject = self.managedGameObject
            
            
        }
    }
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
