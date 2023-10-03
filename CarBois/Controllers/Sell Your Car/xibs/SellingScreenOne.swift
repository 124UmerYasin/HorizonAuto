//
//  SellingScreenOne.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 23/01/2023.
//

import UIKit
import MBRadioCheckboxButton
import SkyFloatingLabelTextField
import FittedSheets
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class SellingScreenOne: UITableViewCell,UITextFieldDelegate{
    
    
    @IBOutlet weak var stackButoon: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var vinField: MDCOutlinedTextField!
    @IBOutlet weak var carYearField: MDCOutlinedTextField!
    @IBOutlet weak var carMileageField: MDCOutlinedTextField!
    @IBOutlet weak var carExteriorField: MDCOutlinedTextField!
    @IBOutlet weak var carInteriorField: MDCOutlinedTextField!
    
    var onCLickNext : ((String,String,String,String,String)->())?
    var onCLickyear : (()->())?
    var onerror : ((String)->())?
    var stackBtn: (()->())?

    @IBOutlet weak var modelCell: UIView!
    @IBOutlet weak var makeCell: UIView!
    @IBOutlet weak var genCell: UIView!
    @IBOutlet weak var subGenCell: UIView!
    @IBOutlet weak var trimCell: UIView!
    
    @IBOutlet weak var carFieldLbl: UILabel!
    
    @IBOutlet weak var subgenlbl: UILabel!
    @IBOutlet weak var makelbl: UILabel!
    @IBOutlet weak var trimlbl: UILabel!
    @IBOutlet weak var genlbl: UILabel!
    @IBOutlet weak var modellbl: UILabel!
    
    @IBOutlet weak var stackViewHeigntConstant: NSLayoutConstraint!
    
    @IBOutlet weak var detailView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        modelCell.dropShadow2()
        makeCell.dropShadow2()
        genCell.dropShadow2()
        subGenCell.dropShadow2()
        trimCell.dropShadow2()

        addTitle(textFieldS: vinField, placeHolder: "Vehicle Identification Number (VIN)")
        addTitle(textFieldS: carYearField, placeHolder: "Please Select Car Year")
        addTitle(textFieldS: carMileageField, placeHolder: "Please Enter Your Car Mileage")
        addTitle(textFieldS: carExteriorField, placeHolder: "Please Enter the Exterior Color")
        addTitle(textFieldS: carInteriorField, placeHolder: "Please Enter the Interior Color ")

    }
    
    func addValuetoCarYear(year:String){
        carYearField.text = year
        makeNormalButtonAfterError(textFieldS: carYearField)
    }
    
    func addDataAfterSearch(make:String,model:String,gen:String,subgen:String,trims:String){
        if make == "" && model == "" && gen == "" && subgen == "" && trims == "" {
            stackViewHeigntConstant.constant = 0
            detailView.isHidden = true

        }else{
            stackViewHeigntConstant.constant = 245
            detailView.isHidden = false

            modellbl.text = model
            makelbl.text = make
            genlbl.text = gen
            subgenlbl.text = subgen
            trimlbl.text = trims
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
        if placeHolder == "Please Select Car Year" || placeHolder == "Please Enter Your Car Mileage"{
            textFieldS.keyboardType = .numberPad
        }else{
            textFieldS.keyboardType = .alphabet
        }
        
        textFieldS.delegate = self
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
    
    @IBAction func onClickNext(_ sender: Any) {
        
        if vinField.text?.isEmpty ?? true {
           makeFieldError(textFieldS: vinField,placeHolder: "VIN Number")

//            onerror?("Vin")
        }else{
            if carYearField.text?.isEmpty ?? true {
                makeFieldError(textFieldS: carYearField,placeHolder: "Car Year")
//                onerror?("Car Year")
            }else{
                if carMileageField.text?.isEmpty ?? true {
                    makeFieldError(textFieldS: carMileageField,placeHolder: "Car Mileage")
//                    onerror?("Car Mileage")
                }else{
                    if carInteriorField.text?.isEmpty ?? true {
                        makeFieldError(textFieldS: carInteriorField,placeHolder: "Car Interior Color")
//                        onerror?("Enterior Color")
                    }else{
                        if carExteriorField.text?.isEmpty ?? true {
                            makeFieldError(textFieldS: carExteriorField,placeHolder: "Car exterior Color")
//                            onerror?("Interior Color")
                        }else{
                            onCLickNext?(vinField.text ?? "N/A",carYearField.text ?? "N/A",carMileageField.text ?? "N/A",carInteriorField.text ?? "N/A",carExteriorField.text ?? "N/A")
                        }
                    }
                }
            }
        }
        
    }

    @IBAction func onClickSelectYear(_ sender: Any) {
        onCLickyear?()
    }
    
    
    
    @IBAction func onCLickStackBtn(_ sender: Any) {
        stackBtn?()
    }
    
}
