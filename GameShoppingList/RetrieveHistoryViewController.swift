//
//  RetrieveHistoryViewController.swift
//  GameShoppingList
//
//  Created by Tianbo Ji on 16/3/30.
//  Copyright © 2016年 Tianbo Ji. All rights reserved.
//

import UIKit
import CoreData

class RetrieveHistoryViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource,NSFetchedResultsControllerDelegate {
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var operatorString : String!
    var compareMethod = []
    var pickedDate : NSDate!
    var frc_History : NSFetchedResultsController! = nil
    var managedHistoryObject : HistoryList! = nil

    var request = NSFetchRequest(entityName: "HistoryList")
    
    func compareBtnClick(){
        request.predicate = NSPredicate(format: "amount " + operatorString + " %f AND buyer CONTAINS %@" , Double(compareAmountTF.text!)!,(nameTF.text?.uppercaseString)! )
        
            frc_History = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        frc_History.delegate = self
        
        do{
            
            try frc_History.performFetch()
            
        }catch{
            
        }
        self.retrieveTable.reloadData()
        
        print("xxx")
//        self.retrieveTable.delegate = self
//        self.retrieveTable.dataSource = self

    }
    
    
    @IBOutlet weak var compareAmountTF: UITextField!
    
    @IBOutlet weak var nameTF: UITextField!

    @IBAction func btn(sender: UIButton) {
        compareBtnClick()
    }
    
    
    @IBAction func resetBtn(sender: UIButton) {
        resetRetrieve()
    }
    
    func resetRetrieve(){
        request = NSFetchRequest(entityName: "HistoryList")
        let sortor = NSSortDescriptor(key: "paid", ascending: true)
        request.sortDescriptors = [sortor]
        frc_History = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        frc_History.delegate = self
        
        do{
            
            try frc_History.performFetch()
            
        }catch{
            
        }
        self.retrieveTable.reloadData()
        self.comparePicker.selectRow(0, inComponent: 0, animated: true)
        operatorString = ">"
        nameTF.text = ""
        compareAmountTF.text = "0.00"
    }
    
    
    @IBOutlet weak var retrieveTable: UITableView!
    
//    var datePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comparePicker.delegate = self
        comparePicker.dataSource =  self
        compareMethod = [">",">=","=","<","<="]
        operatorString = ">"
        let sortor = NSSortDescriptor(key: "paid", ascending: true)
       request.sortDescriptors = [sortor]
        compareAmountTF.text = "0.00"
        frc_History = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        frc_History.delegate = self
        
        do{
            
            try frc_History.performFetch()
            
        }catch{
            
        }
        self.retrieveTable.delegate = self
        self.retrieveTable.dataSource = self
//        datePicker  = UIDatePicker(frame: CGRectMake(150, 300, 120, 40))
//        datePicker.datePickerMode = UIDatePickerMode.DateAndTime
//        datePicker.minuteInterval = 1
//        pickedDate = NSDate()
//        datePicker.date = NSDate()
        // Do any additional setup after loading the view.
    }

   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return compareMethod.count
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
       return compareMethod[row] as? String
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        operatorString = compareMethod[row] as! String
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return frc_History.sections![section].numberOfObjects
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellofretrieve", forIndexPath: indexPath)
        managedHistoryObject = frc_History.objectAtIndexPath(indexPath) as! HistoryList
        cell.textLabel?.text = "Buyer:" + managedHistoryObject.buyer!
        cell.detailTextLabel?.text =  "€" + String(managedHistoryObject.paid!)
        if indexPath.row % 2 == 0{
            cell.backgroundColor = UIColor.lightTextColor()
        }
        else{
            cell.backgroundColor = UIColor.init(colorLiteralRed: 240/255, green: 240/255, blue: 240/255, alpha: 1)
            
        }
        
        // Configure the cell...
        
        return cell
    }
    
    
    @IBOutlet weak var comparePicker: UIPickerView!
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "segue_retrieve_detail"){
            let indexPath = self.retrieveTable.indexPathForCell(sender as! UITableViewCell)
            
            managedHistoryObject = frc_History.objectAtIndexPath(indexPath!) as! HistoryList
            let controller = segue.destinationViewController as! HistoryDetailsViewController
            controller.managedHistoryObject = managedHistoryObject
            
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
