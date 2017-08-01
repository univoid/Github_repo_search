//
//  ViewController.swift
//  Github_repo_search
//
//  Created by YUHUI ZHENG on 2017/07/30.
//  Copyright © 2017 YUHUI ZHENG. All rights reserved.
//

import UIKit
import WebKit

class InfoViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    // URL parameter got from Repo Search
    var paramURL: String!

    
    override func loadView() {
        // Initialize a webView
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Request for info
        let myURL = URL(string: paramURL)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Actions
//    @IBAction func unwindToInfo(sender: UIStoryboardSegue) {
//        if let sourceViewController = sender.source as? RepoTableViewController {
//            self.paramURL = sourceViewController.url
//        }
//    }
}
