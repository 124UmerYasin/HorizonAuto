//
//  Constants.swift
//  CarBois
//
//  Created by Umer Yasin on 20/09/2022.
//

import Foundation
import UIKit

let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let kIphone_4s : Bool =  (UIScreen.main.bounds.size.height == 480)
let kIphone_5 : Bool =  (UIScreen.main.bounds.size.height == 568)
let kIphone_6 : Bool =  (UIScreen.main.bounds.size.height == 667)
let kIphone_6_Plus : Bool =  (UIScreen.main.bounds.size.height == 736)
let kIphone_10 : Bool =  (UIScreen.main.bounds.size.height == 812)

let KUSERDEFAULTS = UserDefaults.standard
let APPDEL = UIApplication.shared.delegate as? AppDelegate

let DEVICEID = UIDevice.current.identifierForVendor?.uuidString


struct UserDefaultConstants {
    static let dashBoardFilterData = "dashBoardFilterData"
}
