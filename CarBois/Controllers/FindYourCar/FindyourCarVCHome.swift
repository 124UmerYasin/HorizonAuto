//
//  FindyourCarVCHome.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 17/02/2023.
//

import UIKit
import FittedSheets
import PUGifLoading

class FindyourCarVCHome: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var horizonButton: UIButton!
    @IBOutlet weak var feedbackButton: UIButton!
    @IBOutlet weak var wantToBuyButton: UIButton!
    
    @IBOutlet weak var filterView: UIView!
    
    @IBOutlet weak var filterButton: UIButton!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var findyourCarVM = findYoucarHomeVM()

    var listingData : WantToSaleListingModelDataClass?
    var listingdataCount = 0
    
    let loading = PUGIFLoading()
    let numberFormatter = NumberFormatter()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        filterView.dropShadow()
        
        collectionView.register(UINib(nibName: "findCarCell", bundle: nil), forCellWithReuseIdentifier: "findCarCell")
        collectionView.register(UINib(nibName: "searchWantToBuyAndSell", bundle: nil), forCellWithReuseIdentifier: "searchWantToBuyAndSell")

        collectionView.dataSource = self
        collectionView.delegate = self
        
        
    }
    
    func callApiForListing(req:wantToBuyListingRequest){
        showLoader(loader: loading)

        findyourCarVM.getWanttoSaleListing(requestModel: req) { [self] result in
            switch result{
            case .success(let result):
                listingData = result.data
                listingdataCount = result.data?.listings?.count ?? 0
                collectionView.reloadData()
                hideLoader(loader: loading)

            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")

                AlertHelper.showAlertWithTitle(self, title: err.description ?? "N/A", dismissButtonTitle: "OK") { () -> Void in

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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if listingdataCount == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchWantToBuyAndSell", for: indexPath) as! searchWantToBuyAndSell
            cell.lbl.text = "Tap on the search above to view live for Sale listing"
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "findCarCell", for: indexPath) as! findCarCell
            cell.nameModelLbl.text =  "\(listingData?.listings?[indexPath.row].carMake ?? "N/A")  |  \(listingData?.listings?[indexPath.row].carModel ?? "N/A")  |  \(listingData?.listings?[indexPath.row].carGeneration ?? "N/A")  |  \(listingData?.listings?[indexPath.row].carSubGeneration ?? "N/A")  |  \(listingData?.listings?[indexPath.row].trimDefinition ?? "N/A")"
            cell.configureImage(image: listingData?.listings?[indexPath.row].image?[0] ?? "",uuid: listingData?.listings?[indexPath.row].uuid ?? "N/A")
            
            numberFormatter.numberStyle = .decimal
            numberFormatter.currencySymbol = .none
            numberFormatter.minimumFractionDigits = 0
            
            let min = Int(listingData?.listings?[indexPath.row].car_mileage ?? 0)
            
            cell.configureMile(min: "\(numberFormatter.string(from: NSNumber(value: min)) ?? "N/A") Miles", max: "")

            
            cell.btn.setTitle("Contact Seller", for: .normal)
            return cell
        }
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        AppUtility.isUUidPresent = true
        AppUtility.uuid = listingData?.listings![indexPath.row].uuid ?? "N/A"
        let storyboard = UIStoryboard(name: "FindYourCar", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FindYourCarVC") as! FindYourCarVC
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated:true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        if listingdataCount == 0{
            let cellSize = CGSize(width: (collectionView.bounds.width) - 48, height: 200)
            return cellSize
        }else{
            let cellSize = CGSize(width: (collectionView.bounds.width / 2) - 13, height: 300)
            return cellSize
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }

    @IBAction func onClickFilterBtn(_ sender: Any) {
        AppUtility.isfromBuy = true
        AppUtility.isfromHome = true

        presentSheet()
    }
    
    @IBAction func onCLickWantToBuyBtn(_ sender: Any) {
        
        AppUtility.isUUidPresent = false
        let storyboard = UIStoryboard(name: "FindYourCar", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FindYourCarVC") as! FindYourCarVC
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated:true, completion: nil)
        
    }
    
    @IBAction func onClickFeedbackBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WebView") as? WebView
        vc?.webLink = "https://4n4dhxdgde8.typeform.com/to/Ne24UTdp"
        self.navigationController?.present(vc!, animated: true)
    }
    
    @IBAction func onCLickHorizonBtn(_ sender: Any) {
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
//            let req = wantToBuyListingRequest(carModelId: vc.modelID ?? -1, carMakeId: vc.makeID ?? -1, carGenerationId: vc.genID ?? -1, carSubGenerationId: vc.subGenID ?? -1, trimDefinitionId: vc.trimID ?? -1, pageLimit: 20, pageOffset: 0)
            callApiForListing(req: req1)
        }
        
        sheetController.didDismiss = { vc in
        }
        
        self.present(sheetController, animated: true, completion: nil)
    }
}
