//
//  findYourCarVC2.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 20/02/2023.
//

import UIKit
import MBRadioCheckboxButton

class findYourCarVC2: UIViewController,RadioButtonDelegate,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var mainview: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var option2: RadioButton!
    @IBOutlet weak var option1: RadioButton!

    @IBOutlet weak var viewGroup: UIView!
    var group3Container = RadioButtonContainer()

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addMoreOptionBtn: UIButton!
    
    var numberOfOptions:Int = 1
    
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var backBtn: UIButton!
    
    var findcarSubmitReq:findcarSubmitRequest?

    var prefferdTransmission:String?
    
    var optionsData = [" "]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupGroup3()
        backView.dropShadow()
        mainview.dropShadow()
        
        let sell = UINib(nibName: "optionsCell", bundle: nil)
        self.tableView.register(sell, forCellReuseIdentifier: "optionsCell")

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfOptions
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "optionsCell", for: indexPath) as? optionsCell {
            cell.congigureTextBox(index: indexPath.row,text: optionsData[indexPath.row])
            cell.text = { [self] (text,index) in
                if text == ""{
                    optionsData[index] = " "

                }else{
                    optionsData[index] = text

                }
            }
            cell.delBox = { [self] (index) in
                optionsData.remove(at: index)
                numberOfOptions -= 1
                tableView.reloadData()
            }
            return cell
        }
        return UITableViewCell()
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
        print("Select: ", button.title(for: .normal)!)
        if button.tag == 1 {
            prefferdTransmission = "Automatic"

        }else if button.tag == 2 {
            prefferdTransmission = "Manual"

        }
    }
    
    func radioButtonDidDeselect(_ button: RadioButton) {
        print("Deselect: ",  button.title(for: .normal)!)
    }

    @IBAction func onClickMoreOptionBtn(_ sender: Any) {
        numberOfOptions += 1
        optionsData.append(" ")
        tableView.reloadData()
    }
    
    @IBAction func onClickNextBtn(_ sender: Any) {
        
        if optionsData.isEmpty {
            AlertHelper.showAlertWithTitle(self, title: "Please Fill Atleast one Special Option.", dismissButtonTitle: "OK") { () -> Void in
                
            }
        }else{
            
            findcarSubmitReq?.transmission = prefferdTransmission ?? "N/A"
            findcarSubmitReq?.specialOptions = optionsData
            
            let vc = UIStoryboard.init(name: "FindYourCar", bundle: Bundle.main).instantiateViewController(withIdentifier: "findYourCarVC3") as? findYourCarVC3
            vc?.findcarSubmitReq = findcarSubmitReq
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }
//        if prefferdTransmission != nil && prefferdTransmission != "" && !optionsData.isEmpty{
//
//
//            findcarSubmitReq?.transmission = prefferdTransmission ?? "N/A"
//            findcarSubmitReq?.specialOptions = optionsData
//
//            let vc = UIStoryboard.init(name: "FindYourCar", bundle: Bundle.main).instantiateViewController(withIdentifier: "findYourCarVC3") as? findYourCarVC3
//            vc?.findcarSubmitReq = findcarSubmitReq
//            self.navigationController?.pushViewController(vc!, animated: true)
//        }else{
//            AlertHelper.showAlertWithTitle(self, title: "Please choose all fields.", dismissButtonTitle: "OK") { () -> Void in
//
//            }
//        }
        
       
    }
    
    @IBAction func onClickBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    
}
