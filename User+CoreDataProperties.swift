//
//  User+CoreDataProperties.swift
//  GameShoppingList
//
//  Created by Tianbo Ji on 16/3/30.
//  Copyright © 2016年 Tianbo Ji. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var name: String?
    @NSManaged var password: String?
    @NSManaged var balance: NSNumber?

}
