//
//  CarDetailVC.swift
//  CarBois
//
//  Created by Umer Yasin on 02/09/2022.
//

import UIKit
import FittedSheets
import ImageSlideshow
import PUGifLoading


class CarDetailVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    let taskerName = UILabel()
    let subtitleLabel = UILabel()
    let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    
    
    var cardetailData:CarDetailModel?
    var cardetailGraphData:CarDetailGraphModel?
    var cardetailSimilarListing = [CarDetailsSimilarListingsSimilarListing]()
    var is_liveListing:Bool?
    
    private var CarDetailViewModel = CarDetailVCViewModel()
    private var modelAnalysisViewModel = ModelAnalysisViewModel()

    let loading = PUGIFLoading()

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var stayOnSameScreen:Bool = false
    var isSkeletonLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lazy var titleStackView: UIStackView = {
            
            taskerName.textColor = UIColor(named: "Green")
            taskerName.font = UIFont(name: "Inter-Regular", size: 10)
            taskerName.textAlignment = .left
            taskerName.text = "Detail View"
            subtitleLabel.textColor = UIColor(named: "Green")
            subtitleLabel.textAlignment = .left
            subtitleLabel.text = NSLocalizedString(cardetailData?.data?.carDetails?.listing_title ?? "N/A", comment:"")
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
//        btnProfile.layer.cornerRadius = 15.0
        btnProfile.layer.masksToBounds = true
        btnProfile.addTarget(self, action: #selector(self.share), for: .allTouchEvents)
        
        let img2 = resizedImage(at: UIImage(named: "feedback")!, for: CGSize(width: 17, height: 17))
        let btnProfile2 = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        btnProfile2.setImage(img2, for: .normal)
//        btnProfile2.layer.cornerRadius = 15.0
        btnProfile2.layer.masksToBounds = true
        btnProfile2.addTarget(self, action: #selector(self.web), for: .allTouchEvents)
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: btnProfile),UIBarButtonItem(customView: btnProfile2)]

        // Do any additional setup after loading the view.
        
        collectionView.register(UINib(nibName: "HeadingCell", bundle: nil), forCellWithReuseIdentifier: "HeadingCell")
        
        collectionView.register(UINib(nibName: "FilterView", bundle: nil), forCellWithReuseIdentifier: "FilterView")
        collectionView.register(UINib(nibName: "carDetailText", bundle: nil), forCellWithReuseIdentifier: "carDetailText")
        collectionView.register(UINib(nibName: "ImageAndCarDetailVisual", bundle: nil), forCellWithReuseIdentifier: "ImageAndCarDetailVisual")
        collectionView.register(UINib(nibName: "CarFilterCell", bundle: nil), forCellWithReuseIdentifier: "CarFilterCell")
        
        
        
        collectionView.register(UINib(nibName: "GraphCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GraphCollectionViewCell")
        collectionView.register(UINib(nibName: "CarouselSliderCell", bundle: nil), forCellWithReuseIdentifier: "CarouselSliderCell")
        collectionView.register(UINib(nibName: "CarDisplayDetailCell", bundle: nil), forCellWithReuseIdentifier: "CarDisplayDetailCell")
        collectionView.register(UINib(nibName: "NoSimilarCar", bundle: nil), forCellWithReuseIdentifier: "NoSimilarCar")
        collectionView.register(UINib(nibName: "ShimmerCell", bundle: nil), forCellWithReuseIdentifier: "ShimmerCell")

        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !UserDefaults.standard.bool(forKey: "cardetail"){
            NotificationCenter.default.post(name: Notification.Name("myNotification2"), object: nil, userInfo: nil)
        }
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
//        AppUtility.FilterApplied = nil
        AppUtility.FilterAppliedCarDetail = nil

        navigationController?.popViewController(animated: true)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }else  if section == 1 {
            return 1
        }else  if section == 2 {
            return 1
        }else  if section == 3 {
            return 1
        }else{
            if cardetailSimilarListing.count != 0 {
                return cardetailSimilarListing.count
            }else{
                return 1
            }
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterView", for: indexPath) as! FilterView
            cell.clickAction = { [self] () in
                AppUtility.filterAppliedFromCarDetailScreen = false
                presentSheet(viewController: "FilterVc")
            }
            return cell
        }else if indexPath.section == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carDetailText", for: indexPath) as! carDetailText
            
            cell.carModel.text = cardetailData?.data?.carDetails?.car_make?.make?.capitalized ?? "N/A"
            cell.carTrim.text = cardetailData?.data?.carDetails?.car_model?.model?.capitalized ?? "N/A"
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .currency
            numberFormatter.currencySymbol = "$"
            numberFormatter.minimumFractionDigits = 0
            if is_liveListing!{
                let ap = numberFormatter.string(from: NSNumber(value: Int(cardetailData?.data?.carDetails?.max_bid ?? "0") ?? 0) )
                cell.currentPrice.text = "\(ap!)"
                cell.currentTitle.text = "Max Bid"
            }else{
                if cardetailData?.data?.carDetails?.listing_type == "auction"{
                    let ap = numberFormatter.string(from: NSNumber(value: cardetailData?.data?.carDetails?.price ?? 0) )
                    cell.currentPrice.text = "\(ap!)"
                    cell.currentTitle.text = "Max Bid"
                }else{
                    let ap = numberFormatter.string(from: NSNumber(value: cardetailData?.data?.carDetails?.price ?? 0) )
                    cell.currentPrice.text = "\(ap!)"
                    cell.currentTitle.text = "Sale Price"
                }
            }
            
            
//            let ap = numberFormatter.string(from: NSNumber(value: cardetailData?.data?.priceVsMarket?.averagePrice ?? 0))
//            if cardetailData?.data?.priceVsMarket?.direction == "decrease"{
//                cell.priceVsMarket.text = "\(ap ?? "N/A") Above"
//                cell.priceVsMarket.textColor = .red
//            }else{
//                cell.priceVsMarket.text = "\(ap ?? "N/A") Below"
//            }
            cell.filterCarModel.text = "  " + (cardetailData?.data?.carDetails?.car_generation?.generation ?? "N/A") + "  "
            let subGen = cardetailData?.data?.carDetails?.car_sub_generation?.sub_generation ?? "N/A"
            cell.filterCarSubGen.text = "  " + subGen + "  "
            cell.filterCarTrims.text = "  " + (cardetailData?.data?.carDetails?.trim_definition?.car_trim ?? "N/A") + "  "
            
            cell.onClickFilterHistory = { [self] () in
                presentSheet(viewController: "FilterVc")
            }
            cell.onviewSource = { [self] () in
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WebView") as? WebView
                vc?.webLink = cardetailData?.data?.carDetails?.url ?? "https://4n4dhxdgde8.typeform.com/to/Ne24UTdp"
                self.navigationController?.present(vc!, animated: true)
            }
            
            
            
            return cell
        }else if indexPath.section == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageAndCarDetailVisual", for: indexPath) as! ImageAndCarDetailVisual
            cell.viewbtnTapAction = { [self] in ()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "detailImageView") as? detailImageView
                vc?.cardetailData = cardetailData
                self.navigationController?.pushViewController(vc!, animated: true)
            }
            cell.vc = self
            cell.addImagesAndCarosoul(images: (cardetailData?.data?.carDetails?.images)!,isfromBuySell: false)
            cell.addSubViewForCarDetail(carDetail: (cardetailData?.data?.carDetails)!)
            cell.addGraphData(graphData: cardetailGraphData!,is_Live: is_liveListing!)
            cell.sendSwitchState = {  (state) in
                 print(state)
                if state{
                    AlertHelper.showAlertWithTitle(self, title: "Live Data is in Beta. May Experience Some Issue.", dismissButtonTitle: "OK") { () -> Void in
                    }
                }
                self.is_liveListing = state
                self.stayOnSameScreen = true
                self.showLoader(loader: self.loading)
                self.isSkeletonLoading = true
                self.collectionView.reloadSections([4])
                self.getCarDetail(carId: self.cardetailData?.data?.carDetails?.id ?? -1)
            }
            
            cell.CarTapAction = { [self] (carId) in
                AppUtility.SortApplied = nil
                showLoader(loader: self.loading)
                getCarDetail(carId: carId)
            }

            
            return cell
        }else if indexPath.section == 3{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarFilterCell", for: indexPath) as! CarFilterCell
            if is_liveListing!{
                cell.lbl.text = "Live For Sale Listings:"
            }else{
                cell.lbl.text = "Completed Listings:"

            }
            cell.onCLickFilterButtonAction = { [self] () in
              
                var req = CarDetailFilterListingRequest(id: cardetailData?.data?.carDetails?.id ?? -1)
                if AppUtility.FilterAppliedCarDetail != nil {
                    req.filters = AppUtility.FilterAppliedCarDetail
                }
                if is_liveListing!{
                    req.view_live_data = true
                }else{
                    req.view_live_data = false
                }
                req.sortBy = AppUtility.SortApplied ?? nil
                AppUtility.carDetailFilterBody = req
                CarDetailViewModel.getFilterListing(requestModel: req) { (Result) in
                    switch Result{
                    case .success(let res):
                        print(res)
                        AppUtility.AverageGraphFilter = nil
                        AppUtility.HistoricGraphFilter = nil
                        AppUtility.CarDetailFilter = res
                        self.presentSheet(viewController: "CarAndListingFilter")
                    case .failure(let error):
                        let err = CustomError(description: (error as? CustomError)?.description ?? "")
                        print(err)
                        self.hideLoader(loader: self.loading)
                        AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                        }
                    }
                }
            }
            return cell
        }else{
            if isSkeletonLoading{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShimmerCell", for: indexPath) as! ShimmerCell
                cell.makeCellAnimate()
                return cell
            }
            if cardetailSimilarListing.count > 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarDisplayDetailCell", for: indexPath) as! CarDisplayDetailCell
                cell.configureCarDetailSimilarListing(cellData: (cardetailSimilarListing[indexPath.row]), is_Live: is_liveListing!)
                cell.addToSavedbtnTapAction = { () in
                    print("SAVE BUTTON TAPPED.")
                }
                cell.addToGaragebtnTapAction = { () in
                    print("Garage BUTTON TAPPED.")
                }
                cell.viewbtnTapAction = { [self] (carId) in
                    AppUtility.SortApplied = nil
                    showLoader(loader: self.loading)
                    getCarDetail(carId: carId)
                }
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoSimilarCar", for: indexPath) as! NoSimilarCar
                return cell
            }
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == 4 && indexPath.row ==  cardetailSimilarListing.count - 1{
            if AppUtility.totalCarsCarDetail != cardetailSimilarListing.count {
                getPaginatedCars()
            }
        }
    }
    
    func getPaginatedCars(){
        var request = CarDetailRequestModel(id: cardetailData?.data?.carDetails?.id ?? 0,filters: AppUtility.FilterAppliedCarDetail)
        if is_liveListing!{
            request.view_live_data = true
        }else{
            request.view_live_data = false
        }
        request.offset = cardetailSimilarListing.count
        request.limit = 20
        CarDetailViewModel.getCarDetailSimilarListing(requestModel: request) { (result) in
            switch result{
            case .success(let result):
                self.cardetailSimilarListing.append(contentsOf: result.data?.similarLiveListings?.similarListings ?? [CarDetailsSimilarListingsSimilarListing]())
                self.collectionView.reloadSections([4])
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 4{
            AppUtility.SortApplied = nil
            showLoader(loader: self.loading)
            getCarDetail(carId: cardetailSimilarListing[indexPath.row].id ?? 0)
        }
        print("you tapped me")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        
        if indexPath.section == 0 {
            let cellSize = CGSize(width: collectionView.bounds.width - 5, height: 60)
            return cellSize
            
        }else if indexPath.section == 1 {
            let cellSize = CGSize(width: collectionView.bounds.width - 5 , height: 130)
            return cellSize
            
        }else if indexPath.section == 2 {
            let cellSize = CGSize(width: collectionView.bounds.width , height: 575)
            return cellSize
            
        }else if indexPath.section == 3 {
            let cellSize = CGSize(width: collectionView.bounds.width , height: 50)
            return cellSize
            
        }else{
            if cardetailSimilarListing.count != 0 {
                let cellSize = CGSize(width: (collectionView.bounds.width)/2 - 5, height: 270)
                return cellSize
            }else{
                let cellSize = CGSize(width: (collectionView.bounds.width) - 5, height: 100)
                return cellSize
            }
            
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 18, left: 0, bottom: 0, right: 0)
            
        }else if section == 1 {
            return UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
            
        }else if section == 2 {
            return UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
            
        }else if section == 3 {
            return UIEdgeInsets(top: 6, left: 0, bottom: 8, right: 0)
            
        }else{
            return UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        }
    }
    
    func presentSheet(viewController:String){
        
        
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
        
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
        
        sheetController.didDismiss = { [self] _ in
//            AppUtility.FilterAppliedFromList = false
            showLoader(loader: loading)
            callApiUsingListingFilters()
            if AppUtility.FilterAppliedFromList ?? false{
                AppUtility.FilterAppliedFromList = false
                showLoader(loader: loading)
                callApiUsingListingFilters()

            }else{
                if AppUtility.filterAppliedFromCarDetailScreen {
                    AppUtility.filterAppliedFromCarDetailScreen = false
                    for controller in self.navigationController!.viewControllers as Array {
                        if controller.isKind(of: ModelAnalysisViewController.self) {
                            AppUtility.moveTopop = true
                            self.navigationController!.popToViewController(controller, animated: true)
                            break

                        }
                    }
                }

            }
            
        }
        
        self.present(sheetController, animated: true, completion: nil)
        
    }
    
    
    func callApiUsingListingFilters(){
        getCarDetailsCarListing(carId: cardetailData?.data?.carDetails?.id ?? -1)
    }
    
    func getCarDetailsCarListing(carId:Int){
        var request = CarDetailRequestModel(id: carId,filters: AppUtility.FilterAppliedCarDetail)
        if is_liveListing!{
            request.view_live_data = true
        }else{
            request.view_live_data = false
        }
        request.sortBy = AppUtility.SortApplied ?? nil
        request.offset = 0
        request.limit = 20
        CarDetailViewModel.getCarDetailSimilarListing(requestModel: request) { (result) in
            switch result{
            case .success(let result):
                self.getCarGraph(carId: carId,carSimilarListing: result)
                print(result)
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                }
            }
        }
    }
    
    func getCarGraph(carId:Int,carSimilarListing:CarDetailsSimilarListings){
        var request = CarDetailRequestModel(id: carId,filters: AppUtility.FilterAppliedCarDetail)
        if is_liveListing!{
            request.view_live_data = true
        }else{
            request.view_live_data = false
        }
        CarDetailViewModel.getCarDetailGraph(requestModel: request) { [self] (result) in
            switch result{
            case .success(let result):
                print(result)
                hideLoader(loader: loading)
                cardetailGraphData = result
                cardetailSimilarListing = carSimilarListing.data?.similarLiveListings?.similarListings ?? [CarDetailsSimilarListingsSimilarListing]()
                AppUtility.totalCarsCarDetail = carSimilarListing.data?.similarLiveListings?.totalRecords
                collectionView.reloadSections([2,4])
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                }
            }
        }
    }
    
    
    //calling car detail apis functions.
    func getCarDetail(carId:Int){
        let request = CarDetailRequestModel(id: carId)
        modelAnalysisViewModel.getCarDetail(requestModel: request) { [self] (result) in
            switch result{
            case .success(let result):
                print(result)
                getCarDetailsCarListing(carId: carId,carDetail: result)
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                }
            }
        }
    }
    func getCarDetailsCarListing(carId:Int,carDetail:CarDetailModel){
        var request = CarDetailRequestModel(id: carId)
        if is_liveListing!{
            request.view_live_data = true
        }else{
            request.view_live_data = false
        }
        request.offset = 0
        request.limit = 20
        modelAnalysisViewModel.getCarDetailSimilarListing(requestModel: request) { (result) in
            switch result{
            case .success(let result):
                self.getCarGraph(carId: carId, carDetail: carDetail,carSimilarListing: result)
                print(result)
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                }
            }
        }
    }
    func getCarGraph(carId:Int,carDetail:CarDetailModel,carSimilarListing:CarDetailsSimilarListings){
        var request = CarDetailRequestModel(id: carId)
        if is_liveListing!{
            request.view_live_data = true
        }else{
            request.view_live_data = false
        }
        modelAnalysisViewModel.getCarDetailGraph(requestModel: request) { [self] (result) in
            switch result{
            case .success(let result):
                print(result)
                if stayOnSameScreen{
                    stayOnSameScreen = false
                    cardetailData = carDetail
                    cardetailGraphData = result
                    cardetailSimilarListing = carSimilarListing.data?.similarLiveListings?.similarListings ?? [CarDetailsSimilarListingsSimilarListing]()
                    AppUtility.totalCarsCarDetail = carSimilarListing.data?.similarLiveListings?.totalRecords
                    if is_liveListing!{
                        is_liveListing = true
                    }else{
                        is_liveListing = false
                    }
                    isSkeletonLoading = false
                    collectionView.reloadSections([2,3,4])
                    hideLoader(loader: loading)
                }else{
                    isSkeletonLoading = false
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CarDetailVC") as? CarDetailVC
                    vc?.cardetailData = carDetail
                    vc?.cardetailGraphData = result
                    vc?.cardetailSimilarListing = carSimilarListing.data?.similarLiveListings?.similarListings ?? [CarDetailsSimilarListingsSimilarListing]()
                    AppUtility.totalCarsCarDetail = carSimilarListing.data?.similarLiveListings?.totalRecords
                    if is_liveListing!{
                        vc?.is_liveListing = true
                    }else{
                        vc?.is_liveListing = false
                    }
                    hideLoader(loader: loading)
                    self.navigationController?.pushViewController(vc!, animated: true)
                }
               
               
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                }
            }
        }
    }
    
    func resizedImage(at image: UIImage, for size: CGSize) -> UIImage? {
        let image = image

        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
}
