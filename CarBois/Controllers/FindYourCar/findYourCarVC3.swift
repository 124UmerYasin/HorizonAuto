//
//  findYourCarVC3.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 20/02/2023.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import MBRadioCheckboxButton
import FittedSheets
import PUGifLoading
import SwiftConfettiView

class findYourCarVC3: UIViewController,RadioButtonDelegate{

    @IBOutlet weak var timebtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var noBtn: UIButton!
    @IBOutlet weak var yesBtn: UIButton!
    
    @IBOutlet weak var option3: RadioButton!
    @IBOutlet weak var option1: RadioButton!
    @IBOutlet weak var option2: RadioButton!
    @IBOutlet weak var viewgroup: UIView!
    var group3Container = RadioButtonContainer()

    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var timeField: MDCOutlinedTextField!
    @IBOutlet weak var emailField: MDCOutlinedTextField!
    @IBOutlet weak var locationField: MDCOutlinedTextField!
    
    
    @IBOutlet weak var backButton: UIButton!
     
    var findcarSubmitReq:findcarSubmitRequest?

    var purchaseFrom:String?
    var time:String?
    
    @IBOutlet weak var tenureStackHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var priceField: MDCOutlinedTextField!
    private var findCar = findYoucarHomeVM()
    let loading = PUGIFLoading()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        backView.dropShadow()
        mainView.dropShadow()
        setupGroup3()
        addTitle(textFieldS: timeField, placeHolder: "Select Tenure")
        addTitle(textFieldS: locationField, placeHolder: "Please enter ZIP code")
        addTitle(textFieldS: emailField, placeHolder: "SuperCoolGuy@horizonauto.com")
        addTitle(textFieldS: priceField, placeHolder: "Price")

        tenureStackHeight.constant = 0
        timeField.isHidden = true
        yesBtn.sendActions(for: .touchUpInside)

        
    }
    
    override func viewDidLayoutSubviews() {
        noBtn.dropShadow()
        yesBtn.dropShadow()
    }
    
    func addTitle(textFieldS:MDCOutlinedTextField,placeHolder:String){
        textFieldS.label.text = placeHolder
        textFieldS.leadingAssistiveLabel.isHidden = true
        textFieldS.setOutlineColor(UIColor(named: "AppNewColor")!, for: .editing)
        textFieldS.setOutlineColor(.lightGray, for: .normal)
        textFieldS.verticalDensity = 1
        textFieldS.setFloatingLabelColor(.lightGray, for: .normal)
        textFieldS.setFloatingLabelColor(UIColor(named: "AppNewColor")!, for: .editing)
        textFieldS.setNormalLabelColor(.lightGray, for: .normal)
        textFieldS.font = UIFont.systemFont(ofSize: 15)
        textFieldS.autocapitalizationType = .none
        textFieldS.autocorrectionType = .no
        if placeHolder == "Please enter ZIP code" || placeHolder == "Price"{
            textFieldS.keyboardType = .numberPad
        }else{
            textFieldS.keyboardType = .alphabet
        }
        textFieldS.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        if placeHolder == "Price"{
            let imageView = UIImageView(image: UIImage(systemName: "dollarsign"))
            imageView.tintColor = .black
            imageView.contentMode = .center
            textFieldS.leadingView = imageView
            textFieldS.leadingViewMode = .always
            textFieldS.leadingView?.frame = CGRect(x: 0, y: 0, width: 12, height: 12)

        }
    }
    
    @objc func textFieldDidChange(_ textField: MDCOutlinedTextField) {
        if !(textField.text?.isEmpty ?? true){
            makeNormalButtonAfterError(textFieldS: textField)
        }

    }
    
    
    func setupGroup3() {
        
        group3Container.addButtons([option1, option2,option3])
        group3Container.delegate = self
        group3Container.selectedButton = option1
        
        option1.radioCircle = RadioButtonCircleStyle.init(outerCircle: 20, innerCircle: 15, outerCircleBorder: 2)
        option2.radioCircle = RadioButtonCircleStyle.init(outerCircle: 20, innerCircle: 15, outerCircleBorder: 2)
        option3.radioCircle = RadioButtonCircleStyle.init(outerCircle: 20, innerCircle: 15, outerCircleBorder: 2)

        option1.radioButtonColor = RadioButtonColor(active: UIColor(named: "AppNewColor")!, inactive: UIColor.gray)
        option2.radioButtonColor = RadioButtonColor(active: UIColor(named: "AppNewColor")!, inactive: UIColor.gray)
        option3.radioButtonColor = RadioButtonColor(active: UIColor(named: "AppNewColor")!, inactive: UIColor.gray)


    }
    
    func radioButtonDidSelect(_ button: RadioButton) {
        print("Select: ", button.title(for: .normal)!)
        purchaseFrom = button.title(for: .normal)
    }
    
    func radioButtonDidDeselect(_ button: RadioButton) {
        print("Deselect: ",  button.title(for: .normal)!)
    }
    

    @IBAction func onCLickNoBtn(_ sender: Any) {
        noBtn.backgroundColor = UIColor(named: "AppNewColor")!
        noBtn.setTitleColor(.white, for: .normal)
        yesBtn.backgroundColor = .white
        yesBtn.setTitleColor(.black, for: .normal)
        
        time = ""
        tenureStackHeight.constant = 76
        timeField.isHidden = false


        
    }
    @IBAction func onCLickYesbtn(_ sender: Any) {
        noBtn.backgroundColor = .white
        noBtn.setTitleColor(.black, for: .normal)

        yesBtn.backgroundColor = UIColor(named: "AppNewColor")!
        yesBtn.setTitleColor(.white, for: .normal)
        
        time = "Immediate"
        tenureStackHeight.constant = 0
        timeField.isHidden = true

    }
    
    
   
    
    @IBAction func onClickBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func onClickTimebtn(_ sender: Any) {
        presentSheetTimeLine { [self] timeS in
            timeField.text = timeS
            if timeS == "In a week or less"{
                time = "week"
            }else if timeS == "In about a Month"{
                time = "Month"
            }else if timeS == "In three or more months"{
                time = "Three Months"
            }
            
        }
    }
    
    
    func presentSheetTimeLine(completion: @escaping (String) -> Void){

        
        let controller = UIStoryboard(name: "SellYourCar", bundle: nil).instantiateViewController(withIdentifier: "DetailSearchVC")
        let sheetController = SheetViewController(
            controller: controller,
            sizes: [.percent(0.45)])
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
        
        let vc = sheetController.childViewController as! DetailSearchVC
        
        let arr2 = ["In a week or less","In about a Month","In three or more months"]
        
        var searchData = [dataForDetailSearch]()
        for item in arr2 {
            searchData.append(dataForDetailSearch(name: "\(item)" , id: -1, index: 0))
        }
        vc.addyears(carMake: searchData, title: "Choose Time")
        
        sheetController.didDismiss = { vc in
            let vc = vc.childViewController as! DetailSearchVC
            completion(vc.selectedValue ?? "In a week or less")
        }
        self.present(sheetController, animated: true, completion: nil)
    }
    
    
    @IBAction func onClickSubmitBtn(_ sender: Any) {
        
        if emailField.text?.isEmpty ?? true {
           makeFieldError(textFieldS: emailField,placeHolder: "Email")
        }else{
            if isValidEmail(email: emailField.text ?? "") {
                if locationField.text?.isEmpty ?? true {
                   makeFieldError(textFieldS: locationField,placeHolder: "Zip Code")
                }else{
                    if priceField.text?.isEmpty ?? true {
                       makeFieldError(textFieldS: priceField,placeHolder: "Listing Price")
                    }else{
                        findcarSubmitReq?.purchaseTimeline = time ?? "N/A"
                        findcarSubmitReq?.buyerLocation = locationField.text ?? "N/A"
                        findcarSubmitReq?.email = emailField.text ?? "N/A"
                        findcarSubmitReq?.buyerWillingToPurchaseFrom = purchaseFrom ?? "N/A"
                        findcarSubmitReq?.price = Int(priceField.text ?? "0")
                        if AppUtility.isUUidPresent{
                            findcarSubmitReq?.UUID = AppUtility.uuid
                            contactSeller(req: findcarSubmitReq!)
                        }else{
                            callApi(req: findcarSubmitReq!)

                        }
                    }
                }
            }else{
                makeFieldError(textFieldS: emailField,placeHolder: "Email")
            }
         
        }
        
//        if purchaseFrom != nil && purchaseFrom != "" && time != "" && time != nil && emailField.text != nil && emailField.text != "" && locationField.text != nil && locationField.text != "" ,priceField.text != "" && priceField.text != nil{
//            
//            findcarSubmitReq?.purchaseTimeline = time ?? "N/A"
//            findcarSubmitReq?.buyerLocation = locationField.text ?? "N/A"
//            findcarSubmitReq?.email = emailField.text ?? "N/A"
//            findcarSubmitReq?.buyerWillingToPurchaseFrom = purchaseFrom ?? "N/A"
//            findcarSubmitReq?.price = Int(priceField.text ?? "0")
//            if AppUtility.isUUidPresent{
//                findcarSubmitReq?.UUID = AppUtility.uuid
//                contactSeller(req: findcarSubmitReq!)
//            }else{
//                callApi(req: findcarSubmitReq!)
//
//            }
//        }else{
//            
//        }
    }
    
    func callApi(req:findcarSubmitRequest){
        showLoader(loader: loading)
        findCar.submitForBuyListing(requestModel: req) { [self] result in
            switch result{
            case .success(let result):
               print(result)
                let confettiView = SwiftConfettiView(frame: self.view.bounds)
                self.view.addSubview(confettiView)
                confettiView.type = .confetti
                confettiView.startConfetti()
                AlertHelper.showAlertWithTitle(self, title: "Congrats you're on your way to finding your dream car!", dismissButtonTitle: "OK") { [self] () -> Void in
                    hideLoader(loader: loading)
                    confettiView.stopConfetti()
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "navigateToSellYourCarVC"), object: nil, userInfo: nil)
                    self.dismiss(animated: true)
                }
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                }
                hideLoader(loader: loading)

            }
        }
    }
    
    func contactSeller(req:findcarSubmitRequest){
        showLoader(loader: loading)
        findCar.Contactseller(requestModel: req) { [self] result in
            switch result{
            case .success(let result):
                print(result)
                let confettiView = SwiftConfettiView(frame: self.view.bounds)
                self.view.addSubview(confettiView)
                confettiView.type = .confetti
                confettiView.startConfetti()
//                let seconds = 1.0
//                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) { [self] in
//                    hideLoader(loader: loading)
//                    confettiView.stopConfetti()
//                    self.dismiss(animated: true)
//                }
                AlertHelper.showAlertWithTitle(self, title: "Congrats, you're on your way to selling your car for a great price!", dismissButtonTitle: "OK") { [self] () -> Void in
                    hideLoader(loader: loading)
                    confettiView.stopConfetti()
                    self.dismiss(animated: true)
                }
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                }
                hideLoader(loader: loading)

            }
        }
    }
    
    
    
    func makeNormalButtonAfterError(textFieldS:MDCOutlinedTextField){
//        textFieldS.leadingAssistiveLabel.isHidden = true
//        textFieldS.setLeadingAssistiveLabelColor(.clear, for: .normal)
//        textFieldS.setLeadingAssistiveLabelColor(.clear, for: .editing)
//        textFieldS.leadingAssistiveLabel.text = nil
        textFieldS.setOutlineColor(UIColor(named: "AppNewColor")!, for: .editing)
        textFieldS.setOutlineColor(.lightGray, for: .normal)
        textFieldS.setFloatingLabelColor(.lightGray, for: .normal)
        textFieldS.setFloatingLabelColor(UIColor(named: "AppNewColor")!, for: .editing)
        textFieldS.setNormalLabelColor(.lightGray, for: .normal)
    }
   
    func makeFieldError(textFieldS:MDCOutlinedTextField,placeHolder:String){
//        textFieldS.leadingAssistiveLabel.isHidden = false
//        textFieldS.leadingAssistiveLabel.text = "Please Enter Your \(placeHolder)."
//        textFieldS.setLeadingAssistiveLabelColor(.red, for: .normal)
        textFieldS.setOutlineColor(.red, for: .normal)
        textFieldS.setNormalLabelColor(.red, for: .normal)
        textFieldS.setFloatingLabelColor(.red, for: .normal)
    }
 
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
}
