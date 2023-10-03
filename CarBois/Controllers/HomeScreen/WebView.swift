//
//  WebView.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 01/12/2022.
//

import UIKit
import WebKit
import Lottie

class WebView: UIViewController,WKNavigationDelegate {

    @IBOutlet weak var webvieww: WKWebView!
    
    @IBOutlet weak var backButton: UIButton!
    var webLink:String?
    
    @IBOutlet weak var lottieAnimationView : LottieAnimationView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        webvieww.navigationDelegate = self
        let url = URL(string: webLink ?? "https://4n4dhxdgde8.typeform.com/to/Ne24UTdp")!
        webvieww.load(URLRequest(url: url))
        webvieww.allowsBackForwardNavigationGestures = true
        webvieww.allowsLinkPreview = true
        
        webvieww.isHidden = true
        backButton.isHidden = true
        
        lottieAnimationView.isHidden = false
    
        lottieAnimationView.loopMode = .loop
        lottieAnimationView.play()
        
    }
    
    
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("yes")
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("poo")
      
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finfindh")
        webvieww.isHidden = false
        backButton.isHidden = false
        lottieAnimationView.isHidden = true
        lottieAnimationView.stop()
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
            self.dismiss(animated: true)
        }
        
        alert.addAction(okAction)

        self.present(alert, animated: true, completion: nil)

    }
    
    
    @IBAction func oncLickBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
