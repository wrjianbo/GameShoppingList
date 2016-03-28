//
//  Game.swift
//  GameShoppingList
//
//  Created by Tianbo Ji on 16/3/26.
//  Copyright © 2016年 Tianbo Ji. All rights reserved.
//

import UIKit

class Game: NSObject {
    var name : String
    var type : String
    var price : String
    var platform : String
    var dor :String
    var image : String
    var url : String
    var des : String
    
    override init(){
        self.name    =  "45"
        self.type   =  "3444"
        self.price =  "23"
        self.platform   =  "434"
        self.dor    = ""
        self.image   =  "45"
        self.url     =  "www.google.ie"
        self.des = ""
        
    }
    init(name : String ,type : String , price : String, platform : String , dor : String,image : String,url : String,des : String){
        self.name    =  name
        self.type   =  type
        self.price =  price
        self.platform     =  platform
        self.dor = dor
        self.image   =  image
        self.url     =  url
        self.des    =   des
        
    }
}
