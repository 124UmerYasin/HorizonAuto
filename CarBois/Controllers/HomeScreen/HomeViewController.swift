//
//  HomeViewController.swift
//  CarBois
//
//  Created by Umer Yasin on 23/08/2022.
//

import UIKit
import FittedSheets
import PUGifLoading
import SkeletonView
import MaterialShowcase

class HomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MaterialShowcaseDelegate {
    
    
    
    @IBOutlet weak var searchButtonTutorial: UIView!
    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var filterButton: UIButton!
    
    let loading = PUGIFLoading()
    
    private var homeViewControllerViewModel = HomeViewControllerVM()
    private var filterVcViewModel = FilterVcViewModel()
    
    @IBOutlet weak var feedbackButton: UIButton!
    
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var marqueeCollectionView: UICollectionView!
    var marqueeCount = 10
    var timer: Timer?
    var contentWidth: CGFloat = 0
    
    @IBOutlet weak var marqueeCollectionViewHeight: NSLayoutConstraint!
    var marqueeData : MarqueeModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        collectionView.register(UINib(nibName: "HeadingCell", bundle: nil), forCellWithReuseIdentifier: "HeadingCell")
        collectionView.register(UINib(nibName: "GraphCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GraphCollectionViewCell")
        collectionView.register(UINib(nibName: "CarouselSliderCell", bundle: nil), forCellWithReuseIdentifier: "CarouselSliderCell")
        collectionView.register(UINib(nibName: "featuredEmptyCellHome", bundle: nil), forCellWithReuseIdentifier: "featuredEmptyCellHome")
        collectionView.register(UINib(nibName: "CarDisplayCell", bundle: nil), forCellWithReuseIdentifier: "CarDisplayCell")
        collectionView.register(UINib(nibName: "shimmerCellHome", bundle: nil), forCellWithReuseIdentifier: "shimmerCellHome")
        collectionView.register(UINib(nibName: "SaleListingCollection", bundle: nil), forCellWithReuseIdentifier: "SaleListingCollection")
        collectionView.register(UINib(nibName: "WTBListingCollectionVIewCEll", bundle: nil), forCellWithReuseIdentifier: "WTBListingCollectionVIewCEll")
        collectionView.register(UINib(nibName: "CarouselSliderCellShimmer", bundle: nil), forCellWithReuseIdentifier: "CarouselSliderCellShimmer")

        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        marqueeCollectionView.register(UINib(nibName: "MarqueeCell", bundle: nil), forCellWithReuseIdentifier: "MarqueeCell")
        marqueeCollectionView.register(UINib(nibName: "shimmerMarquee", bundle: nil), forCellWithReuseIdentifier: "shimmerMarquee")

        
        marqueeCollectionView.dataSource = self
        marqueeCollectionView.delegate = self
                
        shadowView.dropShadow()
        if AppUtility.navigateToNextWhenAppOpen{
            AppUtility.navigateToNextWhenAppOpen = false
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ModelAnalysisViewController") as? ModelAnalysisViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        callMarqueeData()
//        callHotpickApi()
        getFeaturedListing()
        getSaleListingData()
        getWTBListingData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !UserDefaults.standard.bool(forKey: "feedback"){
            showTutorial()
        }
    }
    
    func showTutorial(){
        let showcase = MaterialShowcase()
        showcase.setTargetView(view: feedbackButton) // always required to set targetView
        showcase.primaryText = "Feedback !"
        showcase.primaryTextSize = CGFloat(30)
        showcase.secondaryText = "you can provide your valueable feedback by tapping on this icon."
        showcase.secondaryTextSize = CGFloat(20)
        showcase.backgroundPromptColor = UIColor(named: "AccentColor")
        showcase.show(completion: {
            // You can save showcase state here
            // Later you can check and do not show it again
        })
        showcase.delegate = self
    }
    
    func showCaseDidDismiss(showcase: MaterialShowcase, didTapTarget: Bool) {
        UserDefaults.standard.set(true, forKey: "feedback")
        if !UserDefaults.standard.bool(forKey: "homeSearch"){
            showSearchTutorial()
        }
    }
    
    func showSearchTutorial(){
        let showcase = MaterialShowcase()
        showcase.setTargetView(view: searchButtonTutorial) // always required to set targetView
        showcase.primaryText = "Search !"
        showcase.primaryTextSize = CGFloat(30)
        showcase.secondaryText = "Please tap here to search your favourite cars with their specific sub-generation and trims."
        showcase.secondaryTextSize = CGFloat(20)
        showcase.backgroundPromptColor = UIColor(named: "AccentColor")
        showcase.show(completion: {
            UserDefaults.standard.set(true, forKey: "homeSearch")
            // You can save showcase state here
            // Later you can check and do not show it again
        })
        showcase.delegate = self
    }
    
    func callHotpickApi(){
        homeViewControllerViewModel.getHotpicks { [self] (result)  in
            switch result{
            case .success(let result):
                AppUtility.hotPicks = result.data
                collectionView.reloadSections([7])
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
            }
        }
    }
    
    func getFeaturedListing(){
        homeViewControllerViewModel.getFeaturedListing { [self] (result)  in
            switch result{
            case .success(let result):
                AppUtility.featuredListing = result.data
                collectionView.reloadSections([2])
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
            }
        }
    }
 
    func getSaleListingData(){
//        print(UserDefaults.standard.string(forKey: "token") ?? "")
        homeViewControllerViewModel.getSaleListingData { [self] (result)  in
            switch result{
            case .success(let result):
                print(result)
                AppUtility.SaleListing = result.data?.listing_id
                collectionView.reloadSections([4])
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
            }
        }
    }
    
    func getWTBListingData(){
        homeViewControllerViewModel.getWTBListingData { [self] (result)  in
            switch result{
            case .success(let result):
                print(result)
                AppUtility.WTBListing = result.data?.listing_id
                collectionView.reloadSections([6])
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
            }
        }
    }
    
    func showRunMarquee(){
        let cellWidth = marqueeCollectionView.frame.width / 5
        let numberOfCells = CGFloat(marqueeCount)
        contentWidth = cellWidth * numberOfCells * 2// multiply by 2 to create infinite scrolling
        marqueeCollectionView.contentSize = CGSize(width: contentWidth, height: collectionView.frame.height)
        timer = Timer.scheduledTimer(timeInterval: 0.03, target: self, selector: #selector(scrollCollectionView), userInfo: nil, repeats: true)
    }
    
    func callMarqueeData(){
        homeViewControllerViewModel.getMarqueeData { [self] (result)  in
            switch result{
            case .success(let result):
                print(result)
                marqueeData = result
                marqueeCollectionView.reloadData()
                showRunMarquee()
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
            }
        }
    }
    
    @IBAction func onclickFeedBack(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WebView") as? WebView
        vc?.webLink = "https://4n4dhxdgde8.typeform.com/to/Ne24UTdp"
        self.navigationController?.present(vc!, animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        greetingLabel.text = getTime()
        userName.text = UserDefaults.standard.string(forKey: "username")
        AppUtility.ToggleState = false
        AppUtility.showCurrentHistoric = false
        AppUtility.isColor = true
        AppUtility.showOrHideLiveButton = false
    }

    @objc func scrollCollectionView() {
        // Calculate next content offset
        let currentOffset = marqueeCollectionView.contentOffset.x
        let nextOffset = currentOffset + 1
        
        // Scroll to next content offset
        if nextOffset < contentWidth {
            marqueeCollectionView.setContentOffset(CGPoint(x: nextOffset, y: 0), animated: false)
        } else {
            marqueeCollectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == marqueeCollectionView{
            return 1
        }else{
            return 7
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == marqueeCollectionView{
            return marqueeData?.data?.count ?? 1
        }else{
            if section == 0 {
                return 1
            }else  if section == 1 {
                return 0
            }else  if section == 2 {
                return 1
            }else  if section == 3 {
                return 1
            }else  if section == 4 {
                return 1
            }else  if section == 5 {
                return 1
            }else  if section == 6 {
                return 1
            }else{
                return AppUtility.hotPicks?.hotPicks?.count ?? 4
            }
        }
      
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.marqueeCollectionView{
            
            
            if marqueeData != nil {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarqueeCell", for: indexPath) as! MarqueeCell
                cell.carMakelbl.text = marqueeData?.data?[indexPath.row].make?.make ?? "N/A"
                cell.carModellbl.text = marqueeData?.data?[indexPath.row].model?.model ?? "N/A"
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .currency
                numberFormatter.minimumFractionDigits = 0
                numberFormatter.currencySymbol = "$"

                cell.carPriceLbl.text = numberFormatter.string(from: NSNumber(value: marqueeData?.data?[indexPath.row].marketPricesAndVector?.currentMonthMarketAverage?.average ?? 0))
                numberFormatter.numberStyle = .decimal
                if marqueeData?.data?[indexPath.row].marketPricesAndVector?.percentageChange?.direction == "increase"{
                    cell.carIncordeclbl.text = "\(numberFormatter.string(from: NSNumber(value: marqueeData?.data?[indexPath.row].marketPricesAndVector?.percentageChange?.magnitude ?? 0)) ?? "0")(\(marqueeData?.data?[indexPath.row].marketPricesAndVector?.percentageChange?.percentage ?? 0.0)%)"
                    cell.carIncordeclbl.textColor = UIColor(named: "grapgGreen")
                }else{
                    cell.carIncordeclbl.text = "-\(numberFormatter.string(from: NSNumber(value: marqueeData?.data?[indexPath.row].marketPricesAndVector?.percentageChange?.magnitude ?? 0)) ?? "0")(\(marqueeData?.data?[indexPath.row].marketPricesAndVector?.percentageChange?.percentage ?? 0.0)%)"
                    cell.carIncordeclbl.textColor = .red
                    
                }
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shimmerMarquee", for: indexPath) as! shimmerMarquee
                cell.makeCellAnimate()
                return cell
            }
            
        }else{
            if indexPath.section == 0{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeadingCell", for: indexPath) as! HeadingCell
                cell.cellLabel.text = "Featured"
                return cell
            }else if indexPath.section == 1{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GraphCollectionViewCell", for: indexPath) as! GraphCollectionViewCell
                cell.setupChartData()
                return cell
            }else if indexPath.section == 2{
                if AppUtility.featuredListing != nil && AppUtility.featuredListing!.count > 0 {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselSliderCell", for: indexPath) as! CarouselSliderCell
                    cell.viewbtnTapAction = { [self] () in
                        showLoader(loader: loading)
                        tapOnCarosoulView()
                        
                    }
                    return cell
                } else  if AppUtility.featuredListing != nil && AppUtility.featuredListing!.count == 0 {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "featuredEmptyCellHome", for: indexPath) as! featuredEmptyCellHome
                    
                    return cell
                } else{
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselSliderCellShimmer", for: indexPath) as! CarouselSliderCellShimmer
                    cell.makeCellAnimate()
                    return cell
                }
               
                
            }else if indexPath.section == 3{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeadingCell", for: indexPath)
                as! HeadingCell
                cell.cellLabel.text = "Your For Sale Listings"
                return cell
            }else if indexPath.section == 4{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SaleListingCollection", for: indexPath) as! SaleListingCollection
                cell.configureCell()
                cell.btnClicked = { [self] (uuid) in
                    print(uuid)
                    callCarDetailApi(uuid: uuid,isfromWhichListing: true)
                }
                cell.clickAction = { [self] () in
                    AppUtility.isUUidPresent = false
                    let storyboard = UIStoryboard(name: "SellYourCar", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "sellyourCarVC") as! sellyourCarVC
                    vc.isFromWhere = "Home"
                    vc.onClickBrowseListing = { () in
                        AppUtility.isFromNavigationProg = false
                        self.tabBarController?.selectedIndex = 2
                    }
                    let navController = UINavigationController(rootViewController: vc)
                    navController.modalPresentationStyle = .fullScreen
                    self.present(navController, animated:true,completion: nil)
                }
                return cell
            }else if indexPath.section == 5{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeadingCell", for: indexPath)
                as! HeadingCell
                cell.cellLabel.text = "Your WTB Listings"
                return cell
            }else if indexPath.section == 6{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WTBListingCollectionVIewCEll", for: indexPath) as! WTBListingCollectionVIewCEll
                cell.configureCell()
                cell.btnClicked = { [self] (uuid) in
                    print(uuid)
                    callCarDetailApi(uuid: uuid,isfromWhichListing: false)
                }
                cell.clickAction = { [self] () in
                    AppUtility.isUUidPresent = false
                    let storyboard = UIStoryboard(name: "FindYourCar", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "FindYourCarVC") as! FindYourCarVC
                    vc.isFromWhere = "Home"
                    vc.onClickBrowseListing = { () in
                        AppUtility.showFIrstTimeLoader = true
                        AppUtility.selectedSellFilter = nil
                        AppUtility.isFromNavigationProg = false
                        AppUtility.showOrHideLiveButton = true
                        self.tabBarController?.selectedIndex = 1
                    }
                    let navController = UINavigationController(rootViewController: vc)
                    navController.modalPresentationStyle = .fullScreen
                    self.present(navController, animated:true, completion: nil)
                }
                return cell
            }else{
                
                if AppUtility.hotPicks?.hotPicks != nil{
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarDisplayCell", for: indexPath) as! CarDisplayCell
                    cell.addToSavedbtnTapAction = { () in
                        print("SAVE BUTTON TAPPED.")
                    }
                    cell.addToGaragebtnTapAction = { () in
                        print("Garage BUTTON TAPPED.")
                    }
                    cell.viewbtnTapAction = { [self] () in
                        print("view BUTTON TAPPED.")
                        showLoader(loader: loading)
                        AppUtility.FilterApplied = nil
                        AppUtility.SortApplied = nil
                        refreshValues(indexpath: indexPath)
                    }
                    cell.setData(data: (AppUtility.hotPicks?.hotPicks![indexPath.row])!)
                    return cell
                }else{
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shimmerCellHome", for: indexPath) as! shimmerCellHome
                    cell.makeCellAnimate()
                    return cell
                }
                
            }
        }
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 4 {
            if AppUtility.hotPicks?.hotPicks != nil{
                print("view BUTTON TAPPED.")
                AppUtility.FilterApplied = nil
                AppUtility.SortApplied = nil
                showLoader(loader: loading)
                refreshValues(indexpath: indexPath)
            }
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        if collectionView == marqueeCollectionView{
            let cellSize = CGSize(width: collectionView.bounds.width , height: 50)
            return cellSize
        }else{
            if indexPath.section == 0 {
                let cellSize = CGSize(width: collectionView.bounds.width , height: 20)
                return cellSize
                
            }else if indexPath.section == 1 {
                let cellSize = CGSize(width: collectionView.bounds.width - 8 , height: 225)
                return cellSize
                
            }else if indexPath.section == 2 {
                let cellSize = CGSize(width: collectionView.bounds.width - 8 , height: 160)
                return cellSize
                
            }else if indexPath.section == 3 {
                let cellSize = CGSize(width: collectionView.bounds.width , height: 20)
                return cellSize
                
            }else if indexPath.section == 4 {
                if AppUtility.SaleListing != nil {
                    if AppUtility.SaleListing?.count == 0 {
                        let cellSize = CGSize(width: (collectionView.bounds.width), height: 200)
                        return cellSize
                    }else{
                        let cellSize = CGSize(width: (collectionView.bounds.width), height: 260)
                        return cellSize
                    }
                }else{
                    let cellSize = CGSize(width: (collectionView.bounds.width), height: 260)
                    return cellSize
                }
                
                
                
            }else if indexPath.section == 5 {
                let cellSize = CGSize(width: collectionView.bounds.width , height: 20)
                return cellSize
                
            }else if indexPath.section == 6 {
                if AppUtility.WTBListing != nil {
                    if AppUtility.WTBListing?.count == 0 {
                        let cellSize = CGSize(width: (collectionView.bounds.width), height: 200)
                        return cellSize
                    }else{
                        let cellSize = CGSize(width: collectionView.bounds.width , height: 210)
                        return cellSize
                    }
                }else{
                        let cellSize = CGSize(width: collectionView.bounds.width , height: 210)
                        return cellSize
                }
                
            }else{
                let cellSize = CGSize(width: (collectionView.bounds.width / 2) - 13, height: 270)
                return cellSize
                
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView == marqueeCollectionView{
            return UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)//18

        }else{
            if section == 0 {
                return UIEdgeInsets(top: 18, left: 0, bottom: 18, right: 0)//18
                
            }else if section == 1 {
                return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)//24
                
            }else if section == 2 {
                return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)//15
                
            }else if section == 3 {
                return UIEdgeInsets(top: 18, left: 0, bottom: 18, right: 0)
                
            }else if section == 4 {
                return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                
            }else if section == 5 {
                return UIEdgeInsets(top: 18, left: 0, bottom: 18, right: 0)

            }else if section == 6 {
                return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                
            }else{
                return UIEdgeInsets(top: 0, left: 5, bottom: 8, right: 5)
            }
        }
    }
    
   
    @IBAction func onCLickFilterButton(_ sender: Any) {
//        if AppUtility.dashboardFilterData != nil{
//            openSearchSheet()
//        }else{
            showLoader(loader: loading)
            getSearchData()
//        }
        
    }
    
    func getSearchData(){
            
            filterVcViewModel.getCarMake(){ [self] (makeResult) in
                switch makeResult{
                case .success(let makeResult):
                    print(makeResult)
                    AppUtility.dashboardFilterData = makeResult
                    // call models API
                    let makeId = makeResult.data?.carMake?[0].id
                   
                    // 3 makeId is for Audi which is the first item
                    filterVcViewModel.getCarModels(id: makeId ?? 3){ [self] (modelResult) in
                        switch modelResult{
                        case .success(let modelResult):
                            print(modelResult)
                            AppUtility.dashboardFilterData?.data?.carMake?[0].models = modelResult.data?.carModels
                            // call generations API
                            
                            let modelId = modelResult.data?.carModels?[0].id
                            
                            filterVcViewModel.getCarGenerations(id: modelId ?? 1){ [self] (generationResult) in
                                switch generationResult{
                                case .success(let generationResult):
                                    print(generationResult)
                                    AppUtility.dashboardFilterData?.data?.carMake?[0].models?[0].carGenerations = generationResult.data?.carGenerations
                                    
                                    hideLoader(loader: loading)
                                    openSearchSheet()
                                    
                                case .failure(let error):
                                    hideLoader(loader: loading)
                                    let err = CustomError(description: (error as? CustomError)?.description ?? "")
                                    print(err)
                                    AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in}
                                }
                            }

                            
                        case .failure(let error):
                            hideLoader(loader: loading)
                            let err = CustomError(description: (error as? CustomError)?.description ?? "")
                            print(err)
                            AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in}
                        }
                    }

                case .failure(let error):
                    hideLoader(loader: loading)
                    let err = CustomError(description: (error as? CustomError)?.description ?? "")
                    print(err)
                    AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in}
                }
            }

    }
    
    
    func openSearchSheet(){

        
        AppUtility.selectedCodition = 0
        AppUtility.selectedMake = 0
        AppUtility.selectedModel = 0
        AppUtility.selectedGeneration = 0
        AppUtility.seletedTableIndex = [dashboardfilteratabledataModel]()
        
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FilterVc")
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
                
        sheetController.didDismiss = { _ in
            if AppUtility.canNavigateFromDashboardFilter!{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ModelAnalysisViewController") as? ModelAnalysisViewController
                self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
        self.present(sheetController, animated: true, completion: nil)
    }
    
    func refreshValues(indexpath:IndexPath){
        AppUtility.showAverage = true
        AppUtility.showIndividualListing = false
        AppUtility.canNavigateFromDashboardFilter = true
        AppUtility.filterRequestBody = nil
        AppUtility.averageGraphCarList = [AverageGraphCarListModelCurrentTenureCarsList]()
        AppUtility.Tenure = nil
        AppUtility.historicGraphRequestBody = nil
        AppUtility.multiHistoricGraphCarList = [MultiHistoricGraphDataModelDataPoint]()
        AppUtility.SelectedIndex = 3
        
        AppUtility.graphData = nil
        AppUtility.multiHistoricGraphData = nil
        AppUtility.ModelPricingDataModel = nil
        AppUtility.generation = nil
        AppUtility.subGen = nil
        AppUtility.subTrims = nil
//        getAverageGraphData(indexpath: indexpath)
        callHistoricGraphApi(indexpath: indexpath)
    }
    
    
    func tapOnCarosoulView(){
        AppUtility.showAverage = true
        AppUtility.showIndividualListing = false
        AppUtility.canNavigateFromDashboardFilter = true
        AppUtility.filterRequestBody = nil
        AppUtility.averageGraphCarList = [AverageGraphCarListModelCurrentTenureCarsList]()
        AppUtility.Tenure = nil
        AppUtility.historicGraphRequestBody = nil
        AppUtility.multiHistoricGraphCarList = [MultiHistoricGraphDataModelDataPoint]()
        AppUtility.SelectedIndex = 3
        
        AppUtility.graphData = nil
        AppUtility.multiHistoricGraphData = nil
        AppUtility.ModelPricingDataModel = nil
        AppUtility.generation = nil
        AppUtility.subGen = nil
        AppUtility.subTrims = nil
        
        AppUtility.selectedCodition = 2
        AppUtility.selectedMake = 3
        AppUtility.selectedModel = 4
        AppUtility.selectedGeneration = 1
        AppUtility.ToggleState = false
        AppUtility.showCurrentHistoric = false
        
        AppUtility.FilterApplied = nil
        AppUtility.SortApplied = nil
        
        let dashboardfilteratabledataModel = [dashboardfilteratabledataModel(carGenerationID: 27, CarSubGenerationId: 44, CarSubGenerationName: "Competition/CS", CarSubGenerationPrice: 68805, CarSubGenerationdirection: "decrease", TrimDefinitionId: 94, TrimDefinitionName: "M2 CS", TrimDefinitionPrice: 96995, TrimDefinitiondirection: "decrease", isSubGen: false, Color: "sliderLabel", isSelected: true)]
        AppUtility.isColor = false
        AppUtility.seletedTableIndex = dashboardfilteratabledataModel
        makeFilterString()
        var request2 = multiHistoricGraphRequestModel(tenure: tenure.oneYear.rawValue, cars: [car]())
        for item in AppUtility.seletedTableIndex {
            if item.isSubGen{
                let mb = car(subGenerationId: item.CarSubGenerationId)
                request2.cars.append(mb)
            }else{
                let mb = car(subGenerationId: item.CarSubGenerationId, trimDefinitionId: item.TrimDefinitionId)
                request2.cars.append(mb)
            }
        }
        AppUtility.historicGraphRequestBody = request2
        filterVcViewModel.getHistoricGraphData(requestModel: request2) { [self] (result) in
            switch result{
            case .success(let result):
                AppUtility.multiHistoricGraphData = result.data?.historicGraphData
                for item in result.data?.historicGraphData?.graphData ?? []{
                    for item2 in item.dataPoints ?? []{
                        AppUtility.multiHistoricGraphCarList.append(item2)
                    }
                }
                print(AppUtility.multiHistoricGraphCarList)
                modelPricingDataApi(check: true)
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                }
               hideLoader(loader: loading)
            }
        }
        func modelPricingDataApi(check:Bool){
            let request = ModelPricingDataRequest(carType: "used", carMakeId: 2, carModelId:5)
            filterVcViewModel.getModelPricingData(requestModel: request) { [self] (result) in
                switch result{
                case .success(let result):
                    AppUtility.ModelPricingDataModel = result.data
                    if check{
                       getHistoricCars()
                    }
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
    
    func getHistoricCars(){
        let req = multiHistoriccarRequestModel(tenure: AppUtility.historicGraphRequestBody!.tenure, cars: AppUtility.historicGraphRequestBody!.cars, limit: 20, offset: 0, view_live_data: false)
        AppUtility.historiccarListModelreq = req
        filterVcViewModel.getHistoriccarList(requestModel: req) { [self] (result) in
            switch result{
            case .success(let result):
                AppUtility.multiHistoricCarList = result.data?.matchingHistoricListings?.paginatedArr ?? []
                AppUtility.toatalCarsHistoric = result.data?.matchingHistoricListings?.actualArrLength
               hideLoader(loader: loading)
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ModelAnalysisViewController") as? ModelAnalysisViewController
                self.navigationController?.pushViewController(vc!, animated: true)
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                }
               hideLoader(loader: loading)
            }
        }
    }
    
    
    func callHistoricGraphApi(indexpath:IndexPath){
        AppUtility.ToggleState = false
        AppUtility.showCurrentHistoric = false
        AppUtility.selectedCodition = 2
       
        AppUtility.FilterApplied = nil
        AppUtility.SortApplied = nil
        
        if AppUtility.dashboardFilterData?.data?.carMake != nil {
            for (index, element) in AppUtility.dashboardFilterData!.data!.carMake!.enumerated() {
                if element.id == AppUtility.hotPicks?.hotPicks![indexpath.row].makeId ?? 0 {
                    AppUtility.selectedMake = index
                }
            }
        }
        
        if AppUtility.dashboardFilterData?.data?.carMake?[AppUtility.selectedMake].models != nil {
            for (index, element) in AppUtility.dashboardFilterData!.data!.carMake![AppUtility.selectedMake].models!.enumerated() {
                if element.id == AppUtility.hotPicks?.hotPicks![indexpath.row].modelId ?? 0 {
                    AppUtility.selectedModel = index
                }
            }
        }
        
        if AppUtility.dashboardFilterData?.data?.carMake?[AppUtility.selectedMake].models?[AppUtility.selectedModel].carGenerations != nil {
            for (index, element) in AppUtility.dashboardFilterData!.data!.carMake![AppUtility.selectedMake].models![AppUtility.selectedModel].carGenerations!.enumerated() {
                if element.id == AppUtility.hotPicks?.hotPicks![indexpath.row].generationId ?? 0 {
                    AppUtility.selectedGeneration = index + 1
                }
            }
        }
        
        let dashboardfilteratabledataModel = [dashboardfilteratabledataModel(carGenerationID: AppUtility.hotPicks?.hotPicks![indexpath.row].generationId ?? 0, CarSubGenerationId: AppUtility.hotPicks?.hotPicks![indexpath.row].subGenerationId ?? 0, CarSubGenerationName: AppUtility.hotPicks?.hotPicks![indexpath.row].subGen ?? "", CarSubGenerationPrice: 00, CarSubGenerationdirection: "decrease", TrimDefinitionId: AppUtility.hotPicks?.hotPicks![indexpath.row].trimDefinitionId ?? 0, TrimDefinitionName: AppUtility.hotPicks?.hotPicks![indexpath.row].trim ?? "", TrimDefinitionPrice: 00, TrimDefinitiondirection: "decrese", isSubGen: false, Color: "sliderLabel", isSelected: true)]
        AppUtility.isColor = false

        
        AppUtility.seletedTableIndex = dashboardfilteratabledataModel
        makeFilterString()
        var request2 = multiHistoricGraphRequestModel(tenure: tenure.oneYear.rawValue, cars: [car]())
        for item in AppUtility.seletedTableIndex {
            if item.isSubGen{
                let mb = car(subGenerationId: item.CarSubGenerationId)
                request2.cars.append(mb)
            }else{
                let mb = car(subGenerationId: item.CarSubGenerationId, trimDefinitionId: item.TrimDefinitionId)
                request2.cars.append(mb)
            }
        }
        AppUtility.historicGraphRequestBody = request2
        filterVcViewModel.getHistoricGraphData(requestModel: request2) { [self] (result) in
            switch result{
            case .success(let result):
                AppUtility.multiHistoricGraphData = result.data?.historicGraphData
                for item in result.data?.historicGraphData?.graphData ?? []{
                    for item2 in item.dataPoints ?? []{
                        AppUtility.multiHistoricGraphCarList.append(item2)
                    }
                }
                modelPricingDataApi(check: true)
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                }
               hideLoader(loader: loading)
            }
        }
        func modelPricingDataApi(check:Bool){
            let request = ModelPricingDataRequest(carType: "used", carMakeId: AppUtility.hotPicks?.hotPicks![indexpath.row].makeId ?? 0, carModelId: AppUtility.hotPicks?.hotPicks![indexpath.row].modelId ?? 0)
            filterVcViewModel.getModelPricingData(requestModel: request) { [self] (result) in
                switch result{
                case .success(let result):
                    AppUtility.ModelPricingDataModel = result.data
                    if check{
                        getHistoricCars()
                    }
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
    
    
    func getAverageGraphData(indexpath:IndexPath){
        let request = averageGraphRequestModel(carType: "used", carMakeId: AppUtility.hotPicks?.hotPicks![indexpath.row].makeId ?? 0, carModelId: AppUtility.hotPicks?.hotPicks![indexpath.row].modelId ?? 0, tenure: tenure.oneYear.rawValue)
        AppUtility.generation = AppUtility.hotPicks?.hotPicks![indexpath.row].subGen ?? "N/A"
        AppUtility.subTrims = "All"
        AppUtility.subGen = "All"
        AppUtility.filterRequestBody = request
        homeViewControllerViewModel.getGraphData(requestModel: request) { [self] (result) in
            switch result{
                
            case .success(let result):
                AppUtility.graphData = result.data
                modelPricingDataApi(check: false, indexpath: indexpath)
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                }
               hideLoader(loader: loading)
            }
        }

        
    }
    
    func modelPricingDataApi(check:Bool,indexpath:IndexPath){
        let request = ModelPricingDataRequest(carType: "used", carMakeId: AppUtility.hotPicks?.hotPicks![indexpath.row].makeId ?? 0, carModelId: AppUtility.hotPicks?.hotPicks![indexpath.row].modelId ?? 0)
        homeViewControllerViewModel.getModelPricingData(requestModel: request) { [self] (result) in
            switch result{
            case .success(let result):
                AppUtility.ModelPricingDataModel = result.data
                if check{
                   hideLoader(loader: loading)
                    self.dismiss(animated: true)
                }else{
                    let req = AverageGraphCarListRequest(carType: "used", carMakeId: AppUtility.hotPicks?.hotPicks![indexpath.row].makeId ?? 0, carModelId: AppUtility.hotPicks?.hotPicks![indexpath.row].modelId ?? 0, tenure: tenure.oneYear.rawValue, limit: 10, offset: 0)
                    getAverageGraphCarList(request: req)
                }
              
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                }
               hideLoader(loader: loading)
            }
        }
    }
    
    func getAverageGraphCarList(request:AverageGraphCarListRequest){
        homeViewControllerViewModel.getAverageGraphCarList(requestModel: request) { [self] (result) in
            switch result{
            case .success(let result):
                print(result)
                AppUtility.averageGraphCarList = result.data?.averageGraphCarsList?.currentTenureCarsList ?? [AverageGraphCarListModelCurrentTenureCarsList]()
                AppUtility.totalCarsAverage = result.data?.averageGraphCarsList?.totalRecords
               hideLoader(loader: loading)
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ModelAnalysisViewController") as? ModelAnalysisViewController
                self.navigationController?.pushViewController(vc!, animated: true)
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                }
            }
        }
    }
    
    
    func makeFilterString(){
        
        if !AppUtility.seletedTableIndex.isEmpty {
            AppUtility.generation = ""
            AppUtility.subTrims = ""
            AppUtility.subGen = ""
            AppUtility.generation = AppUtility.dashboardFilterData?.data?.carMake?[AppUtility.selectedMake].models?[AppUtility.selectedModel].carGenerations?[AppUtility.selectedGeneration - 1].generation ?? "N/A"
            AppUtility.Tenure = tenure.oneYear
            
            var carSubGen:Set<String> = []
            var carTrims:Set<String> = []
            
            for item in AppUtility.seletedTableIndex {
                if item.isSubGen{
                    carSubGen.insert("\(item.CarSubGenerationName)")
                }else{
                    carSubGen.insert("\(item.CarSubGenerationName)")
                    carTrims.insert("\(item.TrimDefinitionName)")
                }
            }
            
            let carTrimArray: [String] = Array(carTrims)
            let string = carTrimArray.map { String($0) }
                .joined(separator: ",")
            AppUtility.subTrims = string
            
            let carsubgenArray: [String] = Array(carSubGen)
            let string2 = carsubgenArray.map { String($0) }
                .joined(separator: ",")
            AppUtility.subGen = string2
            
            if AppUtility.subTrims == "" {
                AppUtility.subTrims = "All"
            }
            if AppUtility.subGen == "" {
                AppUtility.subGen = "All"
            }
        }else{
//            AppUtility.generation = generationData?[AppUtility.selectedGeneration].generation ?? "N/A"
//            AppUtility.subTrims = "All"
//            AppUtility.subGen = "All"
            
        }
        
        
    }
    
    //MARK: - api calling for navigating to home car detail page.
    
    func callCarDetailApi(uuid:String,isfromWhichListing:Bool){
        showLoader(loader: loading)
        let request = getHomeCarDetailRequest(uuid: uuid)
        homeViewControllerViewModel.getHomeCarDetail(requestModel: request) { [self] (result) in
            switch result{
            case .success(let result):
                callCarDetailListing(uuid: uuid,carDetailed: result.data!,isfromWhichListing: isfromWhichListing)
            case .failure(let error):
                hideLoader(loader: loading)
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
                
            }
        }
        
    }
    
    func callCarDetailListing(uuid:String,carDetailed:HomecardetailModelDataClass,isfromWhichListing:Bool){
        let request = gethomecardetailListingRequest(uuid: uuid)
        homeViewControllerViewModel.getHomeCarDetaillistingWithToken(requestModel: request) { [self] (result) in
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
        
        
        homeViewControllerViewModel.getHomeCarDetailgraph(requestModel: request) { [self] (result) in
            switch result{
            case .success(let result):
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "BuySellCarDetailVC") as? BuySellCarDetailVC
                vc?.cardetailData = carDetails
                vc?.cardetailGraphData = result.data
                vc?.cardetailSimilarListing = cardetailListing
                vc?.isfromSaleOrWTB = isfromWhichListing
                vc?.isfromWhere = "HomeProfile"
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



extension UIView {
    
    func dropShadow() {
        layer.shadowRadius = 3
        layer.shadowOpacity = 3
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowColor = UIColor(named: "shadow")?.cgColor
    }
    
    func dropShadow2() {
        layer.shadowRadius = 3
        layer.shadowOpacity = 3
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowColor = UIColor(named: "shadow2")?.cgColor
    }
    
    func dropShadow3() {
        layer.shadowRadius = 3
        layer.shadowOpacity = 3
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowColor = UIColor(named: "shadow3")?.cgColor
    }
    
    func dropShadowHerer() {
        layer.shadowColor = UIColor(named: "newShadow")?.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 0.2
        layer.shadowOpacity = 15
        layer.masksToBounds = false
    }
}

