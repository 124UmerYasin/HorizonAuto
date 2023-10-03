//
//  SellYourCarVCTwo.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 31/01/2023.
//

import UIKit
import FittedSheets

class SellYourCarVCTwo: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tbv: UIView!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var backView: UIView!
    
    var sellcarSubmitReq:sellcarSubmitRequest?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
                
        tbv.dropShadow()
        backView.dropShadow()
        
        let sell = UINib(nibName: "SellingScreenTwo", bundle: nil)
        self.tableView.register(sell, forCellReuseIdentifier: "SellingScreenTwo")

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SellingScreenTwo", for: indexPath) as? SellingScreenTwo {
            cell.onCLickNext = { [self] (tansmission,options,purchasefrom,email,time) in
                sellcarSubmitReq?.transmission = tansmission
                sellcarSubmitReq?.specialOptions = options
                sellcarSubmitReq?.sellerType = purchasefrom
                sellcarSubmitReq?.sellerEmail = email
                sellcarSubmitReq?.saleTimeline = time
                moveToNextVC()
            }
            cell.onCLickTenure = { [self] () in
                presentSheetTimeLine { tenure in
                    cell.timeLbl.text = tenure
                    if tenure == "In a week or less"{
                        cell.time = "Week"
                    }else if tenure == "In about a Month"{
                        cell.time = "Month"
                    }else if tenure == "In three or more months"{
                        cell.time = "Three Months"
                    }
                }
            }
            cell.error = { (errorSting) in
                AlertHelper.showAlertWithTitle(self, title: errorSting, dismissButtonTitle: "OK") { () -> Void in

                }
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func moveToNextVC(){
        let vc = UIStoryboard.init(name: "SellYourCar", bundle: Bundle.main).instantiateViewController(withIdentifier: "SellYouCarVCThree") as? SellYouCarVCThree
        vc?.sellcarSubmitReq = sellcarSubmitReq
        self.navigationController?.pushViewController(vc!, animated: true)

    }
    
    @IBAction func onClickBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
}
