//
//  sellyourCarVC.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 23/01/2023.
//

import UIKit
import FittedSheets
import PUGifLoading

class sellyourCarVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var SellYouCarTable: UITableView!
    @IBOutlet weak var filterView: UIView!
    
    
    @IBOutlet weak var filterButton: UIButton!
    
    
    var makeName = ""
    var modelname = ""
    var genname = ""
    var subgenname = ""
    var trimname = ""
    
    var makeId = -1
    var modelId = -1
    var genId = -1
    var subgenId = -1
    var trimId = -1
    
    var sellcarSubmitReq:sellcarSubmitRequest?
    private var sellyourCarVM = SellYouCarHomeVM()
    let loading = PUGIFLoading()

    var allowSearch:Bool = true
    
    var onClickBrowseListing : (()->())?
    var isFromWhere:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sellcarSubmitReq = sellcarSubmitRequest(carModelId: -1, carMakeId: -1, carGenerationId: -1, carSubGenId: -1, carTrimDefId: -1, vin: "", carYear: "", carMileage: "", exteriorColor: "", interiorColor: "", transmission: "", specialOptions: [String](), sellerType: "", carfax_accident_info: "", title_info: "", sellerEmail: "", saleTimeline: "", sellerLocation: "", listing_description: "",price: 0)
        
        if(AppUtility.isUUidPresent){
            AppUtility.selectedSellFilter?.make = makeId
            AppUtility.selectedSellFilter?.model = modelId
            AppUtility.selectedSellFilter?.gen = genId
            AppUtility.selectedSellFilter?.subgen = subgenId
            AppUtility.selectedSellFilter?.trim = trimId
        }
        
//        if AppUtility.isUUidPresent {
//            AppUtility.selectedSellFilter = AppUtility.selectedSellFilterHome
//            if AppUtility.dashboardFilterData?.data?.carMake != nil {
//                for (index, element) in AppUtility.dashboardFilterData!.data!.carMake!.enumerated() {
//                    if element.id == AppUtility.selectedSellFilterHome?.make ?? 0 {
//                        makeName = element.make ?? ""
//                        for (index2, element2) in AppUtility.dashboardFilterData!.data!.carMake![index].models!.enumerated() {
//                            if element2.id == AppUtility.selectedSellFilterHome?.model ?? 0 {
//                                modelname = element2.model ?? ""
//                                if AppUtility.dashboardFilterData?.data?.carMake?[index].models?[index2].carGenerations != nil {
//                                    for (index3, element3) in AppUtility.dashboardFilterData!.data!.carMake![index].models![index2].carGenerations!.enumerated() {
//                                        if element3.id == AppUtility.selectedSellFilterHome?.gen ?? 0 {
//                                            genname = element3.generation ?? ""
//                                            if AppUtility.dashboardFilterData?.data?.carMake?[index].models?[index2].carGenerations![index3].carSubGenerations != nil {
//                                                for (index4, element4) in AppUtility.dashboardFilterData!.data!.carMake![index].models![index2].carGenerations![index3].carSubGenerations!.enumerated() {
//                                                    if element4.id == AppUtility.selectedSellFilterHome?.subgen ?? 0 {
//                                                        subgenname = element4.subGeneration ?? ""
//                                                        if AppUtility.dashboardFilterData?.data?.carMake?[index].models?[index2].carGenerations![index3].carSubGenerations![index4].trimDefinition != nil {
//                                                            for (index5, element5) in AppUtility.dashboardFilterData!.data!.carMake![index].models![index2].carGenerations![index3].carSubGenerations![index4].trimDefinition!.enumerated() {
//                                                                if element5.id == AppUtility.selectedSellFilterHome?.trim ?? 0 {
//                                                                    trimname = element5.carTrim ?? ""
//                                                                    print(index5)
//                                                                }
//                                                            }
//                                                        }
//                                                    }
//                                                }
//                                            }
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
        
        // Do any additional setup after loading the view.
        filterView.dropShadow()
        tableView.dropShadow()
        backView.dropShadow()
        
        let sell = UINib(nibName: "SellingScreenOne", bundle: nil)
        self.SellYouCarTable.register(sell, forCellReuseIdentifier: "SellingScreenOne")

        SellYouCarTable.delegate = self
        SellYouCarTable.dataSource = self
        SellYouCarTable.rowHeight = UITableView.automaticDimension
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if allowSearch{
            filterButton.isUserInteractionEnabled = true
        }else{
            filterButton.isUserInteractionEnabled = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SellingScreenOne", for: indexPath) as? SellingScreenOne {
            cell.addDataAfterSearch(make: makeName, model: modelname, gen: genname, subgen: subgenname, trims: trimname)
            if allowSearch{
                cell.stackButoon.isUserInteractionEnabled = true
            }else{
                cell.stackButoon.isUserInteractionEnabled = false
            }
            cell.onCLickNext = { [self] (vin,year,mileage,intcolor,extcolor) in
                if makeName != "" && modelname != "" && genname != "" && subgenname != "" && trimname != ""{
                    
                    sellcarSubmitReq?.carMakeId = makeId
                    sellcarSubmitReq?.carModelId = modelId
                    sellcarSubmitReq?.carGenerationId = genId
                    sellcarSubmitReq?.carSubGenId = subgenId
                    sellcarSubmitReq?.carTrimDefId = trimId
                    
                    sellcarSubmitReq?.vin = vin
                    sellcarSubmitReq?.carYear = year
                    sellcarSubmitReq?.carMileage = mileage
                    sellcarSubmitReq?.interiorColor = intcolor
                    sellcarSubmitReq?.exteriorColor = extcolor


                    
                    moveToNextVC()
                }else{
                    AlertHelper.showAlertWithTitle(self, title: "Please choose all fields.", dismissButtonTitle: "OK") { () -> Void in
                    }
                }
            }
            cell.onerror = { (fieldName) in
                AlertHelper.showAlertWithTitle(self, title: "\(fieldName) is required.", dismissButtonTitle: "OK") { () -> Void in

                }
            }
            cell.onCLickyear = { [self] () in
                presentSheetYear { val in
                    cell.addValuetoCarYear(year: val)
                }
            }
            cell.stackBtn = { [self] () in
                presentSheet()
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func moveToNextVC(){
        let vc = UIStoryboard.init(name: "SellYourCar", bundle: Bundle.main).instantiateViewController(withIdentifier: "SellYourCarVCTwo") as? SellYourCarVCTwo
        vc?.sellcarSubmitReq = sellcarSubmitReq
        self.navigationController?.pushViewController(vc!, animated: true)

    }
    
    @IBAction func onCLickBackButton(_ sender: Any) {
        self.navigationController?.dismiss(animated: true)
    }
    
    @IBAction func onCLickBrowseWantTOListing(_ sender: Any) {
        if isFromWhere == "Home"{
            self.navigationController?.dismiss(animated: true)
            onClickBrowseListing?()
        }else{
            self.navigationController?.dismiss(animated: true)

        }

    }
    
    @IBAction func onClickFilterButton(_ sender: Any) {
        AppUtility.isfromBuy = false
        AppUtility.isfromHome = false

        presentSheet()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 850
    }
    
    func presentSheet(){

        
        let controller = UIStoryboard(name: "SellYourCar", bundle: nil).instantiateViewController(withIdentifier: "SellYourCarSearchVC")
        let sheetController = SheetViewController(
            controller: controller,
            sizes: [.percent(0.90)])
        
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
        
        let vc = sheetController.childViewController as! SellYourCarSearchVC
        vc.onCLickSubmit = { [self] text in
            
            makeName = vc.makeName ?? "N/A"
            modelname = vc.modelName ?? "N/A"
            genname = vc.genName ?? "N/A"
            subgenname = vc.subGenName ?? "N/A"
            trimname = vc.trimName ?? "N/A"
            
            makeId = vc.makeID ?? -1
            modelId = vc.modelID ?? -1
            genId = vc.genID ?? -1
            subgenId = vc.subGenID ?? -1
            trimId = vc.trimID ?? -1
            
            SellYouCarTable.reloadData()
        }
        
        sheetController.didDismiss = { vc in
        }
        self.present(sheetController, animated: true, completion: nil)
    }
    
    
    func presentSheetYear(completion: @escaping (String) -> Void){

        
        let controller = UIStoryboard(name: "SellYourCar", bundle: nil).instantiateViewController(withIdentifier: "DetailSearchVC")
        let sheetController = SheetViewController(
            controller: controller,
            sizes: [.percent(0.90)])
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
        let req = getyearReq(id: subgenId)
        
        showLoader(loader: loading)
        sellyourCarVM.getYears(requestModel: req) { [self] result in
            switch result{
                
            case .success(let res):
                print(res)
                let year = Calendar.current.component(.year, from: Date())
                let arr2 = Array(Int(res.data?.minYear ?? 1970)...Int(res.data?.maxYear ?? year))
                
                var searchData = [dataForDetailSearch]()
                for item in arr2 {
                    searchData.append(dataForDetailSearch(name: "\(item)" , id: -1, index: 0))
                }
                
                vc.addyears(carMake: searchData, title: "Choose Year")
                hideLoader(loader: loading)
                
                sheetController.didDismiss = { vc in
                    let vc = vc.childViewController as! DetailSearchVC
                    completion(vc.selectedValue ?? "2023")
                    
                }
                self.present(sheetController, animated: true, completion: nil)
                
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                }
                hideLoader(loader: loading)
            }
        }
       
        
       
    }
}

struct sellcarSubmitRequest:Codable{
    
    var UUID:String?
    var carModelId : Int
    var carMakeId: Int
    var carGenerationId: Int
    var carSubGenId: Int
    var carTrimDefId: Int
    var vin: String
    var carYear: String
    var carMileage: String
    var exteriorColor: String
    var interiorColor: String
    var transmission: String
    var specialOptions : [String]
    var sellerType: String
    var carfax_accident_info: String
    var title_info: String
    var sellerEmail: String
    var saleTimeline: String
    var sellerLocation: String
    var listing_description: String
    var price: Int

}
