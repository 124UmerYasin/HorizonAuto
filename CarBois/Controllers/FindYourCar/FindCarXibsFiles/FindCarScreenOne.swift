//
//  FindCarScreenOne.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 16/02/2023.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields


class FindCarScreenOne: UITableViewCell {

    @IBOutlet weak var exteriorClor: MDCOutlinedTextField!
    
    @IBOutlet weak var interiorColor: MDCOutlinedTextField!
    
    @IBOutlet weak var maxMileage: MDCOutlinedTextField!
    @IBOutlet weak var minMileage: MDCOutlinedTextField!
    
    @IBOutlet weak var makeView: UIView!
    @IBOutlet weak var modelView: UIView!
    @IBOutlet weak var generationView: UIView!
    @IBOutlet weak var subGenView: UIView!
    @IBOutlet weak var trimView: UIView!
    
    
    @IBOutlet weak var makeLbl: UILabel!
    @IBOutlet weak var trimLbl: UILabel!
    @IBOutlet weak var subgenLbl: UILabel!
    @IBOutlet weak var genlbl: UILabel!
    @IBOutlet weak var modelLbl: UILabel!
    
    @IBOutlet weak var atackButton: UIButton!
    
    var onCLickNext : ((String,String,String,String)->())?
    var error : (()->())?
    var onCLickStack : (()->())?

    @IBOutlet weak var DeatilView: UIView!
    
    @IBOutlet weak var stackViewHeightConst: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        makeView.dropShadow()
        modelView.dropShadow()
        generationView.dropShadow()
        subGenView.dropShadow()
        trimView.dropShadow()

        addTitle(textFieldS: exteriorClor, placeHolder: "Exterior Color")
        addTitle(textFieldS: interiorColor, placeHolder: "Interior Color")
        addTitle(textFieldS: maxMileage, placeHolder: "Enter Maximum mileage")
        addTitle(textFieldS: minMileage, placeHolder: "Enter Minimum mileage")
        
    }
    
    func addDataAfterSearch(make:String,model:String,gen:String,subgen:String,trims:String){
        if make == "" && model == "" && gen == "" && subgen == "" && trims == "" {
            stackViewHeightConst.constant = 0
            DeatilView.isHidden = true
        }else{
            stackViewHeightConst.constant = 245
            DeatilView.isHidden = false

            modelLbl.text = model
            makeLbl.text = make
            genlbl.text = gen
            subgenLbl.text = subgen
            trimLbl.text = trims
        }
        
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
        
        if placeHolder == "Enter Minimum mileage" || placeHolder == "Enter Maximum mileage"{
            textFieldS.keyboardType = .numberPad
        }else{
            textFieldS.keyboardType = .alphabet
        }
        textFieldS.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

    }

    @objc func textFieldDidChange(_ textField: MDCOutlinedTextField) {
        if !(textField.text?.isEmpty ?? true){
            makeNormalButtonAfterError(textFieldS: textField)
        }

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onCLickNext(_ sender: Any) {
        
        if exteriorClor.text?.isEmpty ?? true {
           makeFieldError(textFieldS: exteriorClor,placeHolder: "Car Exterior Color")
        }else{
            if interiorColor.text?.isEmpty ?? true {
               makeFieldError(textFieldS: interiorColor,placeHolder: "Car Interior Color")
            }else{
                if minMileage.text?.isEmpty ?? true {
                   makeFieldError(textFieldS: minMileage,placeHolder: "Car Minimum Mileage")
                }else{
                    if maxMileage.text?.isEmpty ?? true {
                       makeFieldError(textFieldS: maxMileage,placeHolder: "Car Maximum Mileage")
                    }else{
                        onCLickNext?(exteriorClor.text ?? "N/A",interiorColor.text ?? "N/A",minMileage.text ?? "N/A",maxMileage.text ?? "N/A")

                    }
                }
            }
        }
        
        
//        if exteriorClor.text != "" && exteriorClor.text != nil && interiorColor.text != "" && interiorColor.text != nil && maxMileage.text != "" && maxMileage.text != nil && minMileage.text != "" && minMileage.text != nil{
//            onCLickNext?(exteriorClor.text ?? "N/A",interiorColor.text ?? "N/A",minMileage.text ?? "N/A",maxMileage.text ?? "N/A")
//        }else{
//            error?()
//        }
       
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
    
    
    @IBAction func onCLickStackBtn(_ sender: Any) {
        onCLickStack?()
    }
}
