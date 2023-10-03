//
//  SplashVC.swift
//  CarBois
//
//  Created by Umer Yasin on 20/09/2022.
//

import UIKit
import Lottie
import Auth0
import JWTDecode
import Security

class SplashVC: UIViewController {
    
    @IBOutlet weak var animatingView: LottieAnimationView!
    
    let window = UIWindow()
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animatingView.animation = LottieAnimation.named("splash")
        animatingView.contentMode = .scaleAspectFill
        animatingView.loopMode = .playOnce
//        getDashBoardData()
        
        animatingView.play { [self] Bool in
            if UserDefaults.standard.bool(forKey: "isLoggedIn"){
                Auth0.authentication().userInfo(withAccessToken: (UserDefaults.standard.string(forKey: "token") ?? "")).start { [self] result in
                    switch result {
                    case .success(_):
                        DispatchQueue.main.async { [self] in
                            someSelector()
                        }
                    case .failure(_):
                        DispatchQueue.main.async { [self] in
                            performLogout()
                        }
                    }
                }
            }else{
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "login", bundle: nil)
                let viewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginHome")
                let navCon = UINavigationController(rootViewController: viewController)
                navCon.navigationBar.isHidden = true
                self.view.window?.rootViewController = navCon
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
    
    // this API has been removed
//    func getDashBoardData(){
//        let url = ApiConstant.getDashboardFilterData
//        guard let urlString = URLComponents(string: url) else {
//            return
//        }
//
//        let requestModel = getDashboardfilterDataRequest()
//        WebAPI<getDashboardfilterDataRequest,CarMakeModel>.getApiRequest(apiURL: urlString, requestModel: requestModel) { (result) in
//            switch result {
//            case .success(let result):
//                AppUtility.dashboardFilterData = result
//            case .failure(let error):
//                let err = CustomError(description: (error as? CustomError)?.description ?? "")
//                print(err)
//            }
//        }
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        animatingView.stop()
    }
    
    func someSelector() {

        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarVC") as! UITabBarController
        self.view.window?.rootViewController = viewController
        self.view.window?.makeKeyAndVisible()
        
    }
    
    func performLogout(){
        
        UserDefaults.standard.set(false, forKey: "isLoggedIn") //Bool
        UserDefaults.standard.set(false, forKey: "cardetail") //Bool
        UserDefaults.standard.set(false, forKey: "Share") //Bool
        UserDefaults.standard.set(false, forKey: "feedback") //Bool
        UserDefaults.standard.set(false, forKey: "homeSearch")
        UserDefaults.standard.set(false, forKey: "searchfilterGen")
        UserDefaults.standard.set(false, forKey: "searchfilterTrim")

        let mainStoryboard: UIStoryboard = UIStoryboard(name: "login", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginHome")
        let navCon = UINavigationController(rootViewController: viewController)
        navCon.navigationController?.navigationBar.isHidden = true
        self.view.window?.rootViewController = navCon
        self.view.window?.makeKeyAndVisible()
        
        // commented as Auth 0 was being called twice if user is already logged out
        
//        Auth0.webAuth()
//            .clearSession { result in
//                switch result {
//                case .success:
//                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "login", bundle: nil)
//                    let viewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginHome")
//                    let navCon = UINavigationController(rootViewController: viewController)
//                    navCon.navigationController?.navigationBar.isHidden = true
//                    self.view.window?.rootViewController = navCon
//                    self.view.window?.makeKeyAndVisible()
//                case .failure(let error):
//                    print("Failed with: \(error)")
//                }
//            }
    }
}

struct getDashboardfilterDataRequest : Codable {
    
}

struct getHotPicksRequest : Codable{
    
}

struct getMarqueeRequest : Codable{
    
}
struct getFeaturedListingRequest : Codable{
    
}

struct getuserSaleListingRequest : Codable{
    
}
struct getuserWTBListingRequest : Codable{
    
}

struct getHomeCarDetailRequest : Codable{
    var uuid: String
}
struct gethomecardetailListingRequest : Codable{
    var uuid: String

}
struct gethomecardetailGraphRequest : Codable{
    var carModelId : Int?
    var carMakeId : Int?
    var sub_gens_and_trim_defs : [sub_gens_and_trim_defs]?
}

struct sub_gens_and_trim_defs : Codable {
    var carSubGenerationId:Int?
    var trimDefinitionId:Int?
}


struct gethomecardetailListinghRequest : Codable{
    var carModelId : Int?
    var carMakeId : Int?
    var sub_gens_and_trim_defs : [sub_gens_and_trim_defs]?
    var pageLimit : Int?
    var pageOffset : Int?

}


