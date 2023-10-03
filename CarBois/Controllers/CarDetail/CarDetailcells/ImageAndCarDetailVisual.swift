//
//  ImageAndCarDetailVisual.swift
//  CarBois
//
//  Created by Umer Yasin on 02/09/2022.
//

import UIKit
import ImageSlideshow
 

class ImageAndCarDetailVisual: UICollectionViewCell,ImageSlideshowDelegate , ViewPagerDataSource{
   
    
    @IBOutlet weak var imageSlider: ImageSlideshow!
    var sdWebImageSource = [SDWebImageSource]()
    let pageIndicator = UIPageControl()
    
    
    @IBOutlet weak var viewPager: ViewPager!
    
    @IBOutlet weak var imageButton: UIButton!
    
    @IBOutlet weak var viewAllButton: UIButton!
    
    
    
    @IBOutlet weak var imageviewcar: UIView!
    @IBOutlet weak var stackView: UIView!
    
    var viewbtnTapAction : (()->())?
    
    @IBOutlet weak var pagerView: UIView!
    let pageControl2 = WOPageControl(frame: CGRect(x: 0, y: 0, width: 50, height: 50))

    @IBOutlet weak var pageIndeicator: UIView!
    let pageControl3 = WOPageControl(frame: CGRect(x: 0, y: 0, width: 50, height: 50))

    
    var carDetail:CarDetailModelCarDetails?
    var carDetailGraph:CarDetailGraphModel?
    var is_Live_CarDetail:Bool?
    
    @IBOutlet weak var carTitle: UIImageView!
    @IBOutlet weak var carAccident: UIImageView!
    @IBOutlet weak var carTranmission: UIImageView!
    @IBOutlet weak var carEngine: UIImageView!
    
    var vc:UIViewController?
    var sendSwitchState : ((Bool)->())?

    
    @IBOutlet weak var liveSwitch: UISwitch!
    @IBOutlet weak var switchLabel: UILabel!
    
    var CarTapAction : ((Int)->())?

    
    var isfromBuySellDetail : Bool = false
    
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
        pageControl2.numberOfPages = 3;

        pageControl2.center = CGPoint(x: pagerView.frame.width / 2, y: pagerView.frame.height / 2)
        pagerView.addSubview(pageControl2)
        
        viewPager.dataSource = self
        viewPager.scrollToPage(index: 0)
        viewPager.pageControl.isHidden = false
        liveSwitch.transform = CGAffineTransformMakeScale(0.75, 0.75)
    }
    
    override func prepareForReuse() {
        viewPager.scrollToPage(index: 1)
    }
    
    @IBAction func onCLickSwitchButton(_ sender: Any) {
        if liveSwitch.isSelected{
//            AppUtility.FilterApplied = nil
            AppUtility.FilterAppliedCarDetail = nil
            viewPager.scrollToPage(index: 1)
            viewPager.reloadData()
            liveSwitch.isSelected = false
            sendSwitchState!(false)
            switchLabel.text = "Historic Listings"
        }else{
//            AppUtility.FilterApplied = nil
            AppUtility.FilterAppliedCarDetail = nil

            viewPager.scrollToPage(index: 1)
            viewPager.reloadData()
            liveSwitch.isSelected = true
            sendSwitchState!(true)
            switchLabel.text = "Live Listings"
        }
    }
    
    func makeButtonNormal(){
        if !is_Live_CarDetail!{
            liveSwitch.setOn(false, animated: true)
            liveSwitch.isSelected = false
            switchLabel.text = "Historic Listings"
        }else{
            liveSwitch.setOn(true, animated: true)
            liveSwitch.isSelected = true
            switchLabel.text = "Live Listings"
        }

    }
    
    
    func addImagesAndCarosoul(images:[CarDetailModelCarGeneration],isfromBuySell:Bool){
        self.isfromBuySellDetail = isfromBuySell
        for item in images{
            let m = item.image_url ?? ""
            let parsed = m.replacingOccurrences(of: "resize=235%2C159", with: "")

            sdWebImageSource.append(SDWebImageSource(urlString: parsed)!)
        }
        imageSlider.pageIndicator = nil
        imageSlider.contentScaleMode = UIViewContentMode.scaleAspectFill
        imageSlider.activityIndicator = DefaultActivityIndicator()
        imageSlider.delegate = self
        if isfromBuySellDetail {
            sdWebImageSource.append(SDWebImageSource(urlString: "https://bringatrailer.com/wp-content/uploads/2022/11/1961_chevrolet_corvette_img_6008-3-82964.jpg")!)
            liveSwitch.transform = CGAffineTransformMakeScale(0,0)
            switchLabel.isHidden = true
            viewAllButton.isHidden = true

        }
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
        
        if images.count == 1 {
            viewAllButton.isHidden = true
            pageIndeicator.isHidden = true
        }
       
    }
    
    func addSubViewForCarDetail(carDetail:CarDetailModelCarDetails){
        self.carDetail = carDetail
        addTitlePicture(cellData: carDetail.title_info ?? "")
        addTransmissionPicture(cellData: carDetail.transmission_type ?? "")
        addAccidentPicture(cellData: carDetail.carfax_info ?? "")
        driveTypeAndEnginePicture(cellData: carDetail.drive_type ?? "",cellData2: carDetail.engine_layout ?? "")
    }
    
    func addGraphData(graphData:CarDetailGraphModel,is_Live:Bool){
        self.carDetailGraph = graphData
        self.is_Live_CarDetail = is_Live
        makeButtonNormal()
        viewPager.reloadData()
       
    }
    
    override func layoutSubviews() {
        
        configureShadow2(vi: imageviewcar)
        configureShadow2(vi: stackView)

    }
    
    
    
    @objc func didTap() {
        let fullScreenController = imageSlider.presentFullScreenController( from: vc ?? UIViewController())
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .large, color: nil)
    }
    
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        print("current page:", page)
        pageControl3.currentPage = Int32(page)
    }
    
    @objc func numberOfItems(viewPager:ViewPager) -> Int {
        return 3;
    }
    
    @objc func viewAtIndex(viewPager:ViewPager, index:Int, view:UIView?) -> UIView {
        
        if index == 0 {
            let newView = UIView()
            let child = UINib(nibName: "CarDetailCellone", bundle: .main).instantiate(withOwner: nil, options: nil).first as! CarDetailCellone
            if !isfromBuySellDetail {
                child.addValuesToViews(carDetail: carDetail!,is_Live: is_Live_CarDetail!)
            }
            child.frame = newView.bounds
            child.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            newView.addSubview(child)
            return newView
        }else if index == 1{
            let newView = UIView()
            let child = UINib(nibName: "CarDetailCellTwo", bundle: .main).instantiate(withOwner: nil, options: nil).first as! CarDetailCellTwo
            if !isfromBuySellDetail {
                child.addValuesToViews(carDetail: carDetail!)
            }
            child.frame = newView.bounds
            child.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            newView.addSubview(child)
            return newView
        }else if index == 2{
            let newView = UIView()
            let child = UINib(nibName: "CarDetailGraph", bundle: .main).instantiate(withOwner: nil, options: nil).first as! CarDetailGraph
            let name = (carDetail?.car_sub_generation?.sub_generation ?? "N/A") + " " + (carDetail?.trim_definition?.car_trim ?? "N/A")
            if !isfromBuySellDetail {
                child.getCarDetailGraphData(carDetailGraphData: carDetailGraph!,id: carDetail?.id ?? 0, carModelName: name ,is_Live: is_Live_CarDetail!)
            }
            child.CarTapAction = { [self] (carId) in
                CarTapAction?(carId as? Int ?? -1)
            }
            child.frame = newView.bounds
            child.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            newView.addSubview(child)
            return newView
        }else{
            let newView = UIView()
            let child = UINib(nibName: "bidGraph", bundle: .main).instantiate(withOwner: nil, options: nil).first as! bidGraph
            if !isfromBuySellDetail {
                child.getCarDetailGraphData(carDetailGraphData: carDetailGraph!,id: carDetail?.id ?? 0, carModelName: carDetail?.listing_title ?? "N/A",is_Live: is_Live_CarDetail!)
            }
            child.frame = newView.bounds
            child.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            newView.addSubview(child)
            return newView
        }
        
    }
    
    
    func didSelectedItem(index: Int) {
        print("select index \(index)")
    }
    
    func currentIndex(index: Int) {
//        pageControl2.currentPage = Int32(viewPager.pageControl.page)
//        if index == 0 {
//            DispatchQueue.main.async { [self] in
//                pageControl2.currentPage = 0
//            }
//        }else if index == 1 {
//            DispatchQueue.main.async { [self] in
//                pageControl2.currentPage = 1
//            }
//        }else if index == 2 {
//            DispatchQueue.main.async { [self] in
//                pageControl2.currentPage = 2
//            }
//        }else if index == 3 {
//            DispatchQueue.main.async { [self] in
//                pageControl2.currentPage = 3
//            }
//        }
    }
    
    @IBAction func onCLickImagesStack(_ sender: Any) {
        viewPager.scrollToPage(index: 2)
    }
    
    @IBAction func onClickViewAll(_ sender: Any) {
        viewbtnTapAction?()
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
    
    
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}


extension UIColor {
    static func randomColor() -> UIColor {
        // If you wanted a random alpha, just create another
        // random number for that too.
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}



