//
//  Games.swift
//  GameShoppingList
//
//  Created by Tianbo Ji on 16/3/26.
//  Copyright © 2016年 Tianbo Ji. All rights reserved.
//

import UIKit

class Games: NSObject {
    var data : [Game]
    override init(){
        data = [
            
            Game(name: "", type: "", price: "", platform: "", dor: "", image: "", url: "",des: "")
        ]
    }
    
    init(fromXMLFile: String){
        let parser = XMLGameParser(name: fromXMLFile)
        parser.beginParsing()
        data = parser.games
        
    }
    
}