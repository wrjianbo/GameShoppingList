//
//  HistoryList+CoreDataProperties.swift
//  GameShoppingList
//
//  Created by Tianbo Ji on 16/3/28.
//  Copyright © 2016年 Tianbo Ji. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension HistoryList {

    @NSManaged var amount: NSNumber?
    @NSManaged var buyer: String?
    @NSManaged var coupon: String?
    @NSManaged var date: NSDate?
    @NSManaged var discount: NSNumber?
    @NSManaged var games: String?
    @NSManaged var paid: NSNumber?

}
