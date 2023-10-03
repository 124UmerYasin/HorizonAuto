//
//  logoutAlert.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 16/01/2023.
//

import UIKit
import Auth0

class logoutAlert: UIViewController {

    @IBOutlet weak var moButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    init() {
        super.init(nibName: "logoutAlert", bundle: Bundle(for: logoutAlert.self))
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func show() {
        UIApplication.shared.keyWindow?.rootViewController!.present(self, animated: true, completion: nil)
    }
    


    @IBAction func onClickNoButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCLickYesButton(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isLoggedIn") //Bool

        UserDefaults.standard.set(false, forKey: "cardetail") //Bool
        UserDefaults.standard.set(false, forKey: "Share") //Bool
        UserDefaults.standard.set(false, forKey: "feedback") //Bool
        UserDefaults.standard.set(false, forKey: "homeSearch")
        UserDefaults.standard.set(false, forKey: "searchfilterGen")
        UserDefaults.standard.set(false, forKey: "searchfilterTrim")

        

        Auth0.webAuth()
            .clearSession { result in
                switch result {
                case .success:
                    
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "login", bundle: nil)
                    let viewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginHome")
                    let navCon = UINavigationController(rootViewController: viewController)
                    navCon.navigationController?.navigationBar.isHidden = true
                    self.view.window?.rootViewController = navCon
                    self.view.window?.makeKeyAndVisible()
                    
                case .failure(let error):
                    print("Failed with: \(error)")
                }
            }
        
        
    }
}
