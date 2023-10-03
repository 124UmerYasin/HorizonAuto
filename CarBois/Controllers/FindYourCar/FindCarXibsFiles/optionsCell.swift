//
//  optionsCell.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 20/02/2023.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class optionsCell: UITableViewCell,UITextFieldDelegate {

    @IBOutlet weak var delimage: UIImageView!
    @IBOutlet weak var delBtn: UIButton!
    @IBOutlet weak var textField: MDCOutlinedTextField!
    var text : ((String,Int)->())?
    var delBox : ((Int)->())?

    @IBOutlet weak var delWidth: NSLayoutConstraint!
    var index:Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addTitle(textFieldS: textField, placeHolder: "Special Options")
        textField.delegate = self
       
    }
    
    func congigureTextBox(index:Int,text:String){
        self.index = index
        self.textField.text = text
        if index == 0 {
            delBtn.isHidden = true
            delimage.isHidden = true
            delWidth.constant = 0
        }else{
            delBtn.isHidden = false
            delimage.isHidden = false
            delWidth.constant = 24

        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        text?(textField.text ?? "N/A",index ?? -1)
    }
    
    
    
    @IBAction func onClickDelBtn(_ sender: Any) {
        delBox?(index ?? -1)
    }
}
