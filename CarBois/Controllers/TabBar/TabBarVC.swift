//
//  TabBarVC.swift
//  CarBois
//
//  Created by Umer Yasin on 20/09/2022.
//

import UIKit
import Alamofire
import PUGifLoading

class TabBarVC: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tabBar.layer.masksToBounds = true
        self.tabBar.isTranslucent = true
//        self.tabBar.layer.cornerRadius = 20
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner ]

        self.delegate = self
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == (tabBar.items!)[1]{
            AppUtility.showFIrstTimeLoader = true
            AppUtility.selectedSellFilter = nil
            AppUtility.isFromNavigationProg = false
            AppUtility.showOrHideLiveButton = true

        }else if item == (tabBar.items!)[2]{
            AppUtility.isFromNavigationProg = false
        }else if item == (tabBar.items!)[0]{
          print("ok")
            AppUtility.isFromNavigationProg = false
        }
    }
    

}
