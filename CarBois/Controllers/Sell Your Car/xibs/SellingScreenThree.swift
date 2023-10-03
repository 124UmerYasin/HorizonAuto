//
//  SellingScreenThree.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 01/02/2023.
//

import UIKit
import MaterialComponents

class SellingScreenThree: UITableViewCell,UITextViewDelegate {

  
    @IBOutlet weak var zipField: MDCOutlinedTextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var accidentInfoField: MDCOutlinedTextField!
    @IBOutlet weak var accidentInfoBtn: UIButton!
    
    
    @IBOutlet weak var titlInfoField: MDCOutlinedTextField!
    @IBOutlet weak var titleInfoBtn: UIButton!
    
    var onCLickNext : ((String,String,String,String,String)->())?
    
    @IBOutlet weak var listingDescriptionTextArea: UITextView!
    
    @IBOutlet weak var priceField: MDCOutlinedTextField!
    
    var onCLickAccident : (()->())?
    var onCLickTitleInfo : (()->())?
    var error : (()->())?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        addTitle(textFieldS: zipField, placeHolder: "Your Zip Code")
        addTitle(textFieldS: accidentInfoField, placeHolder: "Please Select accident info")
        addTitle(textFieldS: titlInfoField, placeHolder: "Select Title info")
        addTitle(textFieldS: priceField, placeHolder: "Price")
        
        
        
        listingDescriptionTextArea.layer.borderWidth = 1.0
        listingDescriptionTextArea.layer.borderColor = UIColor.lightGray.cgColor
        listingDescriptionTextArea.layer.cornerRadius = 5.0
        listingDescriptionTextArea.delegate = self
        listingDescriptionTextArea.textColor = .lightGray
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == .lightGray {
                textView.text = nil
                textView.textColor = .black
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
        if placeHolder == "Your Zip Code" || placeHolder == "Price"{
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {

    }
    
    
    
    @IBAction func onClickAccidentInfoBtn(_ sender: Any) {
        onCLickAccident?()
        makeNormalButtonAfterError(textFieldS: accidentInfoField)
    }
    
    @IBAction func onCLickTitleInfoBtn(_ sender: Any) {
        onCLickTitleInfo?()
        makeNormalButtonAfterError(textFieldS: titlInfoField)

    }
    
    @IBAction func onClickNext(_ sender: Any) {
        
        if zipField.text?.isEmpty ?? true {
            makeFieldError(textFieldS: zipField,placeHolder: "Zip Code")
        }else{
            if accidentInfoField.text?.isEmpty ?? true {
                makeFieldError(textFieldS: accidentInfoField,placeHolder: "Car Accident Information")
            }else{
                if titlInfoField.text?.isEmpty ?? true {
                    makeFieldError(textFieldS: titlInfoField,placeHolder: "Car Title Information")
                }else{
                    if priceField.text?.isEmpty ?? true {
                        makeFieldError(textFieldS: priceField,placeHolder: "Car Selling Price")
                    }else{
                        onCLickNext?(zipField.text ?? "N/A",listingDescriptionTextArea.text ?? "N/A",accidentInfoField.text ?? "N/A",titlInfoField.text ?? "N/A",priceField.text ?? "N/A")

                    }

                }
            }
        }
        
        
//        if zipField.text != "" && zipField.text != nil && listingDescriptionTextArea.text != "" && listingDescriptionTextArea.text != nil && accidentInfoField.text != "" && accidentInfoField.text != nil && titlInfoField.text != "" && priceField.text != nil {
//            onCLickNext?(zipField.text ?? "N/A",listingDescriptionTextArea.text ?? "N/A",accidentInfoField.text ?? "N/A",titlInfoField.text ?? "N/A",priceField.text ?? "N/A")
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
    
}
