//
//  ArticleViewController.swift
//  Four11
//
//  Created by Omar Padierna on 2019-03-19.
//  Copyright © 2019 Omar Padierna. All rights reserved.
//

import UIKit
import WebKit

class ArticleViewController: UIViewController {
    var urlString = ""
    var source = ""
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
         activityIndicator.startAnimating()
        webView.navigationDelegate = self
        // Do any additional setup after loading the view.
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        webView.load(request)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}


extension ArticleViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
       activityIndicator.stopAnimating()
    }
    
 
    
}
