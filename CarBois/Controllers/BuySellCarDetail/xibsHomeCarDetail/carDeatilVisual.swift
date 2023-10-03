//
//  carDeatilVisual.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 15/05/2023.
//

import UIKit
import ImageSlideshow

class carDeatilVisual: UICollectionViewCell,ImageSlideshowDelegate,ViewPagerDataSource {
    
    @IBOutlet weak var viewAllBtn: UIButton!
    @IBOutlet weak var imageViewCar: UIView!
    @IBOutlet weak var imageSlider: ImageSlideshow!
    @IBOutlet weak var pageIndeicator: UIView!
    @IBOutlet weak var stackView: UIView!
    
    var sdWebImageSource = [SDWebImageSource]()
    let pageControl3 = WOPageControl(frame: CGRect(x: 0, y: 0, width: 50, height: 50))

    @IBOutlet weak var spacingConstant: NSLayoutConstraint!
    @IBOutlet weak var viewBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var imageHeightContant: NSLayoutConstraint!
    var vc:UIViewController?

    
    @IBOutlet weak var carTitle: UIImageView!
    @IBOutlet weak var carAccident: UIImageView!
    @IBOutlet weak var carTranmission: UIImageView!
    @IBOutlet weak var carEngine: UIImageView!
    @IBOutlet weak var manualLabel: UILabel!
    
    var carDetail:HomecardetailModelCarDetails?
    var carDetailGraph:HomeCarDetailGraphDataClass?

    
    @IBOutlet weak var viewPager: ViewPager!
    var DetailType:Bool?
    
    @IBOutlet weak var pagerView: UIView!
    let pageControl2 = WOPageControl(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    var CarTapAction : ((String)->())?

    @IBOutlet weak var contactSellerButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var contactSelleerButton: UIButton!
    var contactSellerAction : (()->())?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        pageControl2.cornerRadius = 3;
        pageControl2.dotHeight = 6;
        pageControl2.dotSpace = 3;
        pageControl2.currentDotWidth = 18;
        pageControl2.otherDotWidth = 6;
        pageControl2.otherDotColor = UIColor(named: "currentDotWidth")
        pageControl2.currentDotColor = UIColor(named: "selectedBlackColor")
        pageControl2.numberOfPages = 2;

        pageControl2.center = CGPoint(x: pagerView.frame.width / 2, y: pagerView.frame.height / 2)
        pagerView.addSubview(pageControl2)
        
        viewPager.dataSource = self
        viewPager.scrollToPage(index: 0)
        viewPager.pageControl.isHidden = false
    }

    override func layoutSubviews() {
        
        configureShadow2(vi: imageViewCar)
        configureShadow2(vi: stackView)

    }
    
    override func prepareForReuse() {
        viewPager.scrollToPage(index: 1)
    }
    
    func addGraphData(detailType:Bool,graphData:HomeCarDetailGraphDataClass){
//        self.carDetailGraph = graphData
        self.DetailType = detailType
        self.carDetailGraph = graphData
        pageControl2.cornerRadius = 3;
        pageControl2.dotHeight = 6;
        pageControl2.dotSpace = 3;
        pageControl2.currentDotWidth = 18;
        pageControl2.otherDotWidth = 6;
        pageControl2.otherDotColor = UIColor(named: "currentDotWidth")
        pageControl2.currentDotColor = UIColor(named: "selectedBlackColor")
        
        if DetailType ?? false{
            pageControl2.numberOfPages = 4;
        }else{
            pageControl2.numberOfPages = 2;
        }

        pageControl2.center = CGPoint(x: pagerView.frame.width / 2, y: pagerView.frame.height / 2)
        pagerView.addSubview(pageControl2)
        
        viewPager.reloadData()
       
    }
    
    func numberOfItems(viewPager: ViewPager) -> Int {
        if DetailType ?? false{
            return 4;
        }else{
            return 2;
        }
       
    }
    
    func viewAtIndex(viewPager: ViewPager, index: Int, view: UIView?) -> UIView {
        if DetailType ?? false{
            
            if index == 0 {
                let newView = UIView()
                let child = UINib(nibName: "screen3", bundle: .main).instantiate(withOwner: nil, options: nil).first as! screen3
                child.frame = newView.bounds
                child.autoresizingMask = [.flexibleHeight, .flexibleWidth]
                child.configureCellData(cellData: carDetail!)
                newView.addSubview(child)
                return newView
            }else if index == 1{
                let newView = UIView()
                let child = UINib(nibName: "screen4", bundle: .main).instantiate(withOwner: nil, options: nil).first as! screen4
                child.frame = newView.bounds
                child.autoresizingMask = [.flexibleHeight, .flexibleWidth]
                child.configureCellData(cellData: carDetail!)
                newView.addSubview(child)
                return newView
            }else if index == 2{
                let newView = UIView()
                let child = UINib(nibName: "screen5", bundle: .main).instantiate(withOwner: nil, options: nil).first as! screen5
                child.frame = newView.bounds
                child.autoresizingMask = [.flexibleHeight, .flexibleWidth]
                child.configureCellData(cellData: carDetail!)
                newView.addSubview(child)
                return newView
            }else{
                let newView = UIView()
                let child = UINib(nibName: "CarDetailGraph", bundle: .main).instantiate(withOwner: nil, options: nil).first as! CarDetailGraph
                child.frame = newView.bounds
                child.autoresizingMask = [.flexibleHeight, .flexibleWidth]
                child.getHomeCarDetailGraphData(carDetailGraphData: carDetailGraph!,id: carDetail?.id ?? -1, carModelName: carDetail?.car_model?.model ?? "N/A" ,is_Live:false)
                child.CarTapAction = { [self] (carId) in
                    CarTapAction?(carId as? String ?? "")
                }
                newView.addSubview(child)
                return newView
            }
            
        }else{
            
            if index == 0 {
                let newView = UIView()
                let child = UINib(nibName: "screen1", bundle: .main).instantiate(withOwner: nil, options: nil).first as! screen1
                child.frame = newView.bounds
                child.autoresizingMask = [.flexibleHeight, .flexibleWidth]
                child.configureCellData(cellData: carDetail!)
                newView.addSubview(child)
                return newView
            }else if index == 1{
                let newView = UIView()
                let child = UINib(nibName: "screen2", bundle: .main).instantiate(withOwner: nil, options: nil).first as! screen2
                child.frame = newView.bounds
                child.autoresizingMask = [.flexibleHeight, .flexibleWidth]
                child.configureCellData(cellData: carDetail!)
                newView.addSubview(child)
                return newView
            }else{
                let newView = UIView()
                let child = UINib(nibName: "CarDetailGraph", bundle: .main).instantiate(withOwner: nil, options: nil).first as! CarDetailGraph
                child.frame = newView.bounds
                child.autoresizingMask = [.flexibleHeight, .flexibleWidth]
                child.getHomeCarDetailGraphData(carDetailGraphData: carDetailGraph!,id: carDetail?.id ?? -1, carModelName: carDetail?.car_model?.model ?? "N/A" ,is_Live:false)
                child.CarTapAction = { [self] (carId) in
                    CarTapAction?(carId as? String ?? "")
                }
                newView.addSubview(child)
                return newView
            }
            
        }
       
    }
    
    func currentIndex(index: Int) {
        if index == 0 {
            DispatchQueue.main.async { [self] in
                pageControl2.currentPage = 0
            }
        }else if index == 1 {
            DispatchQueue.main.async { [self] in
                pageControl2.currentPage = 1
            }
        }else if index == 2 {
            DispatchQueue.main.async { [self] in
                pageControl2.currentPage = 2
            }
        }else if index == 3 {
            DispatchQueue.main.async { [self] in
                pageControl2.currentPage = 3
            }
        }
    }
    
    //-------------------------
    
    func configureImages(images:[String],showImage:Bool,isfrom:String){
        if isfrom == "ModelAnalysis"{
            contactSellerButtonHeight.constant = 40
            contactSelleerButton.isHidden = false
        }else{
            contactSellerButtonHeight.constant = 0
            contactSelleerButton.isHidden = true
        }
        
        if showImage{
            imageHeightContant.constant = 190
            viewBtnHeight.constant = 24
            spacingConstant.constant = 24
            for item in images{
                sdWebImageSource.append(SDWebImageSource(urlString: item,placeholder: UIImage(named: "placeholder.png")!)!)
            }
//            if images.isEmpty {
//                sdWebImageSource.append(SDWebImageSource(urlString: "https://images.carstory.com/4400676417580629204/1/t/690x-?format=webp",placeholder: UIImage(named: "placeholder.png")!)!)
//
//            }
            imageSlider.pageIndicator = nil
            imageSlider.contentScaleMode = UIViewContentMode.scaleAspectFill
            imageSlider.activityIndicator = DefaultActivityIndicator()
            imageSlider.delegate = self
            imageSlider.setImageInputs(sdWebImageSource)
            
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
            imageSlider.addGestureRecognizer(recognizer)
            
            pageControl3.cornerRadius = 3;
            pageControl3.dotHeight = 6;
            pageControl3.dotSpace = 3;
            pageControl3.currentDotWidth = 18;
            pageControl3.otherDotWidth = 6;
            pageControl3.otherDotColor = .white
            pageControl3.currentDotColor = UIColor(named: "selectedBlackColor")
            pageControl3.numberOfPages = Int32(sdWebImageSource.count)

            
            pageIndeicator.addSubview(pageControl3)
            
            if images.count < 2 {
                viewAllBtn.isHidden = true
                pageIndeicator.isHidden = true
            }
        }else{
            imageHeightContant.constant = 0
            viewBtnHeight.constant = 0
            spacingConstant.constant = 0

        }
       
    }
    
    @objc func didTap() {
        let fullScreenController = imageSlider.presentFullScreenController( from: vc ?? UIViewController())
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .large, color: nil)
    }
    
    @IBAction func onCLickViewAll(_ sender: Any) {
        let fullScreenController = imageSlider.presentFullScreenController( from: vc ?? UIViewController())
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .large, color: nil)
    }
    
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        pageControl3.currentPage = Int32(page)
    }
    //........-----------
    
    func addSubViewForCarDetail(carDetail:HomecardetailModelCarDetails,showImage:Bool){
        self.carDetail = carDetail
        if showImage{
            addTitlePicture(cellData: carDetail.title_info ?? "")
            addTransmissionPicture(cellData: carDetail.transmission_type ?? "")
            addAccidentPicture(cellData: carDetail.carfax_accident_info ?? "")
            driveTypeAndEnginePicture(cellData: carDetail.trim_definition?.drive_type ?? "", cellData2: carDetail.car_sub_generation?.engine_layout ?? "")
            manualLabel.isHidden = true
        }else{
            manualLabel.isHidden = false
            carTitle.isHidden = true
            carAccident.isHidden = true
            carTranmission.isHidden = false
            carEngine.isHidden = true
        }
        
    }
    
    func addTitlePicture(cellData:String){
        let title: String = cellData
        switch title {
        case TitleInfo.Clean.rawValue:
            let image = UIImage(named: "paper")?.withRenderingMode(.alwaysTemplate)
            carTitle.image = image
            carTitle.tintColor = UIColor(named: "titleGreen")
        case TitleInfo.Salvage.rawValue:
            let image = UIImage(named: "paper")?.withRenderingMode(.alwaysTemplate)
            carTitle.image = image
            carTitle.tintColor = UIColor(named: "titlered")
        case TitleInfo.flood.rawValue:
            let image = UIImage(named: "paper")?.withRenderingMode(.alwaysTemplate)
            carTitle.image = image
            carTitle.tintColor = UIColor(named: "titlered")
        case TitleInfo.rebuilt.rawValue:
            let image = UIImage(named: "paper")?.withRenderingMode(.alwaysTemplate)
            carTitle.image = image
            carTitle.tintColor = UIColor(named: "titlered")
        case TitleInfo.unknown.rawValue:
            let image = UIImage(named: "paper")?.withRenderingMode(.alwaysTemplate)
            carTitle.image = image
            carTitle.tintColor = .lightGray
        default:
            carTitle.isHidden = true
        }
    }
    
    func addTransmissionPicture(cellData:String){
        let transmission: String = cellData
        switch transmission{
        case TransmissionType.auto.rawValue:
            carTranmission.isHidden = true
        case TransmissionType.manual.rawValue:
            carTranmission.isHidden = false
        default:
            carTranmission.isHidden = false
        }

    }
    
    func addAccidentPicture(cellData:String){
        
        let accidentInfo: String = cellData
        switch accidentInfo{
        case CarfaxAccidentInfo.accident.rawValue:
            let image = UIImage(named: "accident")?.withRenderingMode(.alwaysTemplate)
            carAccident.image = image
            carAccident.tintColor = UIColor(named: "accidentRed")
        case CarfaxAccidentInfo.noAccident.rawValue:
            carAccident.isHidden = true
        case CarfaxAccidentInfo.unknown.rawValue:
            let image = UIImage(named: "accident")?.withRenderingMode(.alwaysTemplate)
            carAccident.image = image
            carAccident.tintColor = .lightGray
        case CarfaxAccidentInfo.noCarfax.rawValue:
            let image = UIImage(named: "accident")?.withRenderingMode(.alwaysTemplate)
            carAccident.image = image
            carAccident.tintColor = .lightGray
        default:
            let image = UIImage(named: "accident")?.withRenderingMode(.alwaysTemplate)
            carAccident.image = image
            carAccident.tintColor = .lightGray
        }
        
    }
    
    
    func driveTypeAndEnginePicture(cellData:String,cellData2:String){
        let driveType: String = cellData
        let engineLayour: String = cellData2
        
        switch driveType{
        case DriveTypeENUM.RWD.rawValue:
            switch engineLayour{
            case EngineLayout.rear.rawValue:
                carEngine.image = UIImage(named: "RWDR")
            case EngineLayout.mid.rawValue:
                carEngine.image = UIImage(named: "RWDM")
            case EngineLayout.front.rawValue:
                carEngine.image = UIImage(named: "RWDF")
            default:
                carEngine.isHidden = true
            }
        case DriveTypeENUM.AWD.rawValue:
            switch engineLayour{
            case EngineLayout.rear.rawValue:
                carEngine.image = UIImage(named: "AWDR")
            case EngineLayout.mid.rawValue:
                carEngine.image = UIImage(named: "AWDM")
            case EngineLayout.front.rawValue:
                carEngine.image = UIImage(named: "AWD")
            default:
                carEngine.isHidden = true
            }
        case DriveTypeENUM.FWD.rawValue:
            switch engineLayour{
            case EngineLayout.rear.rawValue:
                carEngine.image = UIImage(named: "FWD")
            case EngineLayout.mid.rawValue:
                carEngine.image = UIImage(named: "FWD")
            case EngineLayout.front.rawValue:
                carEngine.image = UIImage(named: "FWD")
            default:
                carEngine.isHidden = true
            }
        case DriveTypeENUM.Ani.rawValue:
            switch engineLayour{
            case EngineLayout.rear.rawValue:
                carEngine.isHidden = true
            case EngineLayout.mid.rawValue:
                carEngine.isHidden = true
            case EngineLayout.front.rawValue:
                carEngine.isHidden = true
            default:
                carEngine.isHidden = true
            }
        default:
            carEngine.isHidden = true
            
        }
    }
    
    @IBAction func onClickContactSellerButton(_ sender: Any) {
        contactSellerAction?()
    }
}
