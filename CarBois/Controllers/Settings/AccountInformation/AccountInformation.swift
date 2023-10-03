//
//  AccountInformation.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 16/01/2023.
//

import UIKit
import FittedSheets

class AccountInformation: UIViewController {

    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var genderButton: UIButton!
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    
    @IBOutlet weak var nameEditButton: UIButton!
    @IBOutlet weak var emailEditButton: UIButton!
    @IBOutlet weak var phoneNumberEditButton: UIButton!
    @IBOutlet weak var addressEditButton: UIButton!
    @IBOutlet weak var cityEditButton: UIButton!
    @IBOutlet weak var stateEditButton: UIButton!
    @IBOutlet weak var zipCodeEditButton: UIButton!
    
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var addressText: UITextField!
    @IBOutlet weak var cityText: UITextField!
    @IBOutlet weak var zipField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    
    
    var currentTag:Int?
    
    @IBOutlet weak var genderStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        backView.dropShadow()
        fullName.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        emailAddress.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        phoneNumber.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        addressText.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        cityText.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        zipField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        stateField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        genderStack.addGestureRecognizer(tap)
        
        
        fullName.text = UserDefaults.standard.string(forKey: "username")
        emailAddress.text = UserDefaults.standard.string(forKey: "userEmail")

    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        presentSheet()
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onClickBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func onClickDoneButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onCLickGenderButton(_ sender: Any) {
        presentSheet()
    }
    
    func presentSheet(){
        
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GenderSelectionVC")
        let sheetController = SheetViewController(
            controller: controller,
            sizes: [.percent(0.35)])
        sheetController.gripSize = CGSize(width: 50, height: 6)
        sheetController.gripColor = UIColor(white: 0.868, alpha: 1)
        sheetController.cornerRadius = 20
        sheetController.minimumSpaceAbovePullBar = 50
        sheetController.treatPullBarAsClear = true
        sheetController.dismissOnOverlayTap = true
        sheetController.dismissOnPull = true
        sheetController.allowPullingPastMaxHeight = true
        sheetController.autoAdjustToKeyboard = true
        sheetController.gripColor = .black
                
        sheetController.didDismiss = { [self] _ in
            genderField.text = AppUtility.Gender
        }
        self.present(sheetController, animated: true, completion: nil)
    }
    
    
    @IBAction func onCLickButton(_ sender: Any) {
        guard let tag = (sender as? UIButton)?.tag else{
            return
        }
        doneButtonClicked((Any).self)
        
        if tag == 1 {
            fullName.isUserInteractionEnabled = true
            fullName.becomeFirstResponder()
            currentTag = 1
            nameEditButton.isHidden = true

        }else if tag == 2 {
            emailAddress.isUserInteractionEnabled = true
            emailAddress.becomeFirstResponder()
            currentTag = 2
            emailEditButton.isHidden = true

        }else if tag == 3 {
            phoneNumber.isUserInteractionEnabled = true
            phoneNumber.becomeFirstResponder()
            currentTag = 3
            phoneNumberEditButton.isHidden = true

        }else if tag == 4 {
            addressText.isUserInteractionEnabled = true
            addressText.becomeFirstResponder()
            currentTag = 4
            addressEditButton.isHidden = true

        }else if tag == 5 {
            cityText.isUserInteractionEnabled = true
            cityText.becomeFirstResponder()
            currentTag = 5
            cityEditButton.isHidden = true

        }else if tag == 6 {
            stateField.isUserInteractionEnabled = true
            stateField.becomeFirstResponder()
            currentTag = 6
            stateEditButton.isHidden = true

        }else if tag == 7 {
            zipField.isUserInteractionEnabled = true
            zipField.becomeFirstResponder()
            currentTag = 7
            zipCodeEditButton.isHidden = true

        }
    }
    
    @objc func doneButtonClicked(_ sender: Any) {
            //your code when clicked on done
        
        if currentTag == 1 {
            fullName.isUserInteractionEnabled = false
            fullName.resignFirstResponder()
            nameEditButton.isHidden = false

        }else if currentTag == 2 {
            emailAddress.isUserInteractionEnabled = false
            emailAddress.resignFirstResponder()
            emailEditButton.isHidden = false

        }else if currentTag == 3 {
            phoneNumber.isUserInteractionEnabled = false
            phoneNumber.resignFirstResponder()
            phoneNumberEditButton.isHidden = false

        }else if currentTag == 4 {
            addressText.isUserInteractionEnabled = false
            addressText.resignFirstResponder()
            addressEditButton.isHidden = false

        }else if currentTag == 5 {
            cityText.isUserInteractionEnabled = false
            cityText.resignFirstResponder()
            cityEditButton.isHidden = false

        }else if currentTag == 6 {
            stateField.isUserInteractionEnabled = false
            stateField.resignFirstResponder()
            stateEditButton.isHidden = false

        }else if currentTag == 7 {
            zipField.isUserInteractionEnabled = false
            zipField.resignFirstResponder()
            zipCodeEditButton.isHidden = false

        }
    }
}
