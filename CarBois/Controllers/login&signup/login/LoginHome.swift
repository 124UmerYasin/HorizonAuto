//
//  LoginHome.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 05/01/2023.
//

import UIKit
import Auth0
import JWTDecode
import Security
import AVFoundation

class LoginHome: UIViewController {

    @IBOutlet weak var gradView: UIView!
    @IBOutlet weak var signUpButton: UIButton!
    var user: User?
    var avPlayer: AVPlayer!
    var avPlayerLayer: AVPlayerLayer!
    var paused: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        loginButton.layer.borderWidth = 1
//        loginButton.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
//        loginButton.layer.cornerRadius = 5
        
        signUpButton.layer.cornerRadius = 8
        
        self.navigationController?.navigationBar.isHidden = true
        
//        animateImage()
        playVideo()
        signUpButton.dropShadow()
    }
    
    func playVideo(){
        let theURL = Bundle.main.url(forResource:"loginVideo", withExtension: "mp4")
        
        avPlayer = AVPlayer(url: theURL!)
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.videoGravity = .resizeAspectFill
        avPlayer.volume = 0
        avPlayer.actionAtItemEnd = .none
        avPlayerLayer.frame = view.layer.bounds
        view.backgroundColor = .clear
        view.layer.insertSublayer(avPlayerLayer, at: 0)
        
        
        
        let gradient = CAGradientLayer()
        gradient.frame = gradView.bounds
        gradient.colors = [UIColor(named: "col2")!,UIColor(named: "col3")!]
        gradView.layer.insertSublayer(gradient, at: 0)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: avPlayer.currentItem)
        
    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: .zero)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        avPlayer.play()
        paused = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        avPlayer.pause()
        paused = true
    }
//    func animateImage(){
//
//        UIView.animateKeyframes(withDuration: 3, delay: 0, animations: {
//                    self.carImgView.center.x += self.view.bounds.width
//
//                }, completion: nil)
//    }
    @IBAction func onClickSignUp(_ sender: Any) {
        
      
        Auth0.webAuth().scope("openid profile email").audience("login.horizonauto.com").audience("https://dev.horizonauto.com").start(){ [self] result in
            switch result {
            case .success(let credentials):
                print(credentials.accessToken)
                self.user = User(from: credentials.idToken)
                print(self.user)
                UserDefaults.standard.set(credentials.accessToken, forKey: "token")
                UserDefaults.standard.set(user?.email, forKey: "userEmail")
                UserDefaults.standard.set(user?.picture, forKey: "userPicture")
                UserDefaults.standard.set(user?.id, forKey: "userId")
                UserDefaults.standard.set(user?.name, forKey: "username")

                UserDefaults.standard.set(true, forKey: "isLoggedIn") //Bool
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarVC") as! UITabBarController
                self.view.window?.rootViewController = viewController
                self.view.window?.makeKeyAndVisible()
                
            case .failure(let error):
                print("Failed with: \(error)")
            }
        }
        
//        let vc = UIStoryboard.init(name: "login", bundle: Bundle.main).instantiateViewController(withIdentifier: "signupVcOne") as? signupVcOne
//        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
//    @IBAction func onClickLogin(_ sender: Any) {
//        let vc = UIStoryboard.init(name: "login", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
//        self.navigationController?.pushViewController(vc!, animated: true)
//    }
}
