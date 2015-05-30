//
//  ViewController.swift
//  WebViewEx
//
//  Created by Ryo Nakano on 2015/05/30.
//  Copyright (c) 2015年 Peppermint Club. All rights reserved.
//

import UIKit

// Webビュー
class ViewController: UIViewController, UIWebViewDelegate {
    var _webView: UIWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Webビューの生成
        _webView = makeWebView(CGRectMake(0, 20,
            self.view.frame.width, self.view.frame.height-20))
        self.view.addSubview(_webView!)
        
        // インジゲータの表示
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        // HTMLの読み込み
        var url: NSURL = NSURL(string: "http://npaka.net")!
        var urlRequest: NSURLRequest = NSURLRequest(URL: url)
        _webView!.loadRequest(urlRequest)
    }
    
    // Webビューの生成
    func makeWebView(frame: CGRect) -> UIWebView {
        // Webビューの生成
        let webView = UIWebView()
        webView.frame = frame
        webView.backgroundColor = UIColor.blackColor()
        webView.scalesPageToFit = true
        webView.autoresizingMask =
            UIViewAutoresizing.FlexibleRightMargin |
            UIViewAutoresizing.FlexibleTopMargin |
            UIViewAutoresizing.FlexibleLeftMargin |
            UIViewAutoresizing.FlexibleBottomMargin |
            UIViewAutoresizing.FlexibleWidth |
            UIViewAutoresizing.FlexibleHeight
        webView.delegate = self
        return webView
    }

    // アラートの表示
    func showAlert(title: NSString?, text: NSString?) {
        let alert = UIAlertController(title: title as? String, message: text as? String,
            preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK",
            style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //=================================
    // UIWebViewDelegate
    //=================================
    
    // HTML読み込み時に呼ばれる
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        // クリック時
        if navigationType == UIWebViewNavigationType.LinkClicked ||
            navigationType == UIWebViewNavigationType.FormSubmitted {
            // 通信中の時は再度URLジャンプさせない
                if UIApplication.sharedApplication().networkActivityIndicatorVisible {
                    return false
                }
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        }
        return true
    }

    // HTML読み込み成功時に呼ばれる
    func webViewDidFinishLoad(webView: UIWebView) {
        // インジケータの非表示
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    // HTML読み込み失敗時に呼ばれる
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        // インジケータの非表示
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        
        // アラート
        showAlert(nil, text: "通信失敗しました")
    }
}

