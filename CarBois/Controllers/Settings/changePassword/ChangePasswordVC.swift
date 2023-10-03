//
//  ChangePasswordVC.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 12/01/2023.
//

import UIKit

class ChangePasswordVC: UIViewController {

    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var backView: UIView!

    
    @IBOutlet weak var currentPasswordImage: UIImageView!
    @IBOutlet weak var currentPasswordButton: UIButton!
    @IBOutlet weak var currentPasswordField: UITextField!
    
    
    @IBOutlet weak var newPasswordImage: UIImageView!
    @IBOutlet weak var nesPasswordButton: UIButton!
    @IBOutlet weak var newPasswordField: UITextField!
    
    
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var confirmPasswordImage: UIImageView!
    @IBOutlet weak var confirmPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        backView.dropShadow()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onClickDoneButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    
    @IBAction func onCLickBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    @IBAction func onCLickUpdateButton(_ sender: Any) {
    }
    
    
    @IBAction func onClickCurrentPassword(_ sender: Any) {
        if currentPasswordField.isSecureTextEntry{
            currentPasswordImage.image = UIImage(named: "show")
            currentPasswordField.isSecureTextEntry = false
        }else{
            currentPasswordImage.image = UIImage(named: "hide")
            currentPasswordField.isSecureTextEntry = true
        }
    }
    
    
    @IBAction func onCLickNewPasswordButton(_ sender: Any) {
        if newPasswordField.isSecureTextEntry {
            newPasswordImage.image = UIImage(named: "show")
            newPasswordField.isSecureTextEntry = false
        }else{
            newPasswordImage.image = UIImage(named: "hide")
            newPasswordField.isSecureTextEntry = true
        }
    }
    
    
    @IBAction func onCLickConfirmPasswordButton(_ sender: Any) {
        if confirmPasswordField.isSecureTextEntry{
            confirmPasswordImage.image = UIImage(named: "show")
            confirmPasswordField.isSecureTextEntry = false
        }else{
            confirmPasswordImage.image = UIImage(named: "hide")
            confirmPasswordField.isSecureTextEntry = true
        }
    }
    
}
