//
//  AppDelegate.swift
//  CarBois
//
//  Created by Umer Yasin on 23/08/2022.
//

import UIKit
import GoogleSignIn
import IQKeyboardManagerSwift
import FirebaseCore
import Alamofire

func storeStackTrace() {
    
    NSSetUncaughtExceptionHandler { exception in
    
        var new:String = ""
        for exp in exception.callStackSymbols{
            new.append("\(exp)\n")
        }
        
//        let dict = ["device_name": UIDevice.current.name,
//                    "Date": "\(Date())",
//                    "event-type": "Exception",
//                    "device-info": AppPermission.getDeviceInfo(),
//                    "Backtrace": "\(new)",
//                    "Application": "Moody Poster",
//                    "Version": Constants.app_version
//        ] as [String : Any]
//
//        whistleWebhook.sharedInstance.errorLogsToWhistle(sendBodyData: dict)

        guard let url = URL(string: "https://hooks.slack.com/services/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") else { return }
        var header : HTTPHeaders = [:]
        header = ["Content-type": "application/json"]
        let parameters = [
                "exception": new
            ]
        
        let queue = DispatchQueue(label: "com.test.api", qos: .background, attributes: .concurrent)

        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header).responseData(queue: queue) { (response) in
            print(response.response?.statusCode)
            }
        
        LocalizationSystem.sharedInstance.setLanguage(languageCode: "en")
                    UIView.appearance().semanticContentAttribute = .forceLeftToRight
        
    }
    
    
    signal(SIGTRAP){ exp in
//        if(!AppDelegate.sigtrapBool){
            
            var new:String = ""
            for thr in Thread.callStackSymbols{
                new.append("\(thr)\n")
            }
            
//            let dict = ["device_name": UIDevice.current.name,
//                        "Date": "\(Date())",
//                        "event-type": "SIGTRAP",
//                        "device-info": AppPermission.getDeviceInfo(),
//                        "Backtrace": "\(new)",
//                        "Application": "Moody Poster",
//                        "Version": Constants.app_version
//            ] as [String : Any]
//            UserDefaults.standard.setValue(dict, forKey: DefaultsKeys.errorReport)
//            whistleWebhook.sharedInstance.errorLogsToWhistle(sendBodyData: dict)
//            AppDelegate.sigtrapBool = true
//        }
    }
    
    signal(SIGILL) { s in
        
//        if(!AppDelegate.sigillBool){
            let standardError = FileHandle.standardError
            var new:String = ""
            for thr in Thread.callStackSymbols{
                new.append("\(thr)\n")
            }
            
//            let dict = ["device_name": UIDevice.current.name,
//                        "event-type": "SIGILL",
//                        "device-info": AppPermission.getDeviceInfo(),
//                        "Backtrace": "\(new)",
//                        "Date": "\(Date())",
//                        "Application": "Moody Poster",
//                        "Version": Constants.app_version
//            ] as [String : Any]
//            UserDefaults.standard.setValue(dict, forKey: DefaultsKeys.errorReport)
//            whistleWebhook.sharedInstance.errorLogsToWhistle(sendBodyData: dict)
//            AppDelegate.sigillBool = true
//        }
    }
    
    signal(SIGABRT) { s in
        
        var new:String = ""
        for thr in Thread.callStackSymbols{
            new.append("\(thr)\n")
        }
        
//        let dict = ["device_name": UIDevice.current.name,
//                    "Date": "\(Date())",
//                    "event-type": "SIGABRT",
//                    "device-info": AppPermission.getDeviceInfo(),
//                    "Backtrace": "\(new)",
//                    "Application": "Moody Poster",
//                    "Version": Constants.app_version
//        ] as [String : Any]
//        UserDefaults.standard.setValue(dict, forKey: DefaultsKeys.errorReport)
//        whistleWebhook.sharedInstance.errorLogsToWhistle(sendBodyData: dict)
    }
    
    signal(SIGKILL) { s in
        
        var new:String = ""
        for thr in Thread.callStackSymbols{
            new.append("\(thr)\n")
        }
        
//        let dict = ["device_name": UIDevice.current.name,
//                    "Date": "\(Date())",
//                    "event-type": "SIGKILL",
//                    "device-info": AppPermission.getDeviceInfo(),
//                    "Backtrace": "\(new)",
//                    "Application": "Moody Poster",
//                    "Version": Constants.app_version
//        ] as [String : Any]
//        UserDefaults.standard.setValue(dict, forKey: DefaultsKeys.errorReport)
//        whistleWebhook.sharedInstance.errorLogsToWhistle(sendBodyData: dict)
    }
    
    signal(SIGQUIT) { s in
        
        var new:String = ""
        for thr in Thread.callStackSymbols{
            new.append("\(thr)\n")
        }
        
//        let dict = ["device_name": UIDevice.current.name,
//                    "Date": "\(Date())",
//                    "event-type": "SIGQUIT",
//                    "device-info": AppPermission.getDeviceInfo(),
//                    "Backtrace": "\(new)",
//                    "Application": "Moody Poster",
//                    "Version": Constants.app_version
//        ] as [String : Any]
//        UserDefaults.standard.setValue(dict, forKey: DefaultsKeys.errorReport)
//        whistleWebhook.sharedInstance.errorLogsToWhistle(sendBodyData: dict)
    }
    
    signal(EXC_RESOURCE) { s in
        
//        if(!AppDelegate.exc_resourceBool){
            var new:String = ""
            for thr in Thread.callStackSymbols{
                new.append("\(thr)\n")
            }
            
//            let dict = ["device_name": UIDevice.current.name,
//                        "Date": "\(Date())",
//                        "event-type": "EXC_RESOURCE",
//                        "device-info": AppPermission.getDeviceInfo(),
//                        "Backtrace": "\(new)",
//                        "Application": "Moody Poster",
//                        "Version": Constants.app_version
//            ] as [String : Any]
//            UserDefaults.standard.setValue(dict, forKey: DefaultsKeys.errorReport)
//            whistleWebhook.sharedInstance.errorLogsToWhistle(sendBodyData: dict)
//            AppDelegate.exc_resourceBool = true
//        }
    }
    
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate , GIDSignInDelegate{

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        storeStackTrace()
        if let url = launchOptions?[UIApplication.LaunchOptionsKey.url] as? URL {
              /// some
              getLink(urlString: url.absoluteString)
            return false
           }
        
        GIDSignIn.sharedInstance()?.clientID = "245922670738-lrt4k76gj8v1kd1gdfhslfiota5mdoa4.apps.googleusercontent.com"
        GIDSignIn.sharedInstance()?.delegate = self
       
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarTintColor = UIColor(named: "AppNewColor")!
        FirebaseApp.configure()
        return true
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("umer Email:  \(user.profile.email ?? "no emaol")")
    }
    
    // MARK: UISceneSession Lifecycle

//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called  shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }

    
    private func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb, let url = userActivity.webpageURL {
            // Handle the URL here
            print(url.absoluteString)
        }
        return true
    }
 
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        getLink(urlString: url.absoluteString)
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    
    func getLink(urlString:String){
        let urlString = urlString
        var dict: [String : String] = [:]
        if let urlComponents = URLComponents(string: urlString), let queryItems = urlComponents.queryItems {
            for item in queryItems {
                dict[item.name] = item.value
            }
        }
        AppUtility.selectedCodition = Int(dict["selectedCodition"]!)!
        AppUtility.selectedMake = Int(dict["selectedMake"]!)!
        AppUtility.selectedModel = Int(dict["selectedModel"]!)!
        AppUtility.selectedGeneration = Int(dict["selectedGeneration"]!)!
        AppUtility.selectedCodition = Int(dict["selectedCodition"]!)!
        do {
            let decodedseletedTableIndex = try JSONDecoder().decode([dashboardfilteratabledataModel].self, from: dict["seletedTableIndex"]!.data(using: .utf8)!)
            AppUtility.seletedTableIndex = decodedseletedTableIndex
        }catch{
            print("error")
        }
        
        do{
            let decodedmodelPricing = try JSONDecoder().decode(ModelPricingDataModelDataClass.self, from: dict["ModelPricingDataModel"]!.data(using: .utf8)!)
            AppUtility.ModelPricingDataModel = decodedmodelPricing
        }catch{
            print("error")
        }
        do{
            let decodedeAverageGraphData = try JSONDecoder().decode(AverageGraphDataModelDataClass.self, from: dict["AverageGraphData"]!.data(using: .utf8)!)
            AppUtility.graphData = decodedeAverageGraphData
        }catch{
            print("error")
            AppUtility.graphData = nil
        }
        do{
            let decodedehistoricGraphData = try JSONDecoder().decode(MultiHistoricGraphDataModelHistoricGraphData.self, from: dict["historicGraphData"]!.data(using: .utf8)!)
            AppUtility.multiHistoricGraphData = decodedehistoricGraphData
        }catch{
            AppUtility.multiHistoricGraphData = nil
        }
        
        do{
            let decodedefilterApplied = try JSONDecoder().decode([filtersRequest].self, from: dict["filterApplied"]!.data(using: .utf8)!)
            AppUtility.FilterApplied = decodedefilterApplied
        }catch{
            AppUtility.FilterApplied = nil
        }
        AppUtility.SelectedIndex = Int(dict["tenure"]!)!
        
        do{
            let decodedefilterRequestBody = try JSONDecoder().decode(averageGraphRequestModel.self, from: dict["filterRequestBody"]!.data(using: .utf8)!)
            AppUtility.filterRequestBody = decodedefilterRequestBody
        }catch{
            AppUtility.filterRequestBody = nil
        }
        
        do{
            let decodedeAverageCarListData = try JSONDecoder().decode(AverageGraphCarListModel.self, from: dict["averageGraphCarList"]!.data(using: .utf8)!)
            AppUtility.averageGraphCarList = decodedeAverageCarListData.data?.averageGraphCarsList?.currentTenureCarsList ?? [AverageGraphCarListModelCurrentTenureCarsList]()
        }catch{
            AppUtility.averageGraphCarList = [AverageGraphCarListModelCurrentTenureCarsList]()
        }
        
        do{
            let decodedehistoricreqData = try JSONDecoder().decode(multiHistoricGraphRequestModel.self, from: dict["historicGraphRequest"]!.data(using: .utf8)!)
            AppUtility.historicGraphRequestBody = decodedehistoricreqData
        }catch{
            AppUtility.historicGraphRequestBody = nil
        }
        
        do{
            let decodedehistoriccarData = try JSONDecoder().decode([MultiHistoricGraphDataModelDataPoint].self, from: dict["historicGraphcarData"]!.data(using: .utf8)!)
            AppUtility.multiHistoricGraphCarList = decodedehistoriccarData
        }catch{
            AppUtility.multiHistoricGraphCarList = [MultiHistoricGraphDataModelDataPoint]()
        }
        
        AppUtility.generation = dict["modelLabel"]!
        AppUtility.subGen = dict["subGenLabel"]!
        AppUtility.subTrims = dict["trimLabel"]!
        
        
        AppUtility.navigateToNextWhenAppOpen = true
        
        let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homePage = mainStoryboard.instantiateViewController(withIdentifier: "SplashVC") as! SplashVC
        self.window?.rootViewController = homePage
        window?.makeKeyAndVisible()
    }
}

