//
//  ModelAnalysisViewController.swift
//  CarBois
//
//  Created by Umer Yasin on 08/09/2022.
//

import UIKit
import FittedSheets
import PUGifLoading
import SDWebImage
import WebKit
import SkeletonView
import MaterialShowcase

class ModelAnalysisViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MaterialShowcaseDelegate {
    
    
    
    
    @IBOutlet weak var feedbackButton: UIButton!
    @IBOutlet weak var sharebutton: UIButton!
    private var dashboardFilterViewModel = FilterVcViewModel()
    private var HomedashboardFilterViewModel = HomeViewControllerVM()

    private var modelAnalysisViewModel = ModelAnalysisViewModel()
    
    let loading = PUGIFLoading()
    
    
    @IBOutlet weak var filterView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var filterDeatilView: UIView!
    @IBOutlet weak var trimLabel: UILabel!
    @IBOutlet weak var subGenLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var subGenWidthConstant: NSLayoutConstraint!
    @IBOutlet weak var modelLabelWidthConst: NSLayoutConstraint!
    
    
    var isLoadingSkeletonView = false
    var islive:Bool?
    @IBOutlet weak var wantToBuyHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var wtbButton: UIButton!
    @IBOutlet weak var constVottom: NSLayoutConstraint!
    
    @IBOutlet weak var createWTBListingBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        addxibFiletoView(view: filterView, nibName: "FilterView")
        filterDeatilView.dropShadow()
        collectionView.register(UINib(nibName: "filterStackCell", bundle: nil), forCellWithReuseIdentifier: "filterStackCell")
        collectionView.register(UINib(nibName: "AnalysisFilter", bundle: nil), forCellWithReuseIdentifier: "AnalysisFilter")
        collectionView.register(UINib(nibName: "GraphCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GraphCollectionViewCell")
        collectionView.register(UINib(nibName: "graphFilter", bundle: nil), forCellWithReuseIdentifier: "graphFilter")
        collectionView.register(UINib(nibName: "CarFilterCell", bundle: nil), forCellWithReuseIdentifier: "CarFilterCell")
        collectionView.register(UINib(nibName: "CarDisplayDetailCell", bundle: nil), forCellWithReuseIdentifier: "CarDisplayDetailCell")
        collectionView.register(UINib(nibName: "NoSimilarCar", bundle: nil), forCellWithReuseIdentifier: "NoSimilarCar")
        collectionView.register(UINib(nibName: "ToggleSwitch", bundle: nil), forCellWithReuseIdentifier: "ToggleSwitch")
        collectionView.register(UINib(nibName: "ShimmerCell", bundle: nil), forCellWithReuseIdentifier: "ShimmerCell")

        collectionView.dataSource = self
        collectionView.delegate = self
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !UserDefaults.standard.bool(forKey: "Share"){
            showTutorial()
        }
    }
    func showCaseDidDismiss(showcase: MaterialShowcase, didTapTarget: Bool) {
        UserDefaults.standard.set(true, forKey: "Share")
        NotificationCenter.default.post(name: Notification.Name("myNotification"), object: nil, userInfo: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("myNotification"), object: nil)
    }
    
    func showTutorial(){
        let showcase = MaterialShowcase()
        showcase.setTargetView(view: sharebutton) // always required to set targetView
        showcase.primaryText = "Share"
        showcase.primaryTextSize = CGFloat(30)
        showcase.secondaryText = "Share the analysis of these car with your family or friends."
        showcase.secondaryTextSize = CGFloat(20)
        showcase.backgroundPromptColor = UIColor(named: "AccentColor")
        showcase.show(completion: {
            // You can save showcase state here
            // Later you can check and do not show it again
        })
        showcase.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        if AppUtility.moveTopop {
            collectionView.reloadData()
            self.collectionView?.scrollToItem(at: IndexPath(row: 0, section: 0),
                                              at: .top,
                                              animated: true)
            AppUtility.moveTopop = false
        }
        greetingLabel.text = getTime()
        userName.text = UserDefaults.standard.string(forKey: "username")
        
        if AppUtility.showFIrstTimeLoader{
            showModelAnalysis()
            AppUtility.showFIrstTimeLoader = false
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.addimage(_:)), name: NSNotification.Name(rawValue: "navigateToSellYourCarVC"), object: nil)
        AppUtility.moveToCarDetailFormModelAnalysis = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        if !AppUtility.moveToCarDetailFormModelAnalysis {
            for controller in (self.navigationController?.viewControllers ?? [UIViewController()]) as Array {
                if controller.isKind(of: HomeViewController.self) {
                    self.navigationController!.popToViewController(controller, animated: true)
                    break
                    
                }
            }
        }
        
    }
    
    @IBAction func onCLickFilterHistoryBar(_ sender: Any) {
        presentSheet(viewController: "FilterVc")
    }
    
    func addxibFiletoView(view:UIView,nibName:String){
        let child = UINib(nibName: nibName, bundle: .main).instantiate(withOwner: nil, options: nil).first as! FilterView
        child.frame = view.bounds
        child.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        child.clickAction = { [self] () in
            presentSheet(viewController: "FilterVc")
        }
        UIView.transition(with: view, duration: 0.5, options: [.transitionCrossDissolve,.allowAnimatedContent,.curveEaseInOut,.layoutSubviews], animations: { [] in
            view.addSubview(child)
        }, completion: nil)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else  if section == 1 {
            if AppUtility.showOrHideLiveButton{
                return 0
            }else{
                return 1
            }
        }else  if section == 2 {
            return 1
        }else  if section == 3 {
            if AppUtility.ToggleState! || AppUtility.showCurrentHistoric{
                return 0
            }else{
                return 1
            }
        }else  if section == 4 {
            return 1
        }else{
//            if !AppUtility.averageGraphCarList.isEmpty {
                if AppUtility.ToggleState!{
                    if AppUtility.carListInModelAnalysisInLiveCase?.count != 0 {
                        if isLoadingSkeletonView{
                            return 4
                        }else{
                            return (AppUtility.carListInModelAnalysisInLiveCase?.count ?? 0)
                        }
                    }else{
                        return 1
                    }
                }else{
                    if AppUtility.averageGraphCarList.count != 0 {
                        if isLoadingSkeletonView{
                            return 4
                        }else{
                            return (AppUtility.averageGraphCarList.count)
                        }
                    }else if AppUtility.multiHistoricCarList.count > 0 {
                        if isLoadingSkeletonView{
                            return 4
                        }else{
                            return AppUtility.multiHistoricCarList.count
                        }
                    }else{
                        return 1
                    }
                }
            
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.currencySymbol = "$"
        
        let strNumber = NumberFormatter()
        strNumber.numberStyle = .decimal
        
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterStackCell", for: indexPath) as! filterStackCell
            if AppUtility.ModelPricingDataModel != nil {
                
                cell.modelName.text = AppUtility.ModelPricingDataModel?.make?.capitalized
                cell.makeNmae.text = AppUtility.ModelPricingDataModel?.model?.capitalized
                
                let currentAveragePrice = numberFormatter.string(from: NSNumber(value: AppUtility.ModelPricingDataModel?.marketPricesAndVector?.currentMonthMarketAverage?.average ?? 0))
                cell.currentAveragePrice.text = currentAveragePrice
                
                let lastMonthPrice = numberFormatter.string(from: NSNumber(value: AppUtility.ModelPricingDataModel?.marketPricesAndVector?.perviousMonthMarketAverage?.average ?? 0))
                cell.lastMonthPrice.text = lastMonthPrice
                
                cell.lastMonth.text = AppUtility.ModelPricingDataModel?.dateObj?.current?.formattedCurrentDate
                
                if AppUtility.ModelPricingDataModel?.marketPricesAndVector?.percentageChange?.direction == "increase" {
                    
                    let currentPriceChange = numberFormatter.string(from: NSNumber(value: AppUtility.ModelPricingDataModel?.marketPricesAndVector?.percentageChange?.magnitude ?? 0))
                    cell.currentPriceChange.text = "\(currentPriceChange!)(+\(AppUtility.ModelPricingDataModel?.marketPricesAndVector?.percentageChange?.percentage ?? 0.0)%)"
                    cell.currentPriceChange.textColor = UIColor(named: "grapgGreen")
                    cell.currentPriceChangeImage.tintColor = UIColor(named: "grapgGreen")
                    cell.currentPriceChangeImage.image = UIImage(named: "upArrow")

                    
                }else{
                    
                    let currentPriceChange = numberFormatter.string(from: NSNumber(value: AppUtility.ModelPricingDataModel?.marketPricesAndVector?.percentageChange?.magnitude ?? 0))
                    cell.currentPriceChange.text = "\(currentPriceChange!)(-\(AppUtility.ModelPricingDataModel?.marketPricesAndVector?.percentageChange?.percentage ?? 0.0)%)"
                    cell.currentPriceChange.textColor = .red
                    cell.currentPriceChangeImage.image = UIImage(named: "decrease")
                }
                modelLabel.text = AppUtility.generation ?? "All"
                subGenLabel.text = AppUtility.subGen ?? "All"
                trimLabel.text = AppUtility.subTrims ?? "All"
                
                
                
                let genArray = AppUtility.subGen?.split(separator: ",")
                let attribStrings = genArray?.map { element in
                    for item2 in AppUtility.seletedTableIndex{
                        if element == item2.CarSubGenerationName{
                            return NSAttributedString(string: String(element+","), attributes: [
                                .foregroundColor: UIColor(named: item2.Color)!,
                                .font: UIFont(name: "Inter-Regular", size: 14)!
                            ])
                        }
                    }
                    return NSAttributedString(string: "",attributes: [:])
                }
                let finalSubGenString = NSMutableAttributedString()
                for temp in attribStrings ?? [] {
                    finalSubGenString.append(temp)
                }
                if finalSubGenString.length > 1 {
                    finalSubGenString.deleteCharacters(in: NSRange(location: finalSubGenString.length - 1, length: 1))
                }
                subGenLabel.attributedText = finalSubGenString.isEqual(to: NSMutableAttributedString()) ? NSAttributedString(string: String("All"), attributes: [.foregroundColor: UIColor.black,.font: UIFont(name: "Inter-Regular", size: 14)!]) : finalSubGenString
                
                
                let trimArray = AppUtility.subTrims?.split(separator: ",")
                let attribStrings2 = trimArray?.map { element in
                    for item2 in AppUtility.seletedTableIndex{
                        if element == item2.TrimDefinitionName{
                            return NSAttributedString(string: String(element+","), attributes: [
                                .foregroundColor: UIColor(named: item2.Color)!,
                                .font: UIFont(name: "Inter-Regular", size: 14)!
                            ])
                        }
                    }
                    return NSAttributedString(string: "",attributes: [:])
                }
                let finalSubGenString2 = NSMutableAttributedString()
                for temp in attribStrings2 ?? [] {
                    finalSubGenString2.append(temp)
                }
                if finalSubGenString2.length > 1 {
                    finalSubGenString2.deleteCharacters(in: NSRange(location: finalSubGenString2.length - 1, length: 1))
                }
                trimLabel.attributedText = finalSubGenString2.isEqual(to: NSMutableAttributedString()) ? NSAttributedString(string: String("All"), attributes: [.foregroundColor: UIColor.black,.font: UIFont(name: "Inter-Regular", size: 14)!]) : finalSubGenString2
                trimLabel.frame.size = trimLabel.intrinsicContentSize

                
//                subGenWidthConstant = 1
//                modelLabelWidthConst.constant = 2
                modelLabel.sizeToFit()
                subGenLabel.sizeToFit()
                trimLabel.sizeToFit()
                
                
            }
            return cell
        }else if indexPath.section == 1{
            if AppUtility.graphData == nil {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnalysisFilter", for: indexPath) as! AnalysisFilter
                cell.onCLickFilterButton = { () in
                    self.presentSheet(viewController: "AnalysisFilterVc")
                }
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ToggleSwitch", for: indexPath) as! ToggleSwitch
                cell.makeButtonNormal()
                cell.sendSwitchState = { [self] (state) in
                    print(state)
                    if state{
                        AlertHelper.showAlertWithTitle(self, title: "Live listings are in beta and may experience issues.",dismissButtonTitle: "OK") { () -> Void in
                        }
                    }
                    showLoader(loader: loading)
                    AppUtility.ToggleState = state
                    AppUtility.showCurrentHistoric = state
                    AppUtility.FilterApplied = nil
                    isLoadingSkeletonView = true
//                    self.collectionView.reloadData()
                    changeGraphFilter(tenure: AppUtility.Tenure?.rawValue ?? "one_year", filterRequest: true, is_live: state)
                }
                return cell
            }
           
        }else if indexPath.section == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GraphCollectionViewCell", for: indexPath) as! GraphCollectionViewCell
            if AppUtility.graphData != nil {
                if AppUtility.ToggleState!{
                    cell.showLiveDataGraph(graphData: AppUtility.graphDataInLiveCase!)
//                    cell.getgraphDatail_isLive(graphData: AppUtility.graphData!)
                }else{
                    cell.getgraphData(graphData: AppUtility.graphData!)
                }
            }else if AppUtility.multiHistoricGraphData != nil{
                if AppUtility.ToggleState!{
                    cell.showHistoricLiveDataGraph(graphData: AppUtility.graphDataInLiveCase!)

                }else{
                    if AppUtility.showCurrentHistoric{
                        cell.getHistoricGraphDataLiveListing(graphData: AppUtility.multiHistoricGraphData!)
                    }else{
                        cell.getHistoricGraphData(graphData: AppUtility.multiHistoricGraphData!)

                    }
                }
               
            }
            
            
            cell.CarTapAction = { [self] (carId) in
                AppUtility.SortApplied = nil
                AppUtility.moveToCarDetailFormModelAnalysis = true
                showLoader(loader: loading)
                getCarDetail(carId: carId)
                print("view BUTTON TAPPED.")
                
            }
            
            return cell
        }else if indexPath.section == 3{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "graphFilter", for: indexPath) as! graphFilter
            cell.segmentcontrol.selectedSegmentIndex = AppUtility.SelectedIndex
            cell.segmentCompletion = { [self] (tenure) in
                showLoader(loader: loading)
                isLoadingSkeletonView = true
                self.collectionView.reloadData()
                changeGraphFilter(tenure: tenure, filterRequest: true, is_live: false)
                
            }
            return cell
        }else if indexPath.section == 4{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarFilterCell", for: indexPath) as! CarFilterCell
            if AppUtility.ToggleState! || AppUtility.showCurrentHistoric{
                cell.lbl.text = "Live For Sale Listings:"
                wantToBuyHeightConstant.constant = 40
                wtbButton.isHidden = false
                constVottom.constant = 12
                cell.hideButtonAndViews()
            }else{
                wantToBuyHeightConstant.constant = 0
                wtbButton.isHidden = true
                constVottom.constant = 0
                cell.lbl.text = "Completed Listings:"

            }
            cell.onCLickFilterButtonAction = { [self] () in
                showLoader(loader: loading)
                if AppUtility.filterRequestBody != nil {
                    
                    var req = AverageGraphFilterListingRequestModel(carType: AppUtility.selectedCoditionValue ?? "used", carMakeId: AppUtility.selectedMakeValue ?? 0, carModelId: AppUtility.selectedModelValue ?? 0, tenure: AppUtility.Tenure?.rawValue ?? "one_year")
                    if AppUtility.FilterApplied != nil {
                        req.filters = AppUtility.FilterApplied
                    }
                    req.sortBy = AppUtility.SortApplied ?? nil
                    if AppUtility.ToggleState! || AppUtility.showCurrentHistoric{
                        req.view_live_data = true

                    }else{
                        req.view_live_data = false

                    }
                    AppUtility.carDetailFilterBody = nil
                    modelAnalysisViewModel.getAverageGraphFilterListing(requestModel: req) { [self] (result) in
                        switch result{
                        case .success(let resp):
                            hideLoader(loader: loading)
                            AppUtility.AverageGraphFilter = resp
                            AppUtility.HistoricGraphFilter = nil
                            AppUtility.CarDetailFilter = nil
                            self.presentSheet(viewController: "CarAndListingFilter")
                        case .failure(let error):
                            let err = CustomError(description: (error as? CustomError)?.description ?? "")
                            print(err)
                            AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                            }
                        }
                    }
                    
                    
                }else{
                    var reqq = AppUtility.historicGraphRequestBody
                    reqq?.tenure = AppUtility.Tenure?.rawValue ?? "one_year"
                    if AppUtility.FilterApplied != nil {
                        reqq?.filters = AppUtility.FilterApplied
                    }
                    reqq?.sortBy = AppUtility.SortApplied ?? nil
                    if AppUtility.ToggleState! || AppUtility.showCurrentHistoric{
                        reqq?.view_live_data = true

                    }else{
                        reqq?.view_live_data = false

                    }
                    AppUtility.carDetailFilterBody = nil
                    modelAnalysisViewModel.getHistoricGraphFilterListing(request: reqq!) { [self] (result) in
                        switch result{
                        case .success(let resp):
                            hideLoader(loader: loading)
                            AppUtility.AverageGraphFilter = nil
                            AppUtility.HistoricGraphFilter = resp
                            AppUtility.CarDetailFilter = nil
                            self.presentSheet(viewController: "CarAndListingFilter")
                        case .failure(let error):
                            let err = CustomError(description: (error as? CustomError)?.description ?? "")
                            print(err)
                            AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                            }
                        }
                    }
                }
                
            }
            return cell
        }else{
            
          
            
            if (AppUtility.averageGraphCarList.count == 0) && AppUtility.multiHistoricCarList.count == 0 && AppUtility.carListInModelAnalysisInLiveCase?.count ?? 0 == 0{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoSimilarCar", for: indexPath) as! NoSimilarCar
                return cell
            }else{
                
                if isLoadingSkeletonView{
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShimmerCell", for: indexPath) as! ShimmerCell
                    cell.makeCellAnimate()
                    return cell
                    
                }else{
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarDisplayDetailCell", for: indexPath) as! CarDisplayDetailCell
                    cell.addToSavedbtnTapAction = { () in
                        print("SAVE BUTTON TAPPED.")
                    }
                    cell.addToGaragebtnTapAction = { () in
                        print("Garage BUTTON TAPPED.")
                    }
                    cell.viewbtnTapAction = { [self] (carId) in
                        AppUtility.SortApplied = nil
                        showLoader(loader: loading)
                        AppUtility.moveToCarDetailFormModelAnalysis = true
                        getCarDetail(carId: cell.carId!)
                        print("view BUTTON TAPPED.")
                        
                    }
                    cell.viewbtnTapActionLive = { [self] (carId) in
                        AppUtility.SortApplied = nil
                        showLoader(loader: loading)
                        AppUtility.moveToCarDetailFormModelAnalysis = true
                        callCarDetailApi(uuid: carId,isfromWhichListing: true)
                        print("view BUTTON TAPPED.")
                        
                    }
                    if AppUtility.ToggleState!{
                        cell.configureCellLive(cellData: AppUtility.carListInModelAnalysisInLiveCase![indexPath.row])
                    }else{
                        if AppUtility.averageGraphCarList.count != 0{
                            cell.configureCell(cellData: AppUtility.averageGraphCarList[indexPath.row],isLoadingShimmer: isLoadingSkeletonView)
                        }else{
                            cell.configureCell2(cellData: AppUtility.multiHistoricCarList[indexPath.row])
                        }
                    }
                   
                    return cell
                }
            }
  
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (AppUtility.averageGraphCarList.count == 0) && AppUtility.multiHistoricCarList.count == 0 && AppUtility.carListInModelAnalysisInLiveCase?.count == 0{
            
        }else{
            if AppUtility.ToggleState!{
                AppUtility.FilterAppliedCarDetail = nil
                AppUtility.SortApplied = nil
                showLoader(loader: loading)
                AppUtility.moveToCarDetailFormModelAnalysis = true
                callCarDetailApi(uuid: AppUtility.carListInModelAnalysisInLiveCase![indexPath.row].uuid ?? "",isfromWhichListing: true)
            }else{
                if indexPath.section == 5 {
                    if AppUtility.averageGraphCarList.count != 0 {
        //                AppUtility.FilterApplied = nil
                        AppUtility.FilterAppliedCarDetail = nil
                        AppUtility.SortApplied = nil
                        showLoader(loader: loading)
                        AppUtility.moveToCarDetailFormModelAnalysis = true
                        getCarDetail(carId: AppUtility.averageGraphCarList[indexPath.row].id ?? 0)
                    }else{
        //                AppUtility.FilterApplied = nil
                        AppUtility.FilterAppliedCarDetail = nil

                        AppUtility.SortApplied = nil
                        showLoader(loader: loading)
                        AppUtility.moveToCarDetailFormModelAnalysis = true
                        getCarDetail(carId: AppUtility.multiHistoricCarList[indexPath.row].id ?? 0)
                    }
                }
            }
  
        }
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        if indexPath.section == 0 {
            let cellSize = CGSize(width: collectionView.bounds.width , height: 50)
            return cellSize
            
        }else if indexPath.section == 1 {
            let cellSize = CGSize(width: collectionView.bounds.width , height: 30)
            return cellSize
        }else if indexPath.section == 2 {
            let cellSize = CGSize(width: collectionView.bounds.width - 2 , height: 225)
            return cellSize
            
        }else if indexPath.section == 3 {
                let cellSize = CGSize(width: collectionView.bounds.width - 12 , height: 30)
                return cellSize
            
        }else if indexPath.section == 4 {
            let cellSize = CGSize(width: collectionView.bounds.width - 12 , height: 30)
            return cellSize
            
        }else{
            if (AppUtility.averageGraphCarList.count == 0 ) && AppUtility.multiHistoricCarList.count == 0 && AppUtility.carListInModelAnalysisInLiveCase?.count ?? 0 == 0{
                let cellSize = CGSize(width: (collectionView.bounds.width) - 13, height: 100)
                return cellSize
            }else{
                let cellSize = CGSize(width: (collectionView.bounds.width / 2) - 13, height: 270)
                return cellSize
            }
            
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if AppUtility.ToggleState!{
            if indexPath.section == 5 && indexPath.row == (AppUtility.carListInModelAnalysisInLiveCase!.count) - 1{
                if AppUtility.totalCarsAverage != AppUtility.carListInModelAnalysisInLiveCase?.count ?? 0 {
                    getLiveListingCarsPagination()
                }
               
            }
        }else{
            if AppUtility.filterRequestBody != nil {
                if indexPath.section == 5 && indexPath.row == (AppUtility.averageGraphCarList.count) - 1{
                    if AppUtility.totalCarsAverage != AppUtility.averageGraphCarList.count {
                        fetchMoreCarsAverage()
                    }

                    
                }
            }else{
                if indexPath.section == 5 && indexPath.row == AppUtility.multiHistoricCarList.count - 1{
                    if AppUtility.toatalCarsHistoric != AppUtility.multiHistoricCarList.count {
                        fetchMoreCars()
                    }
                    
                }
            }
        }
    }
    
    func fetchMoreCars(){
        showLoader(loader: loading)
        var req =  AppUtility.historiccarListModelreq
        let offset = req?.offset
        let limit = req?.limit
        req?.offset = offset!+limit!
        AppUtility.historiccarListModelreq = req
        dashboardFilterViewModel.getHistoriccarList(requestModel: req!) { [self] (result) in
            switch result{
            case .success(let result):
                AppUtility.multiHistoricCarList.append(contentsOf: result.data?.matchingHistoricListings?.paginatedArr ?? [])
                collectionView.reloadSections(IndexSet(integer: 5))
               hideLoader(loader: loading)
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                }
               hideLoader(loader: loading)
            }
        }
    }
    
    func fetchMoreCarsAverage(){
        showLoader(loader: loading)
        var req = AppUtility.averageGraphCarListRequest
        let offset = req?.offset
        let limit = req?.limit
        req?.offset = offset!+limit!
        AppUtility.averageGraphCarListRequest = req

        dashboardFilterViewModel.getAverageGraphCarList(requestModel: req!) { [self] (result) in
            switch result{
            case .success(let result):
                AppUtility.averageGraphCarList.append(contentsOf: result.data?.averageGraphCarsList?.currentTenureCarsList ?? [])
                collectionView.reloadSections(IndexSet(integer: 5))
               hideLoader(loader: loading)
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                }
            }
        }
    }
    
    func getLiveListingCarsPagination(){
        
     
        var genAndTrim = [sub_gens_and_trim_defs]()
        for item in AppUtility.seletedTableIndex {
            if item.isSubGen{
                let mb = sub_gens_and_trim_defs(carSubGenerationId: item.CarSubGenerationId)
                genAndTrim.append(mb)
            }else{
                let mb = sub_gens_and_trim_defs(carSubGenerationId: item.CarSubGenerationId, trimDefinitionId: item.TrimDefinitionId)
                genAndTrim.append(mb)
            }
        }
        var request2 = gethomecardetailListinghRequest(carModelId: AppUtility.dashboardFilterData?.data?.carMake?[AppUtility.selectedMake].models?[AppUtility.selectedModel].id ?? -1,carMakeId: AppUtility.dashboardFilterData?.data?.carMake?[AppUtility.selectedMake].id ?? -1,sub_gens_and_trim_defs: genAndTrim)
        
        request2.pageLimit = 40
        request2.pageOffset = (AppUtility.carListInModelAnalysisInLiveCase?.count ?? 0) + 40
        
        dashboardFilterViewModel.getLiveListing(requestModel: request2) { [self] (result) in
            switch result{
            case .success(let result):
                AppUtility.carListInModelAnalysisInLiveCase?.append(contentsOf: result.data?.listings ?? [])
                collectionView.reloadSections(IndexSet(integer: 5))
                hideLoader(loader: loading)
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 18, left: 0, bottom: 0, right: 0)
            
        }else if section == 1 {
            if AppUtility.showOrHideLiveButton{
                return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }else{
                return UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
            }
        }else if section == 2 {
            return UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
            
        }else if section == 3 {
            return UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
            
        }else if section == 4 {
            return UIEdgeInsets(top: 24, left: 0, bottom: 16, right: 0)
            
        }else{
            return UIEdgeInsets(top: 0, left: 5, bottom: 8, right: 5)
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
            let controller2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FilterVc")
            let AnalysisFilterVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AnalysisFilterVc")
            let CarAndListingFilter = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CarAndListingFilter")
            
            
            if sheetController.childViewController.nibName == controller2.nibName {
                collectionView.reloadData()
            }
            if sheetController.childViewController.nibName == AnalysisFilterVc.nibName {
                if AppUtility.is_filter_Applied{
                    if AppUtility.showCurrentHistoric{
                        changeGraphFilter(tenure: AppUtility.Tenure?.rawValue ?? "one_year", filterRequest: true, is_live: true)
                    }else{
                        changeGraphFilter(tenure: AppUtility.Tenure?.rawValue ?? "one_year", filterRequest: true, is_live: false)

                    }
                    AppUtility.is_filter_Applied = false
                    showLoader(loader: loading)
                }
            }
            if sheetController.childViewController.nibName == CarAndListingFilter.nibName {
               hideLoader(loader: loading)
                if AppUtility.FilterAppliedFromList ?? false{
                    AppUtility.FilterAppliedFromList = false
                    print("yESh")
                    showLoader(loader: loading)
                    if AppUtility.ToggleState! || AppUtility.showCurrentHistoric{
                        changeGraphFilter(tenure: AppUtility.Tenure?.rawValue ?? "one_year", filterRequest: true, is_live: true)
                    }else{
                        changeGraphFilter(tenure: AppUtility.Tenure?.rawValue ?? "one_year", filterRequest: true, is_live: false)


                    }
                }
            }
        }
        
        
        self.present(sheetController, animated: true, completion: nil)
        
    }
    
    func changeGraphFilter(tenure:String,filterRequest:Bool,is_live:Bool){
        
        if AppUtility.filterRequestBody != nil {
            var request = AppUtility.filterRequestBody
            request?.tenure = tenure
            if filterRequest{
                request?.filters = AppUtility.FilterApplied ?? nil
            }
            if is_live{
                request?.view_live_data = true
            }else{
                request?.view_live_data = false
            }
            if request!.view_live_data! {
                
                let genAndTrim = sub_gens_and_trim_defs()
                let request2 = gethomecardetailGraphRequest(carModelId: request?.carModelId , carMakeId: request?.carMakeId, sub_gens_and_trim_defs: [sub_gens_and_trim_defs]())
                dashboardFilterViewModel.getHomeCarDetailgraph(requestModel: request2) { [self] (result) in
                    switch result{
                    case .success(let result):
                        AppUtility.graphDataInLiveCase = result.data
                        var req = AverageGraphCarListRequest(carType: request!.carType, carMakeId: request!.carMakeId, carModelId: request!.carModelId, tenure: tenure, limit: 20, offset: 0)
                        if filterRequest{
                            req.filters = AppUtility.FilterApplied ?? nil
                            req.sortBy = AppUtility.SortApplied

                        }
                        if is_live{
                            req.view_live_data = is_live
                        }else{
                            req.view_live_data = false
                        }
                        
                        if req.view_live_data!{
                            getAverageGraphCarListLive(request: req)
                        }else{
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

            }else{
                dashboardFilterViewModel.getGraphData(requestModel: request!) { [self] (result) in
                    switch result{
                    case .success(let result):
                        AppUtility.graphData = result.data
                        var req = AverageGraphCarListRequest(carType: request!.carType, carMakeId: request!.carMakeId, carModelId: request!.carModelId, tenure: tenure, limit: 20, offset: 0)
                        if filterRequest{
                            req.filters = AppUtility.FilterApplied ?? nil
                            req.sortBy = AppUtility.SortApplied

                        }
                        if is_live{
                            req.view_live_data = is_live
                        }else{
                            req.view_live_data = false
                        }
                        getAverageGraphCarList(request: req)
                    case .failure(let error):
                        let err = CustomError(description: (error as? CustomError)?.description ?? "")
                        print(err)
                        AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                        }
                       hideLoader(loader: loading)
                    }
                }
            }
 
        }else{
            var request = AppUtility.historicGraphRequestBody
            request?.tenure = tenure
            if filterRequest{
                request?.filters = AppUtility.FilterApplied ?? nil

            }
            if is_live{
                request?.view_live_data = true
            }else{
                request?.view_live_data = false

            }
            
            if is_live{
                
                var genAndTrim = [sub_gens_and_trim_defs]()
                
                for item in request?.cars ?? [car](){
                    genAndTrim.append(sub_gens_and_trim_defs(carSubGenerationId: item.subGenerationId ?? nil,trimDefinitionId: item.trimDefinitionId ?? nil))
                }
                                      
                let request12 = gethomecardetailGraphRequest(carModelId: AppUtility.dashboardFilterData?.data?.carMake![AppUtility.selectedMake].id! , carMakeId: AppUtility.dashboardFilterData?.data?.carMake![AppUtility.selectedMake].models![AppUtility.selectedModel].id!, sub_gens_and_trim_defs: genAndTrim)
                
                dashboardFilterViewModel.getHomeCarDetailgraph(requestModel: request12) { [self] (result) in
                    switch result{
                    case .success(let result):
                        AppUtility.graphDataInLiveCase = result.data
                        AppUtility.graphData = nil
                        AppUtility.multiHistoricGraphData = MultiHistoricGraphDataModelHistoricGraphData(graphData: nil)
                        getHistorcCars(tenure: tenure, filterRequest: filterRequest, is_live: is_live)

                       
                        
                    case .failure(let error):
                        let err = CustomError(description: (error as? CustomError)?.description ?? "")
                        print(err)
                        AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in
                            
                        }
                        hideLoader(loader: loading)
                    }
                }
                
            }else{
                dashboardFilterViewModel.getHistoricGraphData(requestModel: request!) { [self] (result) in
                    switch result{
                    case .success(let result):
                        
                        AppUtility.multiHistoricGraphData = result.data?.historicGraphData
                        getHistorcCars(tenure: tenure, filterRequest: filterRequest, is_live: is_live)
                        
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
    }
    
    func getHistorcCars(tenure:String,filterRequest:Bool,is_live:Bool){
        var req = multiHistoriccarRequestModel(tenure: AppUtility.historicGraphRequestBody!.tenure, cars: AppUtility.historicGraphRequestBody!.cars, limit: 20, offset: 0, view_live_data: false)
        req.tenure = tenure
        if filterRequest{
            req.filters = AppUtility.FilterApplied ?? nil
            req.sortBy = AppUtility.SortApplied

        }
        if is_live{
            req.view_live_data = true
        }else{
            req.view_live_data = false

        }
        AppUtility.historiccarListModelreq = req
        
        if is_live{
            
            var genAndTrim = [sub_gens_and_trim_defs]()
            
            for item in req.cars{
                genAndTrim.append(sub_gens_and_trim_defs(carSubGenerationId: item.subGenerationId ?? nil,trimDefinitionId: item.trimDefinitionId ?? nil))
            }
                                  
            var request = gethomecardetailListinghRequest(carModelId: AppUtility.dashboardFilterData?.data?.carMake![AppUtility.selectedMake].id! , carMakeId: AppUtility.dashboardFilterData?.data?.carMake![AppUtility.selectedMake].models![AppUtility.selectedModel].id!, sub_gens_and_trim_defs: genAndTrim)
            request.pageLimit = 40
            request.pageOffset = 0
            
            dashboardFilterViewModel.getLiveListing(requestModel: request) { [self] (result) in
                switch result{
                case .success(let result):
                    AppUtility.multiHistoricCarList =  [MultiHistoricCarListingPaginatedArr]()
                    AppUtility.toatalCarsHistoric = 0
                    isLoadingSkeletonView = false
                    AppUtility.carListInModelAnalysisInLiveCase = result.data?.listings ?? [WantToSaleListingModelListing]()
                    AppUtility.totalCarsAverage = result.data?.NumOfListings
                    AppUtility.averageGraphCarList = [AverageGraphCarListModelCurrentTenureCarsList]()

                    hideLoader(loader: loading)
                    collectionView.reloadData()
                    self.dismiss(animated: true)
                case .failure(let error):
                    let err = CustomError(description: (error as? CustomError)?.description ?? "")
                    print(err)
                    AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                    }
                }
            }
            
        }else{
            dashboardFilterViewModel.getHistoriccarList(requestModel: req) { [self] (result) in
                switch result{
                case .success(let result):
                    AppUtility.multiHistoricCarList = result.data?.matchingHistoricListings?.paginatedArr ?? []
                    AppUtility.toatalCarsHistoric = result.data?.matchingHistoricListings?.actualArrLength
                    AppUtility.averageGraphCarList = [AverageGraphCarListModelCurrentTenureCarsList]()
                    AppUtility.totalCarsAverage = 0
                    isLoadingSkeletonView = false
                    // commented by Ahtsham
//                    collectionView.reloadSections(IndexSet(integer: 2))
//                    collectionView.reloadSections(IndexSet(integer: 5))
//                    collectionView.reloadSections(IndexSet(integer: 3))
//                    collectionView.reloadSections(IndexSet(integer: 4))
                    collectionView.reloadData()

                   hideLoader(loader: loading)
                    self.dismiss(animated: true)
                case .failure(let error):
                    let err = CustomError(description: (error as? CustomError)?.description ?? "")
                    AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                    }
                   hideLoader(loader: loading)
                }
            }

        }
        
        
    }
    
    func getAverageGraphCarList(request:AverageGraphCarListRequest){
        AppUtility.averageGraphCarListRequest = request
        dashboardFilterViewModel.getAverageGraphCarList(requestModel: request) { [self] (result) in
            switch result{
            case .success(let result):
                print(result)
                AppUtility.averageGraphCarList = result.data?.averageGraphCarsList?.currentTenureCarsList ?? [AverageGraphCarListModelCurrentTenureCarsList]()
                AppUtility.totalCarsAverage = result.data?.averageGraphCarsList?.totalRecords
                AppUtility.multiHistoricCarList =  [MultiHistoricCarListingPaginatedArr]()
                AppUtility.carListInModelAnalysisInLiveCase = [WantToSaleListingModelListing]()
                AppUtility.toatalCarsHistoric = 0
                isLoadingSkeletonView = false
                // commented by Ahtsham
//                collectionView.reloadSections(IndexSet(integer: 2))
//                collectionView.reloadSections(IndexSet(integer: 5))
//                collectionView.reloadSections(IndexSet(integer: 3))
//                collectionView.reloadSections(IndexSet(integer: 4))
                collectionView.reloadData()

               hideLoader(loader: loading)
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                }
            }
        }
    }
    
    func getAverageGraphCarListLive(request:AverageGraphCarListRequest){
        
        let genAndTrim = sub_gens_and_trim_defs(carSubGenerationId: 1,trimDefinitionId:1)
        var request2 = gethomecardetailListinghRequest(carModelId: request.carModelId , carMakeId: request.carMakeId, sub_gens_and_trim_defs: [sub_gens_and_trim_defs]())
        request2.pageLimit = 40
        request2.pageOffset = 0
        
        dashboardFilterViewModel.getLiveListing(requestModel: request2) { [self] (result) in
            switch result{
            case .success(let result):
                AppUtility.multiHistoricCarList =  [MultiHistoricCarListingPaginatedArr]()
                AppUtility.toatalCarsHistoric = 0
                isLoadingSkeletonView = false
                AppUtility.carListInModelAnalysisInLiveCase = result.data?.listings ?? [WantToSaleListingModelListing]()
                AppUtility.totalCarsAverage = result.data?.NumOfListings
                AppUtility.averageGraphCarList = [AverageGraphCarListModelCurrentTenureCarsList]()

                hideLoader(loader: loading)
                collectionView.reloadData()
                self.dismiss(animated: true)
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                }
            }
        }
        
        
//        AppUtility.averageGraphCarListRequest = request
//        dashboardFilterViewModel.getAverageGraphCarList(requestModel: request) { [self] (result) in
//            switch result{
//            case .success(let result):
//                print(result)
//                AppUtility.averageGraphCarList = result.data?.averageGraphCarsList?.currentTenureCarsList ?? [AverageGraphCarListModelCurrentTenureCarsList]()
//                AppUtility.totalCarsAverage = result.data?.averageGraphCarsList?.totalRecords
//                AppUtility.multiHistoricCarList =  [MultiHistoricCarListingPaginatedArr]()
//                AppUtility.toatalCarsHistoric = 0
//                isLoadingSkeletonView = false
//                collectionView.reloadSections(IndexSet(integer: 2))
//                collectionView.reloadSections(IndexSet(integer: 5))
//                collectionView.reloadSections(IndexSet(integer: 3))
//                collectionView.reloadSections(IndexSet(integer: 4))
////                collectionView.reloadData()
//
//               hideLoader(loader: loading)
//            case .failure(let error):
//                let err = CustomError(description: (error as? CustomError)?.description ?? "")
//                print(err)
//                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in
//
//                }
//            }
//        }
    }
    
    func getCarDetail(carId:Int){
        let request = CarDetailRequestModel(id: carId)
        modelAnalysisViewModel.getCarDetail(requestModel: request) { [self] (result) in
            switch result{
            case .success(let result):
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
        if AppUtility.showCurrentHistoric || AppUtility.ToggleState!{
            request.view_live_data = true
        }else{
            request.view_live_data = false
        }
        request.sortBy = AppUtility.SortApplied
        request.offset = 0
        request.limit = 20
        modelAnalysisViewModel.getCarDetailSimilarListing(requestModel: request) { (result) in
            switch result{
            case .success(let result):
                self.getCarGraph(carId: carId, carDetail: carDetail,carSimilarListing: result)
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                }
            }
        }
    }
    func getCarDetailFilterListing(){
        
    }
    
    func getCarGraph(carId:Int,carDetail:CarDetailModel,carSimilarListing:CarDetailsSimilarListings){
        var request = CarDetailRequestModel(id: carId)
        if AppUtility.showCurrentHistoric || AppUtility.ToggleState!{
            request.view_live_data = true
        }else{
            request.view_live_data = false
        }
        modelAnalysisViewModel.getCarDetailGraph(requestModel: request) { [self] (result) in
            switch result{
            case .success(let result):
               hideLoader(loader: loading)
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CarDetailVC") as? CarDetailVC
                vc?.cardetailData = carDetail
                vc?.cardetailGraphData = result
                vc?.cardetailSimilarListing = carSimilarListing.data?.similarLiveListings?.similarListings ?? [CarDetailsSimilarListingsSimilarListing]()
                AppUtility.totalCarsCarDetail = carSimilarListing.data?.similarLiveListings?.totalRecords
                if AppUtility.showCurrentHistoric || AppUtility.ToggleState!{
                    vc?.is_liveListing = true
                }else{
                    vc?.is_liveListing = false
                }
                
                self.navigationController?.pushViewController(vc!, animated: true)
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                }
            }
        }
    }
    
    
    @IBAction func onClickShareButton(_ sender: Any) {
        DispatchQueue.main.async {
            
            do {
                let jsonData = try JSONEncoder().encode(AppUtility.seletedTableIndex)
                let jsonString = String(data: jsonData, encoding: .utf8)!
                
                let modelPricingData = try JSONEncoder().encode(AppUtility.ModelPricingDataModel)
                let modelPricingString = String(data: modelPricingData, encoding: .utf8)!
                
                let averageGraphData = try JSONEncoder().encode(AppUtility.graphData)
                let averageGraphString = String(data: averageGraphData, encoding: .utf8)!
                
                let historicGraphData = try JSONEncoder().encode(AppUtility.multiHistoricGraphData)
                let historicGraphString = String(data: historicGraphData, encoding: .utf8)!
                
                let filterApplied = try JSONEncoder().encode(AppUtility.FilterApplied)
                let filterAppliedString = String(data: filterApplied, encoding: .utf8)!
                
                let filterRequestBodyData = try JSONEncoder().encode(AppUtility.filterRequestBody)
                let filterRequestBodyString = String(data: filterRequestBodyData, encoding: .utf8)!
                
                let AverageCarListData = try JSONEncoder().encode(AppUtility.averageGraphCarList)
                let AverageCarListtring = String(data: AverageCarListData, encoding: .utf8)!
                
                let historicGraphReqBodyData = try JSONEncoder().encode(AppUtility.historicGraphRequestBody)
                let historicGraphReqBodysttring = String(data: historicGraphReqBodyData, encoding: .utf8)!
                
                let historicGraphcarData = try JSONEncoder().encode(AppUtility.multiHistoricGraphCarList)
                let historicGraphcarsttring = String(data: historicGraphcarData, encoding: .utf8)!
                
                
                let queryItems = [
                    URLQueryItem(name: "selectedCodition", value: "\(AppUtility.selectedCodition)"),
                    URLQueryItem(name: "selectedMake", value: "\(AppUtility.selectedMake)"),
                    URLQueryItem(name: "selectedModel", value: "\(AppUtility.selectedModel)"),
                    URLQueryItem(name: "selectedGeneration", value: "\(AppUtility.selectedGeneration)"),
                    URLQueryItem(name: "seletedTableIndex", value: "\(jsonString)"),
                    URLQueryItem(name: "ModelPricingDataModel", value: "\(modelPricingString)"),
                    URLQueryItem(name: "AverageGraphData", value: "\(averageGraphString)"),
                    URLQueryItem(name: "historicGraphData", value: "\(historicGraphString)"),
                    URLQueryItem(name: "tenure", value: "\(AppUtility.SelectedIndex)"),
                    URLQueryItem(name: "filterApplied", value: "\(filterAppliedString)"),
                    URLQueryItem(name: "filterRequestBody", value: "\(filterRequestBodyString)"),
                    URLQueryItem(name: "averageGraphCarList", value: "\(AverageCarListtring)"),
                    URLQueryItem(name: "historicGraphRequest", value: "\(historicGraphReqBodysttring)"),
                    URLQueryItem(name: "historicGraphcarData", value: "\(historicGraphcarsttring)"),
                    URLQueryItem(name: "modelLabel", value: "\(AppUtility.generation ?? "N/A")"),
                    URLQueryItem(name: "subGenLabel", value: "\(AppUtility.subGen ?? "")"),
                    URLQueryItem(name: "trimLabel", value: "\(AppUtility.subTrims ?? "")")
                ]
                
                
                var urlComps = URLComponents(string: "dev-microservices.horizonauto.com://")!
                urlComps.queryItems = queryItems
                let link = urlComps.url!
                let activityController = UIActivityViewController(activityItems: [link], applicationActivities: nil)
                activityController.completionWithItemsHandler = {(nil, completed, _, error) in
                    if completed {
                        print("completed")
                    }else {
                        print("cancled")
                    }
                }
                self.present(activityController, animated: true, completion: nil)
            } catch { print(error) }
        }
    }
    
    
    @IBAction func onClickFeedBackButton(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WebView") as? WebView
        vc?.webLink = "https://4n4dhxdgde8.typeform.com/to/Ne24UTdp"
        self.navigationController?.present(vc!, animated: true)

        
    }
    
    @IBAction func onCLickLogo(_ sender: Any) {
        for controller in (self.navigationController?.viewControllers ?? [UIViewController()]) as Array {
            if controller.isKind(of: HomeViewController.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
        dismiss(animated: true)
        tabBarController?.selectedIndex = 0
    }
    
    
    
    //MARK: - by default......
    
    
    func showModelAnalysis(){
        AppUtility.FilterApplied = nil
        AppUtility.SortApplied = nil
        AppUtility.showAverage = true
        AppUtility.showIndividualListing = false
        AppUtility.canNavigateFromDashboardFilter = true
        AppUtility.filterRequestBody = nil
        AppUtility.averageGraphCarList = [AverageGraphCarListModelCurrentTenureCarsList]()
        AppUtility.Tenure = nil
        AppUtility.historicGraphRequestBody = nil
        AppUtility.multiHistoricGraphCarList = [MultiHistoricGraphDataModelDataPoint]()
        AppUtility.SelectedIndex = 3

        AppUtility.selectedSellFilter?.make = 1 // this is id for Porsche
        AppUtility.selectedSellFilter?.model = 1 // this is id for 911
        
        AppUtility.selectedCodition = 1

        if(!AppUtility.fromContactBuyer){
            AppUtility.selectedMake = 8 // porshe index
            AppUtility.selectedModel = 0 // 911 index
            AppUtility.selectedGeneration = 0
        }
        
        AppUtility.seletedTableIndex = []
        
        showLoader(loader: loading)

        dashboardFilterViewModel.getCarMake(){ [self] (makeResult) in
            switch makeResult{
            case .success(let makeResult):
                print(makeResult)
                AppUtility.dashboardFilterData = makeResult

                var makeId = 1 // for porsche
                if(AppUtility.fromContactBuyer){
                    makeId = (AppUtility.selectedSellFilter?.make)!
                }
                dashboardFilterViewModel.getCarModels(id: makeId){ [self] (modelResult) in
                    switch modelResult{
                    case .success(let modelResult):
                        print(modelResult)
                        AppUtility.dashboardFilterData?.data?.carMake?[AppUtility.selectedMake].models = modelResult.data?.carModels
                        // call generations API
                        var modelId = 1
                        if(AppUtility.fromContactBuyer){
                            modelId = (AppUtility.selectedSellFilter?.model)!
                        }
                        dashboardFilterViewModel.getCarGenerations(id: modelId){ [self] (generationResult) in
                            switch generationResult{
                            case .success(let generationResult):
                                print(generationResult)
                                
                                hideLoader(loader: loading)
                                
                                AppUtility.dashboardFilterData?.data?.carMake?[AppUtility.selectedMake].models?[AppUtility.selectedModel].carGenerations = generationResult.data?.carGenerations
                                
                                
                                buySetDefaultData()
                                
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
    
    func buySetDefaultData(){
        
        for (index,item) in AppUtility.dashboardFilterData!.data!.carMake!.enumerated(){
            if item.id == AppUtility.selectedSellFilter?.make {
                AppUtility.selectedMake = index
            }
        }
        
        for (index,item) in AppUtility.dashboardFilterData!.data!.carMake![AppUtility.selectedMake].models!.enumerated(){
            if item.id == AppUtility.selectedSellFilter?.model {
                AppUtility.selectedModel = index
            }
        }
        
        for (index,item) in AppUtility.dashboardFilterData!.data!.carMake![AppUtility.selectedMake].models![AppUtility.selectedModel].carGenerations!.enumerated(){
            if item.id == AppUtility.selectedSellFilter?.gen {
                AppUtility.selectedGeneration = index
                AppUtility.selectedGeneration += 1
            }
        }
        
        var tableData : [dashboardfilteratabledataModel] = [dashboardfilteratabledataModel]()

        tableData.append(dashboardfilteratabledataModel(carGenerationID: AppUtility.selectedSellFilter?.gen ?? -1, CarSubGenerationId: AppUtility.selectedSellFilter?.subgen ?? -1, CarSubGenerationName: "N/A", CarSubGenerationPrice: 1900, CarSubGenerationdirection: "N/A", TrimDefinitionId: AppUtility.selectedSellFilter?.trim ?? -1, TrimDefinitionName: "N/A", TrimDefinitionPrice: 9009, TrimDefinitiondirection: "N/A", isSubGen: false, Color: "sliderLabel", isSelected: false))
        
        AppUtility.seletedTableIndex.append(tableData[0])
        
        AppUtility.filterAppliedFromCarDetailScreen = true
        
        AppUtility.SortApplied = nil
        AppUtility.ToggleState = true
        AppUtility.showCurrentHistoric = true
        
        AppUtility.generation = "All"
        AppUtility.subTrims = "All"
        AppUtility.subGen = "All"
        
        AppUtility.graphData = nil
        AppUtility.multiHistoricGraphData = nil
        AppUtility.ModelPricingDataModel = nil
        AppUtility.generation = nil
        AppUtility.subGen = nil
        AppUtility.subTrims = nil
        
        showLoader(loader: loading)
        
        var request = averageGraphRequestModel(carType: "used", carMakeId: AppUtility.selectedSellFilter?.make ?? 1, carModelId: AppUtility.selectedSellFilter?.model ?? 1, tenure: tenure.oneYear.rawValue)
        if AppUtility.showCurrentHistoric || AppUtility.ToggleState!{
            request.view_live_data = true
        }else{
            request.view_live_data = false
        }
        AppUtility.filterRequestBody = request
        AppUtility.selectedCoditionValue = "used"
        AppUtility.selectedMakeValue = 1
        AppUtility.selectedModelValue = 1

        let genAndTrim = sub_gens_and_trim_defs()
        let request2 = gethomecardetailGraphRequest(carModelId: request.carModelId , carMakeId: request.carMakeId, sub_gens_and_trim_defs: [sub_gens_and_trim_defs]())
        
        dashboardFilterViewModel.getHomeCarDetailgraph(requestModel: request2) { [self] (result) in
            switch result{
                
            case .success(let result):
                AppUtility.graphDataInLiveCase = result.data
                AppUtility.graphData = AverageGraphDataModelDataClass(filtersApplied: nil, averageGraphData: nil)
                modelPricingDataApi(check: false)
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                }
                hideLoader(loader: loading)
            }
        }
        
    }
    
    func modelPricingDataApi(check:Bool){
        let request = ModelPricingDataRequest(carType: "used", carMakeId: AppUtility.selectedSellFilter?.make ?? 1, carModelId: AppUtility.selectedSellFilter?.model ?? 1)
        dashboardFilterViewModel.getModelPricingData(requestModel: request) { [self] (result) in
            switch result{
            case .success(let result):
                AppUtility.ModelPricingDataModel = result.data
                if check{
                   
                   
                }else{
                    var req = AverageGraphCarListRequest(carType: "used", carMakeId: AppUtility.selectedSellFilter?.make ?? 1, carModelId: AppUtility.selectedSellFilter?.model ?? 1, tenure: tenure.oneYear.rawValue, limit: 20, offset: 0)
                    if AppUtility.showCurrentHistoric || AppUtility.ToggleState!{
                        req.view_live_data = true
                    }else{
                        req.view_live_data = false
                    }
                    if req.view_live_data!{
                        getLiveListingCars(req: req)
                    }else{
                        getAverageGraphCarListMo(request: req)

                    }
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
    
    func getLiveListingCars(req:AverageGraphCarListRequest){
        
        let genAndTrim = sub_gens_and_trim_defs(carSubGenerationId: 1,trimDefinitionId:1)
        var request2 = gethomecardetailListinghRequest(carModelId: req.carModelId , carMakeId: req.carMakeId, sub_gens_and_trim_defs: [sub_gens_and_trim_defs]())
        request2.pageLimit = 40
        request2.pageOffset = 0
        
        dashboardFilterViewModel.getLiveListing(requestModel: request2) { [self] (result) in
            switch result{
            case .success(let result):
                AppUtility.carListInModelAnalysisInLiveCase = result.data?.listings ?? [WantToSaleListingModelListing]()
                AppUtility.totalCarsAverage = result.data?.NumOfListings
                AppUtility.averageGraphCarList = [AverageGraphCarListModelCurrentTenureCarsList]()

                hideLoader(loader: loading)
                collectionView.reloadData()
                self.dismiss(animated: true)
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                }
            }
        }
    }
    
    func getAverageGraphCarListMo(request:AverageGraphCarListRequest){
        AppUtility.averageGraphCarListRequest = request

        dashboardFilterViewModel.getAverageGraphCarList(requestModel: request) { [self] (result) in
            switch result{
            case .success(let result):
                AppUtility.averageGraphCarList = result.data?.averageGraphCarsList?.currentTenureCarsList ?? [AverageGraphCarListModelCurrentTenureCarsList]()
                AppUtility.totalCarsAverage = result.data?.averageGraphCarsList?.totalRecords
                hideLoader(loader: loading)
                collectionView.reloadData()
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                }
                hideLoader(loader: loading)
            }
        }
    }
    
    
    @IBAction func onClickWTBListingBtn(_ sender: Any) {
        AppUtility.isUUidPresent = false
        let storyboard = UIStoryboard(name: "FindYourCar", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FindYourCarVC") as! FindYourCarVC
        vc.allowSearch = true
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated:true, completion: nil)
    }
    
    @objc func addimage(_ notification: NSNotification) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "navigateToSellYourCarVC"), object: nil)
        AppUtility.isfromHome = false
        AppUtility.isFromNavigationProg = true
        tabBarController?.selectedIndex = 2

    }
    
    
    //MARK: -
    //navigate to car detail in case of live
    func callCarDetailApi(uuid:String,isfromWhichListing:Bool){
        showLoader(loader: loading)
        let request = getHomeCarDetailRequest(uuid: uuid)
        HomedashboardFilterViewModel.getHomeCarDetail(requestModel: request) { [self] (result) in
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
        HomedashboardFilterViewModel.getHomeCarDetaillisting(requestModel: request) { [self] (result) in
            switch result{
            case .success(let result):
                callCarDetailGraphAPI(carDetails: carDetailed,cardetailListing: (result.data?.listing_id)!,isfromWhichListing: isfromWhichListing,uuid: uuid)
            case .failure(let error):
                hideLoader(loader: loading)
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
            }
        }
    }
    
    func callCarDetailGraphAPI(carDetails:HomecardetailModelDataClass,cardetailListing:[HomeCarDetailListingListingID],isfromWhichListing:Bool,uuid:String){
        
        let genAndTrim = sub_gens_and_trim_defs(carSubGenerationId: carDetails.carDetails?.car_sub_generation?.id ?? -1, trimDefinitionId: carDetails.carDetails?.trim_definition?.id ?? -1)
        let request = gethomecardetailGraphRequest(carModelId: carDetails.carDetails?.car_model?.id ?? -1, carMakeId: carDetails.carDetails?.car_make?.id ?? -1, sub_gens_and_trim_defs: [genAndTrim])
        
        
        HomedashboardFilterViewModel.getHomeCarDetailgraph(requestModel: request) { [self] (result) in
            switch result{
            case .success(let result):
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "BuySellCarDetailVC") as? BuySellCarDetailVC
                vc?.cardetailData = carDetails
                vc?.cardetailGraphData = result.data
                vc?.cardetailSimilarListing = cardetailListing
                vc?.isfromSaleOrWTB = isfromWhichListing
                vc?.isfromWhere = "ModelAnalysis"
                vc?.uuidCar = uuid
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

