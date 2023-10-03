//
//  SellingScreenTwo.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 31/01/2023.
//

import UIKit
import MBRadioCheckboxButton
import SkyFloatingLabelTextField
import AAPickerView
import MaterialComponents.MaterialTextControls_OutlinedTextFields


class SellingScreenTwo: UITableViewCell,RadioButtonDelegate,UITableViewDataSource,UITableViewDelegate {
    
   
    @IBOutlet weak var option1: RadioButton!
    @IBOutlet weak var viewGroup: UIView!
    @IBOutlet weak var option2: RadioButton!
    var group3Container = RadioButtonContainer()
    
    var onCLickNext : ((String,[String],String,String,String)->())?

    @IBOutlet weak var timeLbl: MDCOutlinedTextField!
    @IBOutlet weak var emailField: MDCOutlinedTextField!
    
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var option3: RadioButton!
    @IBOutlet weak var option4: RadioButton!
    @IBOutlet weak var viewGroup2: UIView!
    var group2Container = RadioButtonContainer()

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var addmoreBtn: UIButton!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!

    var numberOfRows:Int = 1
    
    @IBOutlet weak var tenurelbl: UILabel!
    var onCLickTenure : (()->())?

    
    @IBOutlet weak var noBtn: UIButton!
    @IBOutlet weak var yeBtn: UIButton!
    
    @IBOutlet weak var listingTimLbl: UILabel!
    
    var time:String?
    var pruchaseFrom:String?
    var transmission:String?
    
    var tableviewData = [" "]
    var error : ((String)->())?

    
    @IBOutlet weak var listineLineHeight: NSLayoutConstraint!
    @IBOutlet weak var timeLabelHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupGroup3()
        setupGroup2()
        addTitle(textFieldS: timeLbl, placeHolder: "Please select listing timeline ")
        addTitle(textFieldS: emailField, placeHolder: "SuperCoolGuy@horizonauto.com")
        
        let sell = UINib(nibName: "optionsCell", bundle: nil)
        self.tableview.register(sell, forCellReuseIdentifier: "optionsCell")

        tableview.delegate = self
        tableview.dataSource = self
        tableview.rowHeight = UITableView.automaticDimension
        yeBtn.sendActions(for: .touchUpInside)

    }
    
    override func layoutSubviews() {
        noBtn.dropShadow()
        yeBtn.dropShadow()
        listineLineHeight.constant = 0
        timeLabelHeight.constant = 0
        tableViewHeight.constant = CGFloat(numberOfRows * 60)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "optionsCell", for: indexPath) as? optionsCell {
            cell.congigureTextBox(index: indexPath.row,text: tableviewData[indexPath.row])
            cell.text = { [self] (text,index) in
                if text == ""{
                    tableviewData[index] = " "

                }else{
                    tableviewData[index] = text

                }
            }
            cell.delBox = { [self] (index) in
                tableviewData.remove(at: index)
                numberOfRows -= 1
                layoutSubviews()
                tableView.reloadData()
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
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
        textFieldS.font = UIFont.systemFont(ofSize: 15)
        textFieldS.autocapitalizationType = .none
        textFieldS.autocorrectionType = .no
        textFieldS.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

    }
    
    @objc func textFieldDidChange(_ textField: MDCOutlinedTextField) {
        if !(textField.text?.isEmpty ?? true){
            makeNormalButtonAfterError(textFieldS: textField)
        }

    }
    
    func setupGroup2() {
        
        group2Container.addButtons([option3, option4])
        group2Container.delegate = self
        group2Container.selectedButton = option3
        
        option3.radioCircle = RadioButtonCircleStyle.init(outerCircle: 20, innerCircle: 15, outerCircleBorder: 2)
        option4.radioCircle = RadioButtonCircleStyle.init(outerCircle: 20, innerCircle: 15, outerCircleBorder: 2)

        option3.radioButtonColor = RadioButtonColor(active: UIColor(named: "AppNewColor")!, inactive: UIColor.gray)
        option4.radioButtonColor = RadioButtonColor(active: UIColor(named: "AppNewColor")!, inactive: UIColor.gray)
    }
   
    func setupGroup3() {
        group3Container.addButtons([option1, option2])
        group3Container.delegate = self
        group3Container.selectedButton = option1
        option1.radioCircle = RadioButtonCircleStyle.init(outerCircle: 20, innerCircle: 15, outerCircleBorder: 2)
        option2.radioCircle = RadioButtonCircleStyle.init(outerCircle: 20, innerCircle: 15, outerCircleBorder: 2)
        option1.radioButtonColor = RadioButtonColor(active: UIColor(named: "AppNewColor")!, inactive: UIColor.gray)
        option2.radioButtonColor = RadioButtonColor(active: UIColor(named: "AppNewColor")!, inactive: UIColor.gray)
    }
    
    func radioButtonDidSelect(_ button: RadioButton) {
        if button.tag == 1 || button.tag == 2{
            if button.tag == 1 {
                transmission = "Automatic"

            }else if button.tag == 1 {
                transmission = "Manual"

            }

        }else if button.tag == 3 || button.tag == 4 || button.tag == 5{
            if button.tag == 3 {
                pruchaseFrom = "Dealer"
            }else if button.tag == 4 {
                pruchaseFrom = "Private"
            }else if button.tag == 5 {
                pruchaseFrom = "Any"
            }
        }
        print("Select: ", button.title(for: .normal)!)
    }
    
    func radioButtonDidDeselect(_ button: RadioButton) {
        print("Deselect: ",  button.title(for: .normal)!)
    }
    
    @IBAction func onClickNextButton(_ sender: Any) {
        
        if emailField.text?.isEmpty ?? true {
           makeFieldError(textFieldS: emailField,placeHolder: "Email Address")
        }else{
            if isValidEmail(email: emailField.text ?? ""){
                if tableviewData.isEmpty {
                    error?("Please Fill Atleat one Special Option.")
                }else{
                    onCLickNext?(transmission ?? "N/A",tableviewData,pruchaseFrom ?? "N/A",emailField.text ?? "N/A",time ?? "N/A")
                }
            }else{
                makeFieldError(textFieldS: emailField,placeHolder: "Email Address")

            }
        }
        
//        if time != "" && time != nil && pruchaseFrom != nil && pruchaseFrom != nil && transmission != nil && transmission != nil && !tableviewData.isEmpty && emailField.text != nil && emailField.text != "" {
//            onCLickNext?(transmission ?? "N/A",tableviewData,pruchaseFrom ?? "N/A",emailField.text ?? "N/A",time ?? "N/A")
//        }else{
//            error?()
//        }
    }
    
    
    @IBAction func onClickAddmoreBtn(_ sender: Any) {
        numberOfRows += 1
        tableviewData.append(" ")
        tableview.reloadData()
        layoutIfNeeded()
       layoutSubviews()
        super.layoutSubviews()

    }
    
    @IBAction func onClickSelectTenure(_ sender: Any) {
        onCLickTenure?()
    }
    
    @IBAction func onCLickNobtn(_ sender: Any) {
        noBtn.backgroundColor = UIColor(named: "AppNewColor")!
        noBtn.setTitleColor(.white, for: .normal)
        
        yeBtn.backgroundColor = .white
        yeBtn.setTitleColor(.black, for: .normal)
        
        listingTimLbl.isHidden = false
        timeLbl.isHidden = false
        
        
        listineLineHeight.constant = 24
        timeLabelHeight.constant = 30
        time = ""
        onCLickTenure?()

    }
    
    @IBAction func onCLickYesBtn(_ sender: Any) {
        noBtn.backgroundColor = .white
        noBtn.setTitleColor(.black, for: .normal)

        yeBtn.backgroundColor = UIColor(named: "AppNewColor")!
        yeBtn.setTitleColor(.white, for: .normal)
        
        listineLineHeight.constant = 0
        timeLabelHeight.constant = 0
        
        listingTimLbl.isHidden = true
        timeLbl.isHidden = true
        time = "Immediate"
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
