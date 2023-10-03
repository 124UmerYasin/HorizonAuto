//
//  contactUsVC.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 12/01/2023.
//

import UIKit

class contactUsVC: UIViewController {

    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var callView: UIView!
    
    @IBOutlet weak var BackView: UIView!
    
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailView.dropShadow()
        callView.dropShadow()
        BackView.dropShadow()
    }
    
    @IBAction func onClickBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickDoneButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func onClickCallButton(_ sender: Any) {
        let phoneNumber = "+1-010-101010101"
        if let url = NSURL(string: "tel://\(phoneNumber)"),UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.open(url as URL)
        }
    }
    
    
    @IBAction func onCLickEmailButton(_ sender: Any) {
        let email = "info@horizonauto.com"
        if let url = NSURL(string: "mailto:\(email)"),UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.open(url as URL)
        }
    }
    
}
