//
//  BuySellCarDetailVC.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 30/03/2023.
//

import UIKit
import PUGifLoading

class BuySellCarDetailVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let taskerName = UILabel()
    let subtitleLabel = UILabel()
    let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    @IBOutlet weak var carTextView: UIView!
    
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var makeoelView: UIView!
    
    let loading = PUGIFLoading()
    
    var cardetailData:HomecardetailModelDataClass?
    var cardetailGraphData:HomeCarDetailGraphDataClass?
    var cardetailSimilarListing = [HomeCarDetailListingListingID]()
    var cardetailSimilarListingLive = [GetlistingresponsesListingID]()
    var uuidCar:String?
    
    @IBOutlet weak var carGeneration: UILabel!
    @IBOutlet weak var carSubGeneration: UILabel!
    @IBOutlet weak var carTrims: UILabel!
    @IBOutlet weak var carMakeAndModel: UILabel!
    @IBOutlet weak var carPrice: UILabel!
    
    let numberFormatter = NumberFormatter()

    //check click on sale listing "true" || wtb listing "false"
    var isfromSaleOrWTB : Bool?
    var isfromWhere : String?

    private var dashboardFilterViewModel = HomeViewControllerVM()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        lazy var titleStackView: UIStackView = {
            
            taskerName.textColor = UIColor(named: "Green")
            taskerName.font = UIFont(name: "Inter-Regular", size: 10)
            taskerName.textAlignment = .left
            taskerName.text = "Detail View"
            subtitleLabel.textColor = UIColor(named: "Green")
            subtitleLabel.textAlignment = .left
            subtitleLabel.text = NSLocalizedString("\(cardetailData?.carDetails?.car_make?.make ?? "N/A") \(cardetailData?.carDetails?.car_model?.model ?? "N/A")", comment:"")
            subtitleLabel.font = UIFont(name: "Inter-SemiBold", size: 12)
            
            let stackView = UIStackView(arrangedSubviews: [taskerName, subtitleLabel])
            stackView.axis = .vertical
            return stackView
        }()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backItem?.hidesBackButton = true
        let title = UIBarButtonItem(customView: titleStackView)
        self.navigationItem.leftBarButtonItems = [setBackBtn(),title]
        self.navigationItem.leftBarButtonItem?.width = CGFloat(5)
        
        
        let img = resizedImage(at: UIImage(named: "share")!, for: CGSize(width: 17, height: 17))
        let btnProfile = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        btnProfile.setImage(img, for: .normal)
        btnProfile.layer.masksToBounds = true
        btnProfile.addTarget(self, action: #selector(self.share), for: .allTouchEvents)
        
        let img2 = resizedImage(at: UIImage(named: "feedback")!, for: CGSize(width: 17, height: 17))
        let btnProfile2 = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        btnProfile2.setImage(img2, for: .normal)
        btnProfile2.layer.masksToBounds = true
        btnProfile2.addTarget(self, action: #selector(self.web), for: .allTouchEvents)
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: btnProfile),UIBarButtonItem(customView: btnProfile2)]
        
        
        carTextView.dropShadow()
        carTextView.layer.cornerRadius = 5
        makeoelView.dropShadow()
        priceView.dropShadow()
        makeoelView.layer.cornerRadius = 5
        priceView.layer.cornerRadius = 5
        
        
        
        collectionView.register(UINib(nibName: "carDeatilVisual", bundle: nil), forCellWithReuseIdentifier: "carDeatilVisual")
        collectionView.register(UINib(nibName: "HeadingCell", bundle: nil), forCellWithReuseIdentifier: "HeadingCell")
        collectionView.register(UINib(nibName: "SaleListingCell", bundle: nil), forCellWithReuseIdentifier: "SaleListingCell")
        collectionView.register(UINib(nibName: "WTBListingCell", bundle: nil), forCellWithReuseIdentifier: "WTBListingCell")
        collectionView.register(UINib(nibName: "searchWantToBuyAndSell", bundle: nil), forCellWithReuseIdentifier: "searchWantToBuyAndSell")

        collectionView.dataSource = self
        collectionView.delegate = self
        setCarDetails()
    }
    
    func setCarDetails(){
        
        carGeneration.text = "  \(cardetailData?.carDetails?.car_generation?.generation ?? "N/A")  "
        carSubGeneration.text = "  \(cardetailData?.carDetails?.car_sub_generation?.sub_generation ?? "N/A")  "
        carTrims.text = "  \(cardetailData?.carDetails?.trim_definition?.car_trim ?? "N/A")  "
        carMakeAndModel.text = "\(cardetailData?.carDetails?.car_make?.make ?? "N/A") \(cardetailData?.carDetails?.car_model?.model ?? "N/A")"
        numberFormatter.numberStyle = .decimal
        numberFormatter.currencySymbol = .none
        numberFormatter.minimumFractionDigits = 0
        let mag = numberFormatter.string(from: NSNumber(value:Int((cardetailData?.carDetails?.listing_price) ?? 0)))
        carPrice.text = "$\(mag ?? "0")"
        
    }
    
    
    
    @objc func share(){
        DispatchQueue.main.async {
                var link = "dev-microservices.horizonauto.com://"
                let activityController = UIActivityViewController(activityItems: [link], applicationActivities: nil)
                activityController.completionWithItemsHandler = {(nil, completed, _, error) in
                    if completed {
                        print("completed")
                    }else {
                        print("cancled")
                    }
                }
                self.present(activityController, animated: true, completion: nil)
        }

    }
    
    @objc func web(){
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WebView") as? WebView
        vc?.webLink = "https://4n4dhxdgde8.typeform.com/to/Ne24UTdp"
        self.navigationController?.present(vc!, animated: true)
    }
    
    
    func setBackBtn() -> UIBarButtonItem {
        
        backButton.frame = CGRect(x: 0, y: 100, width: 15, height: 15)
        let img = resizedImage(at: UIImage(named: "backButton")!, for: CGSize(width: 25, height: 25))
        backButton.setImage(img, for: .normal)
        backButton.addTarget(self, action: #selector(popToHome), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.dropShadow()
        let back = UIBarButtonItem(customView: backButton)
        
        return back
    }
    @objc func popToHome(){
        navigationController?.popViewController(animated: true)
    }
    
    func resizedImage(at image: UIImage, for size: CGSize) -> UIImage? {
        let image = image

        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 2 {
            if cardetailSimilarListing.count == 0 {
                return 1
            }else{
                return cardetailSimilarListing.count
            }
            
        }else{
            return 1
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carDeatilVisual", for: indexPath) as! carDeatilVisual
            cell.vc = self
            cell.configureImages(images: cardetailData?.carDetails?.images ?? [String](),showImage: isfromSaleOrWTB!,isfrom: isfromWhere!)
            cell.addSubViewForCarDetail(carDetail: (cardetailData?.carDetails)!, showImage: isfromSaleOrWTB!)
            if isfromSaleOrWTB!{
                cell.addGraphData(detailType: isfromSaleOrWTB!, graphData: cardetailGraphData!)
            }
            cell.CarTapAction = { [self] (carId) in
                if let cell = collectionView.cellForItem(at: IndexPath(row: 0, section: 2)) {
                    let cellClass = type(of: cell)
                    if cellClass == WTBListingCell.self{
                        callCarDetailApi(uuid: carId,isfromWhichListing: false)
                    }else if cellClass == SaleListingCell.self{
                        callCarDetailApi(uuid: carId,isfromWhichListing: true)
                    }

                }
            }
            cell.contactSellerAction = { [self] () in
                
                AppUtility.isUUidPresent = true
                AppUtility.uuid = uuidCar ?? ""
                let storyboard = UIStoryboard(name: "FindYourCar", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "FindYourCarVC") as! FindYourCarVC
                
                vc.allowSearch = false
                vc.makeId = cardetailData?.carDetails?.car_make?.id ?? -1
                vc.modelId = cardetailData?.carDetails?.car_model?.id ?? -1
                vc.genId =  cardetailData?.carDetails?.car_generation?.id ?? -1
                vc.subgenId = cardetailData?.carDetails?.car_sub_generation?.id ?? -1
                vc.trimId = cardetailData?.carDetails?.trim_definition?.id ?? -1
                
                vc.makeName = cardetailData?.carDetails?.car_make?.make ?? ""
                vc.modelname = cardetailData?.carDetails?.car_model?.model ?? ""
                vc.genname =  cardetailData?.carDetails?.car_generation?.generation ?? ""
                vc.subgenname = cardetailData?.carDetails?.car_sub_generation?.sub_generation ?? ""
                vc.trimname = cardetailData?.carDetails?.trim_definition?.car_trim ?? ""
                
                AppUtility.selectedBuyFilter = searchSelection(make: cardetailData?.carDetails?.car_make?.id ?? -1,model:  cardetailData?.carDetails?.car_model?.id ?? -1,gen: cardetailData?.carDetails?.car_generation?.id ?? -1,subgen: cardetailData?.carDetails?.car_sub_generation?.id ?? -1,trim: cardetailData?.carDetails?.trim_definition?.id ?? -1)
                
                let navController = UINavigationController(rootViewController: vc)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated:true, completion: nil)
                
                
//                AppUtility.isUUidPresent = true
//                AppUtility.uuid = uuidCar ?? ""
//                let storyboard = UIStoryboard(name: "FindYourCar", bundle: nil)
//                let vc = storyboard.instantiateViewController(withIdentifier: "FindYourCar") as! FindyourCarVCHome
//                vc.allowSearch = false
//                vc.makeId = cardetailData?.carDetails?.car_make?.id ?? -1
//                vc.modelId = cardetailData?.carDetails?.car_model?.id ?? -1
//                vc.genId =  cardetailData?.carDetails?.car_generation?.id ?? -1
//                vc.subgenId = cardetailData?.carDetails?.car_sub_generation?.id ?? -1
//                vc.trimId = cardetailData?.carDetails?.trim_definition?.id ?? -1
//                AppUtility.selectedSellFilterHome = searchSelection(make: cardetailData?.carDetails?.car_make?.id ?? -1,model:  cardetailData?.carDetails?.car_model?.id ?? -1,gen: cardetailData?.carDetails?.car_generation?.id ?? -1,subgen: cardetailData?.carDetails?.car_sub_generation?.id ?? -1,trim: cardetailData?.carDetails?.trim_definition?.id ?? -1)
//                let navController = UINavigationController(rootViewController: vc)
//                navController.modalPresentationStyle = .fullScreen
//                self.present(navController, animated:true, completion: nil)
            }
            return cell
        }else if indexPath.section == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeadingCell", for: indexPath)
            as! HeadingCell
            if isfromWhere == "ModelAnalysis"{
                cell.cellLabel.text = "Similar For Sale Listing"
            }else if isfromWhere == "HomeProfile"{
                cell.cellLabel.text = "Listing Responses"
            }
            return cell
        }else if indexPath.section == 2{
            if cardetailSimilarListing.count == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchWantToBuyAndSell", for: indexPath) as! searchWantToBuyAndSell
                cell.lbl.text = ""
                return cell
            }else{
                if isfromWhere == "ModelAnalysis"{
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SaleListingCell", for: indexPath) as! SaleListingCell
                    cell.configureCell2(cellData: cardetailSimilarListing[indexPath.row])
                    cell.viewButton.setTitle("View", for: .normal)
                    cell.btnClicke = { [self] (uuid) in
                        callCarDetailApi(uuid: uuid,isfromWhichListing: true)
                    }
                    return cell
                }else if isfromWhere == "HomeProfile"{
                    if isfromSaleOrWTB!{
                        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WTBListingCell", for: indexPath) as! WTBListingCell
                        cell.configureCell2(cellData: cardetailSimilarListing[indexPath.row])
                        cell.viewButton.setTitle("View Responses", for: .normal)
                        cell.btnClicke = { [self] (uuid) in
                            callCarDetailApi(uuid: uuid,isfromWhichListing: false)
                        }
                        return cell
                    }else{
                        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SaleListingCell", for: indexPath) as! SaleListingCell
                        cell.configureCell2(cellData: cardetailSimilarListing[indexPath.row])
                        cell.btnClicke = { [self] (uuid) in
                            callCarDetailApi(uuid: uuid,isfromWhichListing: true)
                        }
                        return cell
                    }
                }else{
                    return UICollectionViewCell()
                }
            }
          
            
        }else{
            return UICollectionViewCell()
        }
       
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            if let cell = collectionView.cellForItem(at: indexPath) {
                let cellClass = type(of: cell)
                if cellClass == WTBListingCell.self{
                    callCarDetailApi(uuid: cardetailSimilarListing[indexPath.row].uuid!,isfromWhichListing: false)

                }else if cellClass == SaleListingCell.self{
                    callCarDetailApi(uuid: cardetailSimilarListing[indexPath.row].uuid!,isfromWhichListing: true)

                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 0 {
            if isfromSaleOrWTB!{
                if isfromWhere == "ModelAnalysis"{
                    let cellSize = CGSize(width: collectionView.bounds.width , height: 640)
                    return cellSize
                }else{
                    let cellSize = CGSize(width: collectionView.bounds.width , height: 575)
                    return cellSize
                }
                
            }else{
                let cellSize = CGSize(width: collectionView.bounds.width , height: 385)
                return cellSize
            }
           
        }else if indexPath.section == 1 {
            let cellSize = CGSize(width: collectionView.bounds.width , height: 30)
            return cellSize
        }else if indexPath.section == 2 {
            if cardetailSimilarListing.count == 0 {
                let cellSize = CGSize(width: collectionView.bounds.width - 13, height: 150)
                return cellSize
            }else{
                if isfromWhere == "ModelAnalysis"{
                    let cellSize = CGSize(width: collectionView.bounds.width / 2 - 13, height: 320)
                    return cellSize
                }else if isfromWhere == "HomeProfile"{
                    if isfromSaleOrWTB!{
                        let cellSize = CGSize(width: collectionView.bounds.width / 2 - 13, height: 200)
                        return cellSize
                    }else{
                        let cellSize = CGSize(width: collectionView.bounds.width / 2 - 13, height: 320)
                        return cellSize
                    }
                }else{
                    return CGSize(width: 0, height: 0)
                }
            }
           
            
        }else{
            return CGSize(width: 0, height: 0)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }else if section == 1 {
            return UIEdgeInsets(top: 15, left: 0, bottom: 5, right: 0)
        }else if section == 2 {
            return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        }else{
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        }
    }
    
    
    //MARK: - api calling for navigating to home car detail page.
    
    func callCarDetailApi(uuid:String,isfromWhichListing:Bool){
        showLoader(loader: loading)
        let request = getHomeCarDetailRequest(uuid: uuid)
        dashboardFilterViewModel.getHomeCarDetail(requestModel: request) { [self] (result) in
            switch result{
            case .success(let result):
                if isfromWhere == "HomeProfile"{
                    callCarDetailListingLive(uuid: uuid,carDetailed: result.data!,isfromWhichListing: isfromWhichListing)

                }else{
                    callCarDetailListing(uuid: uuid,carDetailed: result.data!,isfromWhichListing: isfromWhichListing)
                }
            case .failure(let error):
                hideLoader(loader: loading)
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
                
            }
        }
        
    }
    
    func callCarDetailListingLive(uuid:String,carDetailed:HomecardetailModelDataClass,isfromWhichListing:Bool){
        let request = gethomecardetailListingRequest(uuid: uuid)
        dashboardFilterViewModel.getHomeCarDetaillisting(requestModel: request) { [self] (result) in
            switch result{
            case .success(let result):
                callCarDetailGraphAPI(carDetails: carDetailed,cardetailListing: (result.data?.listing_id)!,isfromWhichListing: isfromWhichListing)
            case .failure(let error):
                hideLoader(loader: loading)
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
            }
        }
    }
    
    func callCarDetailListing(uuid:String,carDetailed:HomecardetailModelDataClass,isfromWhichListing:Bool){
        let request = gethomecardetailListingRequest(uuid: uuid)
        dashboardFilterViewModel.getHomeCarDetaillisting(requestModel: request) { [self] (result) in
            switch result{
            case .success(let result):
                callCarDetailGraphAPI(carDetails: carDetailed,cardetailListing: (result.data?.listing_id)!,isfromWhichListing: isfromWhichListing)
            case .failure(let error):
                hideLoader(loader: loading)
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
            }
        }
    }
    
    
    func callCarDetailGraphAPI(carDetails:HomecardetailModelDataClass,cardetailListing:[HomeCarDetailListingListingID],isfromWhichListing:Bool){
        
        let genAndTrim = sub_gens_and_trim_defs(carSubGenerationId: carDetails.carDetails?.car_sub_generation?.id ?? -1, trimDefinitionId: carDetails.carDetails?.trim_definition?.id ?? -1)
        let request = gethomecardetailGraphRequest(carModelId: carDetails.carDetails?.car_model?.id ?? -1, carMakeId: carDetails.carDetails?.car_make?.id ?? -1, sub_gens_and_trim_defs: [genAndTrim])
        
        
        dashboardFilterViewModel.getHomeCarDetailgraph(requestModel: request) { [self] (result) in
            switch result{
            case .success(let result):
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "BuySellCarDetailVC") as? BuySellCarDetailVC
                vc?.cardetailData = carDetails
                vc?.cardetailGraphData = result.data
                vc?.cardetailSimilarListing = cardetailListing
                vc?.isfromSaleOrWTB = isfromWhichListing
                vc?.isfromWhere = isfromWhere
                hideLoader(loader: loading)
                self.navigationController?.pushViewController(vc!, animated: true)
            case .failure(let error):
                hideLoader(loader: loading)
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
            }
        }
    }

    
}
