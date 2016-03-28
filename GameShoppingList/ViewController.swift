//
//  ViewController.swift
//  GameShoppingList
//
//  Created by Tianbo Ji on 16/3/26.
//  Copyright © 2016年 Tianbo Ji. All rights reserved.
//



import UIKit
import CoreData

class ViewController: UIViewController, NSFetchedResultsControllerDelegate{
    @IBAction func addToList(sender: AnyObject) {
        checkIfGameAdded()
        if ifGameAdded{
            updatePerson()
        }
        else{
            addPerson()
        }
    }
    @IBOutlet weak var showList: UIBarButtonItem!
    
    @IBOutlet weak var numberTF: UITextField!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gameimage: UIImageView!
    @IBOutlet weak var desTextView: UITextView!
        var game : Game!
    var currentGame = Games(fromXMLFile: "Games.xml").data
    var curNum : Int!
    
    var current = 0
 
    
    
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var managedGameObject : ShoppingList! = nil
    var frc : NSFetchedResultsController! = nil
    var managedGames : [ShoppingList] = []
    
    var ifGameAdded : Bool = false
    
    
    func FetchRequest() ->NSFetchRequest{
        
        let request = NSFetchRequest(entityName: "ShoppingList")
        //how to sort and what to query
        let sortor = NSSortDescriptor(key: "name", ascending: true)
        
        request.sortDescriptors = [sortor]
        //        let predict = NSPredicate(format: "%K == %@","name","Sabin Tabirca")
        //        request.predicate = predict
        return request
    }
    

 
    
    @IBAction func pre(sender: UIButton) {
        current = current - 1
        
        if(current < 0){
            current = currentGame.count-1
        }
        name.text = currentGame[current].name
        gameimage.image = UIImage(named: currentGame[current].image)
        desTextView.text = currentGame[current].des
    }
    
    @IBAction func next(sender: UIButton) {
        current = current + 1
        
        if(current >= currentGame.count){
            current = 0
        }
        name.text = currentGame[current].name
        gameimage.image = UIImage(named: currentGame[current].image)
        desTextView.text = currentGame[current].des
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        current = curNum
        //SET TITLE
        self.title = "game info"
        
        print(current)
        if game != nil{
            name.text = game.name
            gameimage.image = UIImage(named: game.image)
            desTextView.text = game.des
        }
        frc = NSFetchedResultsController(fetchRequest: FetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        frc.delegate = self
        
        do{
            try frc.performFetch()
            
        }catch{
            print("fetch core data error")
        }


    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segue2" {
            //get data destination
            let controller = segue.destinationViewController as! Details
            
            //push the data
            controller.game = self.currentGame[current]
            
        }
        else if(segue.identifier == "segue_for_sl"){
            let controller = segue.destinationViewController as! ShoppingListTableViewController
            controller.game = self.currentGame[current]
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkIfGameAdded(){
        managedGames = frc.fetchedObjects as! [ShoppingList]
        for game in managedGames {
            if game.name == self.currentGame[current].name{
                managedGameObject = game
                ifGameAdded = true
            }
        }
    }
    
    
    func addPerson(){
        let tableEntity = NSEntityDescription.entityForName("ShoppingList", inManagedObjectContext: context)
            managedGameObject = ShoppingList(entity: tableEntity!, insertIntoManagedObjectContext: context)
        //fill managedPersonObject and save
            managedGameObject.name = currentGame[current].name
            managedGameObject.image = currentGame[current].image
            managedGameObject.number = Int(numberTF!.text!)
            let priceString = currentGame[current].price
            let index = priceString.startIndex.advancedBy(1)
            let price = priceString.substringFromIndex(index)
            managedGameObject.price = NSString(string: price).doubleValue
            do{
                try context.save()
            }catch{
            
                print("can not save new person")
            }
            print("\(managedGameObject)")
        

        
    }
    func updatePerson(){
        managedGameObject.number = (managedGameObject.number?.integerValue)! + Int(numberTF!.text!)!
        
    }
    
}



