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

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, NaverThirdPartyLoginConnectionDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    var bridge: WKWebViewJavascriptBridge!
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Login!"
        
        print("viewDidLoad Call")
        
        loginInstance?.delegate = self
        
        loadUrl()
        bridgeSetting()
    }
    
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("Success login")
        getInfo()
    }
    
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        loginInstance?.accessToken
    }
    
    func oauth20ConnectionDidFinishDeleteToken() {
        print("log out")
        self.loginInstance?.requestAccessTokenWithRefreshToken()
    }
    
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("error = \(error.localizedDescription)")
    }
    
    func loadUrl() {
        view.addSubview(webView)
        
        let url = URL(string: "http://babyhoney.kr/login")
        let request = URLRequest(url: url!)
        
        webView.load(request)
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
    }
    
    func getInfo() {
        guard let isValidAccessToken = loginInstance?.isValidAccessTokenExpireTimeNow() else { return }
        
        if !isValidAccessToken {
            return
        }
        
        guard let tokenType = loginInstance?.tokenType else { return }
        guard let accessToken = loginInstance?.accessToken else { return }
        
        let urlStr = "https://openapi.naver.com/v1/nid/me"
        let url = URL(string: urlStr)!
        
        let authorization = "\(tokenType) \(accessToken)"
        
        let req = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])
        
        req.responseJSON { response in
            guard let result = response.value as? [String: Any] else { return }
            guard let object = result["response"] as? [String: Any] else { return }
            guard let name = object["name"] as? String else { return }
            guard let email = object["email"] as? String else { return }
            guard let id = object["id"] as? String else { return }
            
            print(email)
        }
    }
    
    func bridgeSetting() {
        bridge = WKWebViewJavascriptBridge.bridge(forWebView: webView!)
        bridge?.registerHandler(handlerName: "$.callFromWeb", handler: { data, responseCallback in
            
            if String(describing: data).contains("loginNaver") {
                self.loginInstance?.requestThirdPartyLogin()
            } else {
                print("찾을수없음")
                self.loginInstance?.requestDeleteToken()
            }
        })
    }
    
    public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        webView.reload()
    }
}

