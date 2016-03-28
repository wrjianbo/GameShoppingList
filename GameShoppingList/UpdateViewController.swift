//
//  UpdateViewController.swift
//  GameShoppingList
//
//  Created by Tianbo Ji on 16/3/27.
//  Copyright © 2016年 Tianbo Ji. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController {
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var managedGameObject : ShoppingList! = nil
   
   
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var numberTF: UITextField!
    
    
    
    
    @IBAction func updateBtn(sender: AnyObject) {
        updateList()
    }
    @IBAction func deleteBtn(sender: AnyObject) {
        deleteList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = managedGameObject.name!
        priceLabel.text = String(managedGameObject.price!)
        numberTF.text = String(managedGameObject.number!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateList(){
        managedGameObject.number = Int(numberTF.text!)
        do{
            try context.save()
        }catch{
            print("can not save new person")
        }
    }
    func deleteList(){
        context.deleteObject(managedGameObject)
        do{
            try context.save()
        }catch{
            print("can not save new person")
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
