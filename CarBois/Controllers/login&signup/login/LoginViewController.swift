//
//  LoginViewController.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 05/01/2023.
//

import UIKit
import GoogleSignIn
import AuthenticationServices

class LoginViewController: UIViewController,GIDSignInDelegate{

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var aloginButton: UIButton!
    @IBOutlet weak var floginButton: UIButton!
    @IBOutlet weak var gloginButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

 
//        buttonStyling(button: gloginButton)
//        buttonStyling(button: floginButton)
//        buttonStyling(button: aloginButton)
        
    }
    

    func buttonStyling(button:UIButton){
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        button.layer.cornerRadius = 10
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onCLickBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func onCLickLogin(_ sender: Any) {
    }
    
    
    @IBAction func onCLickgLogin(_ sender: Any) {
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.signIn()
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil {
            print("umer Email:  \(user.profile.email ?? "no emaol")")
            UserDefaults.standard.set(true, forKey: "isLoggedIn") //Bool
            
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarVC") as! UITabBarController
            self.view.window?.rootViewController = viewController
            self.view.window?.makeKeyAndVisible()


        }
    }
    
    
    @IBAction func onCLickfLogin(_ sender: Any) {
    }
    
    @IBAction func onCLickaLogin(_ sender: Any) {
        handleLogInWithAppleID()
    }
    
    func handleLogInWithAppleID() {
         let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
         
         let controller = ASAuthorizationController(authorizationRequests: [request])
         
         controller.delegate = self
         controller.presentationContextProvider = self
         
         controller.performRequests()
     }
    
    
    
//    @IBAction func onClickRecPassButton(_ sender: Any) {
//        let vc = UIStoryboard.init(name: "login", bundle: Bundle.main).instantiateViewController(withIdentifier: "recoverPassword") as? recoverPassword
//        self.navigationController?.pushViewController(vc!, animated: true)
//    }
    
}


extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding{
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            
            let defaults = UserDefaults.standard
            defaults.set(userIdentifier, forKey: "userIdentifier1")
            print(userIdentifier)
            UserDefaults.standard.set(true, forKey: "isLoggedIn") //Bool
            
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarVC") as! UITabBarController
            self.view.window?.rootViewController = viewController
            self.view.window?.makeKeyAndVisible()

            break
        default:
            break
        }
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
               return self.view.window!
        }
    
}
