//
//  SignUpViewController.swift
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

class SignUpViewController: UIViewController {
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "SignUp!"
        
        loadView()
        
        guard let url = URL(string: "http://babyhoney.kr/login") else { return }
        let request = URLRequest(url: url)
        webView.load(request)
        
        
    }
    
    override func loadView() {
        let webConfigurations = WKWebViewConfiguration()
        let userScript = WKUserScript(source: "$.callFromWeb", injectionTime: .atDocumentEnd, forMainFrameOnly: true)
    
        let contentController = WKUserContentController()
        contentController.addUserScript(userScript)
        webConfigurations.userContentController = contentController
        webView = WKWebView(frame: .zero, configuration: webConfigurations)
        view = webView
    }
    
    
}
