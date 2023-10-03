//
//  SellYouCarVCHome.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 21/02/2023.
//

import UIKit
import FittedSheets
import PUGifLoading

class SellYouCarVCHome: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var feedbackBtn: UIButton!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var creatListingBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var filterView: UIView!
    
    private var sellyourCarVM = SellYouCarHomeVM()

    var listingData : WantToBuyListingModelDataClass?
    var listingdataCount = 0
    
    let loading = PUGIFLoading()

    let numberFormatter = NumberFormatter()

    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        filterView.dropShadow()
        
        collectionView.register(UINib(nibName: "findCarCell", bundle: nil), forCellWithReuseIdentifier: "findCarCell")
        collectionView.register(UINib(nibName: "searchWantToBuyAndSell", bundle: nil), forCellWithReuseIdentifier: "searchWantToBuyAndSell")

        collectionView.dataSource = self
        collectionView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.addimage(_:)), name: NSNotification.Name(rawValue: "navigateToModelAnalysis"), object: nil)

          
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if AppUtility.isFromNavigationProg!{
//            let req = wantToBuyListingRequest(carModelId: AppUtility.selectedBuyFilter?.model ?? -1, carMakeId: AppUtility.selectedBuyFilter?.make ?? -1, carGenerationId: AppUtility.selectedBuyFilter?.gen ?? -1, carSubGenerationId: AppUtility.selectedBuyFilter?.subgen ?? -1, trimDefinitionId: AppUtility.selectedBuyFilter?.trim ?? -1, pageLimit: 40, pageOffset: 0)
            
            var req1 = wantToBuyListingRequest(carModelId: AppUtility.selectedBuyFilter?.model ?? -1 , carMakeId: AppUtility.selectedBuyFilter?.make ?? -1 ,sub_gens_and_trim_defs: [sub_gens_and_trim_defs](), pageLimit: 20,pageOffset: 0)

            var trimAndSubGen = sub_gens_and_trim_defs()
            if (AppUtility.selectedBuyFilter!.subgen != nil) {
                trimAndSubGen.carSubGenerationId = AppUtility.selectedBuyFilter?.subgen
            }
            if (AppUtility.selectedBuyFilter!.trim != nil) {
                trimAndSubGen.trimDefinitionId = AppUtility.selectedBuyFilter?.trim
            }
            if (AppUtility.selectedBuyFilter!.trim != nil) || (AppUtility.selectedBuyFilter!.subgen != nil) {
                req1.sub_gens_and_trim_defs?.append(trimAndSubGen)

            }
            
            callApiForListing(req: req1)
        }else{
//            let req = wantToBuyListingRequest(carModelId: AppUtility.selectedBuyFilterHome?.model ?? -1, carMakeId: AppUtility.selectedBuyFilterHome?.make ?? -1, carGenerationId: AppUtility.selectedBuyFilterHome?.gen ?? -1, carSubGenerationId: AppUtility.selectedBuyFilterHome?.subgen ?? -1, trimDefinitionId: AppUtility.selectedBuyFilterHome?.trim ?? -1, pageLimit: 40, pageOffset: 0)
//            callApiForListing(req: req)
        }
        greetingLabel.text = getTime()
        userName.text = UserDefaults.standard.string(forKey: "username")
        
    }
    
    func callApiForListing(req:wantToBuyListingRequest){
        showLoader(loader: loading)
        sellyourCarVM.getWanttoBuyListing(requestModel: req) { [self] result in
            switch result{
            case .success(let result):
                listingData = result.data
                listingdataCount = result.data?.listings?.count ?? 0
                collectionView.reloadData()
                hideLoader(loader: loading)

            case .failure(let error):
                AlertHelper.showAlertWithTitle(self, title: error.localizedDescription, dismissButtonTitle: "OK") { () -> Void in

                }
                hideLoader(loader: loading)

            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if listingdataCount == 0 {
            return 1
        }else{
            return listingdataCount
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        AppUtility.isUUidPresent = true
        AppUtility.uuid = listingData?.listings![indexPath.row].uuid ?? "N/A"
        let storyboard = UIStoryboard(name: "SellYourCar", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "sellyourCarVC") as! sellyourCarVC
        vc.allowSearch = false
        vc.makeId = listingData?.listings?[indexPath.row].carMakeId ?? -1
        vc.modelId = listingData?.listings?[indexPath.row].carModelId ?? -1
        vc.genId = listingData?.listings?[indexPath.row].carGenerationId ?? -1
        vc.subgenId = listingData?.listings?[indexPath.row].carSubGenerationId ?? -1
        vc.trimId = listingData?.listings?[indexPath.row].trimDefinitionId ?? -1
        vc.makeName = listingData?.listings?[indexPath.row].carMake ?? ""
        vc.modelname = listingData?.listings?[indexPath.row].carModel ?? ""
        vc.genname = listingData?.listings?[indexPath.row].carGeneration ?? ""
        vc.subgenname = listingData?.listings?[indexPath.row].carSubGeneration ?? ""
        vc.trimname = listingData?.listings?[indexPath.row].trimDefinition ?? ""
        AppUtility.selectedSellFilterHome?.gen = listingData?.listings?[indexPath.row].carGenerationId
        AppUtility.selectedSellFilterHome?.subgen = listingData?.listings?[indexPath.row].carSubGenerationId
        AppUtility.selectedSellFilterHome?.trim = listingData?.listings?[indexPath.row].trimDefinitionId
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated:true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if listingdataCount == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchWantToBuyAndSell", for: indexPath) as! searchWantToBuyAndSell
            cell.lbl.text = "Tap on the search above to view live for Buy listing"
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "findCarCell", for: indexPath) as! findCarCell
            cell.nameModelLbl.text =  "\(listingData?.listings?[indexPath.row].carMake ?? "N/A")  |  \(listingData?.listings?[indexPath.row].carModel ?? "N/A")  |  \(listingData?.listings?[indexPath.row].carGeneration ?? "N/A")  |  \(listingData?.listings?[indexPath.row].carSubGeneration ?? "N/A")  |  \(listingData?.listings?[indexPath.row].trimDefinition ?? "N/A")"
            cell.configureImage(image: listingData?.listings?[indexPath.row].image?[0] ?? "",uuid: listingData?.listings?[indexPath.row].uuid ?? "N/A")
            numberFormatter.numberStyle = .decimal
            numberFormatter.currencySymbol = .none
            numberFormatter.minimumFractionDigits = 0
            
            let min = Int(listingData?.listings?[indexPath.row].car_min_mileage ?? 0)
            let max = Int(listingData?.listings?[indexPath.row].car_max_mileage ?? 0)
            
            
            cell.configureMinMax(min: "\(numberFormatter.string(from: NSNumber(value: min)) ?? "N/A") - ", max:"\(numberFormatter.string(from: NSNumber(value: max)) ?? "N/A") Miles")
            
            cell.btn.setTitle("Contact Buyer", for: .normal)
            cell.comp = { [self] () in
                AppUtility.isUUidPresent = true
                AppUtility.uuid = listingData?.listings![indexPath.row].uuid ?? "N/A"
                let storyboard = UIStoryboard(name: "SellYourCar", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "sellyourCarVC") as! sellyourCarVC
                vc.allowSearch = false
                vc.makeId = listingData?.listings?[indexPath.row].carMakeId ?? -1
                vc.modelId = listingData?.listings?[indexPath.row].carModelId ?? -1
                vc.genId = listingData?.listings?[indexPath.row].carGenerationId ?? -1
                vc.subgenId = listingData?.listings?[indexPath.row].carSubGenerationId ?? -1
                vc.trimId = listingData?.listings?[indexPath.row].trimDefinitionId ?? -1
                vc.makeName = listingData?.listings?[indexPath.row].carMake ?? ""
                vc.modelname = listingData?.listings?[indexPath.row].carModel ?? ""
                vc.genname = listingData?.listings?[indexPath.row].carGeneration ?? ""
                vc.subgenname = listingData?.listings?[indexPath.row].carSubGeneration ?? ""
                vc.trimname = listingData?.listings?[indexPath.row].trimDefinition ?? ""
                AppUtility.selectedSellFilterHome?.gen = listingData?.listings?[indexPath.row].carGenerationId
                AppUtility.selectedSellFilterHome?.subgen = listingData?.listings?[indexPath.row].carSubGenerationId
                AppUtility.selectedSellFilterHome?.trim = listingData?.listings?[indexPath.row].trimDefinitionId
                let navController = UINavigationController(rootViewController: vc)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated:true, completion: nil)
            }
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if listingdataCount == 0{
            let cellSize = CGSize(width: (collectionView.bounds.width) - 48, height: 200)
            return cellSize
        }else{
            let cellSize = CGSize(width: (collectionView.bounds.width / 2) - 13, height: 165)
            return cellSize
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    
    @IBAction func onCLickFilterBtn(_ sender: Any) {
        if AppUtility.isFromNavigationProg!{
            AppUtility.isfromHome = false
            AppUtility.isfromBuy = true
            AppUtility.isFromNavigationProg = false
        }else{
            AppUtility.isfromHome = true
            AppUtility.isfromBuy = false
        }
         presentSheet()
    }
    @IBAction func onClickCreateSaleListingBtn(_ sender: Any) {
        AppUtility.isUUidPresent = false
        let storyboard = UIStoryboard(name: "SellYourCar", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "sellyourCarVC") as! sellyourCarVC
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated:true,completion: nil)
    }
    
    @IBAction func onCLickFeedbackBtn(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WebView") as? WebView
        vc?.webLink = "https://4n4dhxdgde8.typeform.com/to/Ne24UTdp"
        self.navigationController?.present(vc!, animated: true)
        
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
        vc.isFromWhere = true
        vc.onCLickSubmit = { [self] text in
            var req1 = wantToBuyListingRequest(carModelId: vc.makeID ?? -1 , carMakeId: vc.makeID ?? -1 ,sub_gens_and_trim_defs: [sub_gens_and_trim_defs](), pageLimit: 20,pageOffset: 0)

            var trimAndSubGen = sub_gens_and_trim_defs()
            if (vc.subGenID != nil) {
                trimAndSubGen.carSubGenerationId = vc.subGenID
            }
            if (vc.trimID != nil) {
                trimAndSubGen.trimDefinitionId = vc.trimID
            }
            if (vc.subGenID != nil) || (vc.trimID != nil) {
                req1.sub_gens_and_trim_defs?.append(trimAndSubGen)

            }
            callApiForListing(req: req1)
        }
        
        sheetController.didDismiss = { vc in
        }
        self.present(sheetController, animated: true, completion: nil)
    }
    
    @objc func addimage(_ notification: NSNotification) {
        print("i am here.")
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "navigateToModelAnalysis"), object: nil)
        AppUtility.showFIrstTimeLoader = true
        tabBarController?.selectedIndex = 1

    }
}
