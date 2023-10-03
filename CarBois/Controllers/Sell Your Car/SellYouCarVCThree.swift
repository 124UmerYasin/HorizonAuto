//
//  SellYouCarVCThree.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 01/02/2023.
//

import UIKit
import FittedSheets
import PUGifLoading

class SellYouCarVCThree: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tbv: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var backView: UIView!
    
    var sellcarSubmitReq:sellcarSubmitRequest?
    private var sellyourCarVM = SellYouCarHomeVM()
    let loading = PUGIFLoading()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dropShadow()
        backView.dropShadow()
        tbv.dropShadow()
        let sell = UINib(nibName: "SellingScreenThree", bundle: nil)
        self.tableView.register(sell, forCellReuseIdentifier: "SellingScreenThree")

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SellingScreenThree", for: indexPath) as? SellingScreenThree {
            cell.onCLickNext = { [self] (zip,description,accident,title,price) in
                sellcarSubmitReq?.sellerLocation = zip
                sellcarSubmitReq?.listing_description = description
                sellcarSubmitReq?.carfax_accident_info = accident
                sellcarSubmitReq?.title_info = title
                sellcarSubmitReq?.price = Int(price) ?? 0
                if AppUtility.isUUidPresent{
                    sellcarSubmitReq?.UUID = AppUtility.uuid
                    AppUtility.messageToShowAfterForm = "Congrats you're on your way to finding your dream car!"
                    contactBuyer(req: sellcarSubmitReq!)
                }else{
                    callapiForSave(req: sellcarSubmitReq!)
                    AppUtility.messageToShowAfterForm = "Congrats, you're on your way to selling your car for a great price!"

                }
            }
            cell.onCLickAccident = { () in
                self.presentSheetCarFaxinfo { title in
                    cell.accidentInfoField.text = title
                }
                
            }
            cell.onCLickTitleInfo = { [self] () in
                presentSheettitleInfo { title in
                    cell.titlInfoField.text = title
                }
            }
            
            cell.error = { () in
                AlertHelper.showAlertWithTitle(self, title: "Please choose all fields.", dismissButtonTitle: "OK") { () -> Void in

                }
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func moveToNextVC(){
        let vc = UIStoryboard.init(name: "SellYourCar", bundle: Bundle.main).instantiateViewController(withIdentifier: "SellYourCarVCFour") as? SellYourCarVCFour
        self.navigationController?.pushViewController(vc!, animated: true)

    }
   

    @IBAction func onCLickBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func presentSheetCarFaxinfo(completion: @escaping (String) -> Void){

        
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
        
        let arr2 = ["Accident", "No Accident", "Unkown", "No Carfax Available"]
        
        
        var searchData = [dataForDetailSearch]()
        for item in arr2 {
            searchData.append(dataForDetailSearch(name: "\(item)" , id: -1, index: 0))
        }
        vc.addyears(carMake: searchData, title: "Choose CarFaxInfo")
        
        sheetController.didDismiss = { vc in
            let vc = vc.childViewController as! DetailSearchVC
            completion(vc.selectedValue ?? "Accident")
        }
        self.present(sheetController, animated: true, completion: nil)
    }
    
    
    func presentSheettitleInfo(completion: @escaping (String) -> Void){

        
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
        let arr2 = ["Clean Title","Salvage Title","Flood Title","Rebuilt Title","No title info available"]
        
        var searchData = [dataForDetailSearch]()
        for item in arr2 {
            searchData.append(dataForDetailSearch(name: "\(item)" , id: -1, index: 0))
        }
        vc.addyears(carMake: searchData, title: "Choose Title")
        
        sheetController.didDismiss = { vc in
            let vc = vc.childViewController as! DetailSearchVC
            completion(vc.selectedValue ?? "Clean Title")
        }
        self.present(sheetController, animated: true, completion: nil)
    }
    
    
    func callapiForSave(req:sellcarSubmitRequest){
        showLoader(loader: loading)
        sellyourCarVM.submitForSalelisting(requestModel: req) { [self] result in
            switch result{
            case .success(let result):
//               print(result)
//                AlertHelper.showAlertWithTitle(self, title: result.data?.listingId ?? "N/A", dismissButtonTitle: "OK") { () -> Void in
//
//                }
                hideLoader(loader: loading)
                getUploadLink(id: result.data?.listing_id ?? "N/A")
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                }
                hideLoader(loader: loading)

            }
        }
    }
    
    func contactBuyer(req:sellcarSubmitRequest){
        showLoader(loader: loading)
        sellyourCarVM.contactBuyer(requestModel: req) { [self] result in
            switch result{
            case .success(let result):
//                AlertHelper.showAlertWithTitle(self, title: result.data?.createdListingResponseId ?? "N/A", dismissButtonTitle: "OK") { () -> Void in
//
//                }
                hideLoader(loader: loading)
                getUploadLink(id: result.data?.createdListingResponseId ?? "N/A")

            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                }
                hideLoader(loader: loading)

            }
        }
    }
    
    func getUploadLink(id:String){
        let req = getUploadLinkRequest(UUID: id)
        sellyourCarVM.getUploadLink(requestModel: req) { [self] result in
            switch result{
            case .success(let result):
//                AlertHelper.showAlertWithTitle(self, title: result.data?.url ?? "N/A", dismissButtonTitle: "OK") { () -> Void in
//
//                }
                hideLoader(loader: loading)
                let vc = UIStoryboard.init(name: "SellYourCar", bundle: Bundle.main).instantiateViewController(withIdentifier: "SellYourCarVCFour") as? SellYourCarVCFour
                vc?.link = result.data?.url ?? "N/A"
                self.navigationController?.pushViewController(vc!, animated: true)
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                }
                hideLoader(loader: loading)

            }
        }
    }
}
