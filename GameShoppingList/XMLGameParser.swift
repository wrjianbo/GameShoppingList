//
//  XMLGameParser.swift
//  GameShoppingList
//
//  Created by Tianbo Ji on 16/3/26.
//  Copyright © 2016年 Tianbo Ji. All rights reserved.
//


import UIKit

class XMLGameParser: NSObject,NSXMLParserDelegate {
    
    //variable declarations
    var fileName : String
    init(name: String){
        
        fileName = name
    }
    
    //get datda from xml
    var gName,gType,gPrice,gPlatform,gDor,gImage,gUrl,gDes :String!
    
    //vars to spy in between delegate
    var passData : Bool = false
    var passElementId : Int = -1
    
    //var for parsing
    var parser = NSXMLParser()
    var game = Game()
    var games = [Game]()
    
    func beginParsing(){
        
        //get the filename from bundle
        let bundleUrl = NSBundle.mainBundle().bundleURL
        let fileUrl = NSURL(string: fileName, relativeToURL: bundleUrl)
        //make the parse for the delegate
        parser = NSXMLParser(contentsOfURL: fileUrl!)!
        
        //set delegate
        parser.delegate = self
        //parse
        parser.parse()
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName gName: String?, attributes attributeDict: [String : String]) {
        //spy emelemtName started
        if(elementName == "name" || elementName == "type" || elementName == "price" || elementName == "platform" || elementName == "dor" || elementName == "image" || elementName == "url" || elementName == "des" ){
            
            passData = true
            switch elementName {
            case "name" : passElementId = 0
            case "type" : passElementId = 1
            case "price" : passElementId = 2
            case "platform" : passElementId = 3
            case "dor" : passElementId = 4
            case "image" : passElementId = 5
            case "url" : passElementId = 6
            case "des" : passElementId = 7
            default : break
            }
            
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        //reset the spies if nedded
        if(elementName == "name" || elementName == "type" || elementName == "price" || elementName == "platform" || elementName == "dor" || elementName == "image" || elementName == "url" || elementName == "des"){
            
            passData = false
            passElementId = -1
            
        }
        //make a new person
        
        if elementName == "game"{
            
            game = Game(name: gName, type: gType, price: gPrice, platform: gPlatform, dor: gDor, image: gImage, url: gUrl, des: gDes)
            games.append(game)
        }
    }
    
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        //baesd on spies then set the data vars
        
        if passData{
            
            switch passElementId {
                
            case 0 : gName = string
            case 1 : gType = string
            case 2 : gPrice = string
            case 3 : gPlatform = string
            case 4 : gDor = string
            case 5 : gImage = string
            case 6 : gUrl = string
            case 7 : gDes = string
            default: break
                
            }
            
        }
        
        
    }
    
    
    
}

