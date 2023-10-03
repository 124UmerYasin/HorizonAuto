//
//  ChooseTrimVC.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 10/02/2023.
//

import UIKit

class ChooseTrimVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var trimTableView: UITableView!
    
    var tableData : [CarMakeModelTrimDefinition]?
    let numberFormatter = NumberFormatter()

    var trimId:Int = -1
    var trimName:String = ""
    var isSelected:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        trimTableView.dataSource = self
        trimTableView.delegate = self
        trimTableView.register(UINib(nibName: "SellTrimCell", bundle: nil), forCellReuseIdentifier: "SellTrimCell")
        isSelected = false
    }
    
    func addTrimData(trimData:[CarMakeModelTrimDefinition]){
        tableData = trimData
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SellTrimCell", for: indexPath) as? SellTrimCell {
            
            numberFormatter.numberStyle = .currency
            numberFormatter.currencySymbol = "$"
            numberFormatter.minimumFractionDigits = 0
            cell.pricelbl.text = numberFormatter.string(from: NSNumber(value: tableData?[indexPath.row].average ?? 0))
            
            cell.trimName.text = tableData?[indexPath.row].carTrim ?? "N/A"
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        trimId = tableData?[indexPath.row].id ?? -1
        isSelected = true
        trimName = tableData?[indexPath.row].carTrim ?? "N/A"
        dismiss(animated: true)
    }
    
}
