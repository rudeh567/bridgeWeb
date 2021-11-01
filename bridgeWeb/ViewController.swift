//
//  ViewController.swift
//  bridgeWeb
//
//  Created by yeoboya on 2021/10/29.
//

import UIKit
import WebKit
import XHQWebViewJavascriptBridge
import Alamofire
import KakaoSDKAuth
import NaverThirdPartyLogin

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Login!"
        
        print("viewDidLoad Call")
        
        loadUrl()
    }
    
    func loadUrl() {
        view.addSubview(webView)
        
        let url = URL(string: "http://babyhoney.kr/login")
        let request = URLRequest(url: url!)
        
        webView.load(request)
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
    }
    
    public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        webView.reload()
    }
}

