//
//  WebViewController.swift
//  GameShoppingList
//
//  Created by Tianbo Ji on 16/3/26.
//  Copyright © 2016年 Tianbo Ji. All rights reserved.
//



import UIKit

class WebViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var weburlTF: UITextField!
    @IBAction func goBtn(sender: UIButton) {
        let url = NSURL (string: weburlTF.text!)
        let requestObj = NSURLRequest(URL: url!)
        webView.loadRequest(requestObj)
    }
    @IBAction func Stop(sender: UIBarButtonItem) {
        webView.stopLoading()
    }
    @IBAction func Refresh(sender: UIBarButtonItem) {
        webView.reload()
    }
    @IBAction func Back(sender: UIBarButtonItem) {
        webView.goBack()
    }
    
    
    @IBAction func Forward(sender: UIBarButtonItem) {
        webView.goForward()
    }
    
    
    var webUrl : String!
    var game : Game!
    override func viewDidLoad() {
        super.viewDidLoad()
        weburlTF.text = webUrl
        let url = NSURL (string: webUrl)
        let requestObj = NSURLRequest(URL: url!);
        webView.loadRequest(requestObj)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
