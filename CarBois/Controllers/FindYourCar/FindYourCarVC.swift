//
//  FindYourCarVC.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 16/02/2023.
//

import UIKit
import FittedSheets

class FindYourCarVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var BrowseBuyListoing: UIButton!
    
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var filterView: UIView!
    
    @IBOutlet weak var tableViewBack: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var allowSearch:Bool = true

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
    
    var findcarSubmitReq:findcarSubmitRequest?

    var onClickBrowseListing : (()->())?
    var isFromWhere:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        findcarSubmitReq = findcarSubmitRequest(carModelId: -1, carMakeId: -1, carGenerationId: -1, carSubGenId: -1, carTrimDefId: -1, exteriorColor: "", interiorColor: "", minMileage: "", maxMileage: "", transmission: "", specialOptions: [String](), buyerWillingToPurchaseFrom: "", email: "", purchaseTimeline: "", buyerLocation: "")
        // Do any additional setup after loading the view.#imageLiteral(resourceName: "increasing value arrow.png")
        backView.dropShadow()
        tableViewBack.dropShadow()
        filterView.dropShadow()
    
        let sell = UINib(nibName: "FindCarScreenOne", bundle: nil)
        self.tableView.register(sell, forCellReuseIdentifier: "FindCarScreenOne")

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if allowSearch{
            filterButton.isUserInteractionEnabled = true
        }else{
            filterButton.isUserInteractionEnabled = false
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FindCarScreenOne", for: indexPath) as? FindCarScreenOne {
            cell.addDataAfterSearch(make: makeName, model: modelname, gen: genname, subgen: subgenname, trims: trimname)
            if allowSearch{
                cell.atackButton.isUserInteractionEnabled = true
            }else{
                cell.atackButton.isUserInteractionEnabled = false
            }
            cell.onCLickNext = { [self] (ext,int,minmila,maxmila) in
                if makeName != "" && modelname != "" && genname != "" && subgenname != "" && trimname != ""{
                    
                    if Int(minmila) ?? 0 < Int(maxmila) ?? 0{
                        findcarSubmitReq?.carMakeId = makeId
                        findcarSubmitReq?.carModelId = modelId
                        findcarSubmitReq?.carGenerationId = genId
                        findcarSubmitReq?.carSubGenId = subgenId
                        findcarSubmitReq?.carTrimDefId = trimId
                        
                        findcarSubmitReq?.exteriorColor = ext
                        findcarSubmitReq?.interiorColor = int
                        findcarSubmitReq?.minMileage = minmila
                        findcarSubmitReq?.maxMileage = maxmila


                        moveToNextVC()
                    }else{
                        AlertHelper.showAlertWithTitle(self, title: "Maximum Mileage should be Greater then Minimum Mileage.", dismissButtonTitle: "OK") { () -> Void in

                        }
                    }
                    
                   
                }
                
            }
            
            cell.error = { () in
                AlertHelper.showAlertWithTitle(self, title: "Please choose all fields.", dismissButtonTitle: "OK") { () -> Void in

                }
            }
            
            cell.onCLickStack = { [self] () in
                presentSheet()
            }
            return cell
        }
        return UITableViewCell()
    }

    @IBAction func onCLickBackBtn(_ sender: Any) {
        self.navigationController?.dismiss(animated: true)
    }
    
    @IBAction func onCLickBrowseBtn(_ sender: Any) {
        if isFromWhere == "Home"{
            self.navigationController?.dismiss(animated: true)
            onClickBrowseListing?()
        }else{
            self.navigationController?.dismiss(animated: true)

        }
    }
    
    @IBAction func onCLickFilterBtn(_ sender: Any) {
        AppUtility.isfromBuy = true
        AppUtility.isfromHome = false

        presentSheet()
    }
    
    
    func moveToNextVC(){
        let vc = UIStoryboard.init(name: "FindYourCar", bundle: Bundle.main).instantiateViewController(withIdentifier: "findYourCarVC2") as? findYourCarVC2
        vc?.findcarSubmitReq = findcarSubmitReq
        self.navigationController?.pushViewController(vc!, animated: true)

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
            
            tableView.reloadData()
        }
        
        sheetController.didDismiss = { vc in
        }
        self.present(sheetController, animated: true, completion: nil)
    }
}


struct findcarSubmitRequest:Codable{
    
    var UUID:String?
    var carModelId : Int
    var carMakeId: Int
    var carGenerationId: Int
    var carSubGenId: Int
    var carTrimDefId: Int
    var exteriorColor: String
    var interiorColor: String
    var minMileage: String
    var maxMileage: String
    var transmission: String
    var specialOptions : [String]
    var buyerWillingToPurchaseFrom: String
    var email: String
    var purchaseTimeline: String
    var buyerLocation: String
    var price:Int?
}
