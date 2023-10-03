//
//  CarDisplayDetailCell.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 30/09/2022.
//

import UIKit
import SDWebImage
import SkeletonView

class CarDisplayDetailCell: UICollectionViewCell {

    @IBOutlet weak var addToGarageButton: UIButton!
    
    @IBOutlet weak var viewButton: UIButton!
    @IBOutlet weak var addToSavedButton: UIButton!
    
    var addToGaragebtnTapAction : (()->())?
    var addToSavedbtnTapAction : (()->())?
    var viewbtnTapAction : ((Int)->())?
    var viewbtnTapActionLive : ((String)->())?

    @IBOutlet weak var outerView: UIView!
    
    
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var carPrice: UILabel!
    @IBOutlet weak var carMilage: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    let numberFormatter = NumberFormatter()
    let strNumber = NumberFormatter()
    var carId:Int? = 0
    var carUUId:String? = ""

    
    @IBOutlet weak var carTitle: UIImageView!
    @IBOutlet weak var carTransmission: UIImageView!
    @IBOutlet weak var carAccident: UIImageView!
    @IBOutlet weak var carEngineType: UIImageView!
    
    
    
    @IBOutlet weak var favImg: UIImageView!
    
    @IBOutlet weak var garageImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        numberFormatter.numberStyle = .currency
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.currencySymbol = "$"
        strNumber.numberStyle = .decimal
        carId = 0
        favImg.image = UIImage(named: "favourite")

    }
    
    func makeCellAnimate(){
        let views = [imageView,carName, carPrice,carMilage,carTitle,carTransmission,carAccident,carEngineType,viewButton]
        views.forEach {$0?.showAnimatedGradientSkeleton()}
    }
    
    func stopAinmation(){
        let views = [imageView,carName, carPrice,carMilage,carTitle,carTransmission,carAccident,carEngineType,viewButton]
        views.forEach {$0?.stopSkeletonAnimation()}
    }
    
    func configureCell(cellData:AverageGraphCarListModelCurrentTenureCarsList,isLoadingShimmer:Bool){
        carName.text = cellData.listing_title
        if AppUtility.ToggleState!{
            carPrice.text = numberFormatter.string(from: NSNumber(value: Int(cellData.max_bid ?? " 0") ?? 0))
        }else{
            carPrice.text = numberFormatter.string(from: NSNumber(value: cellData.price ?? 0))
        }
        let formattedString = strNumber.string(from: NSNumber(value: Int(cellData.mileage ?? "0") ?? 0))
        carMilage.text = formattedString! + " Miles"
        if(cellData != nil && cellData.images != nil && cellData.images!.count > 0){
            imageView.sd_setImage(with: URL(string: cellData.images?[0].image_url ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
        }
        carId = cellData.id ?? 0
        carUUId = ""
        addTitlePicture(cellData: cellData.title_info ?? "")
        addTransmissionPicture(cellData: cellData.transmission_type ?? "")
        addAccidentPicture(cellData: cellData.carfax_info ?? "")
        driveTypeAndEnginePicture(cellData: cellData.drive_type ?? "",cellData2: cellData.engine_layout ?? "")
    }
    
    func configureCellLive(cellData:WantToSaleListingModelListing){
        carName.text = "\(cellData.carMake ?? "N/A") | \(cellData.carModel ?? "N/A") | \(cellData.carGeneration ?? "N/A") | \(cellData.carSubGeneration ?? "N/A") | \(cellData.trimDefinition ?? "N/A") "
        if AppUtility.ToggleState!{
            carPrice.text = numberFormatter.string(from: NSNumber(value: Int(cellData.listing_price ?? 0)))
        }else{
            carPrice.text = numberFormatter.string(from: NSNumber(value: cellData.listing_price ?? 0))
        }
        let formattedString = strNumber.string(from: NSNumber(value: Int(cellData.car_mileage ?? 0)))
        carMilage.text = formattedString! + " Miles"
        
        if(cellData != nil && cellData.image != nil && cellData.image!.count > 0){
            imageView.sd_setImage(with: URL(string: cellData.image?[0] ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
        }
        
        carUUId = cellData.uuid ?? ""
        carId = 0
        addTitlePicture(cellData: cellData.TitleInfo ?? "")
        addTransmissionPicture(cellData: cellData.transmission_type ?? "")
        addAccidentPicture(cellData: cellData.carfax_info ?? "")
        driveTypeAndEnginePicture(cellData: cellData.drive_type ?? "",cellData2: cellData.engine_layout ?? "")
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
            carTransmission.isHidden = true
        case TransmissionType.manual.rawValue:
            carTransmission.isHidden = false
        default:
            carTitle.isHidden = false
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
                carEngineType.image = UIImage(named: "RWDR")
            case EngineLayout.mid.rawValue:
                carEngineType.image = UIImage(named: "RWDM")
            case EngineLayout.front.rawValue:
                carEngineType.image = UIImage(named: "RWDF")
            default:
                carEngineType.isHidden = true
            }
        case DriveTypeENUM.AWD.rawValue:
            switch engineLayour{
            case EngineLayout.rear.rawValue:
                carEngineType.image = UIImage(named: "AWDR")
            case EngineLayout.mid.rawValue:
                carEngineType.image = UIImage(named: "AWDM")
            case EngineLayout.front.rawValue:
                carEngineType.image = UIImage(named: "AWD")
            default:
                carEngineType.isHidden = true
            }
        case DriveTypeENUM.FWD.rawValue:
            switch engineLayour{
            case EngineLayout.rear.rawValue:
                carEngineType.image = UIImage(named: "FWD")
            case EngineLayout.mid.rawValue:
                carEngineType.image = UIImage(named: "FWD")
            case EngineLayout.front.rawValue:
                carEngineType.image = UIImage(named: "FWD")
            default:
                carEngineType.isHidden = true
            }
        case DriveTypeENUM.Ani.rawValue:
            switch engineLayour{
            case EngineLayout.rear.rawValue:
                carEngineType.isHidden = true
            case EngineLayout.mid.rawValue:
                carEngineType.isHidden = true
            case EngineLayout.front.rawValue:
                carEngineType.isHidden = true
            default:
                carEngineType.isHidden = true
            }
        default:
            carEngineType.isHidden = true
            
        }
    }
    
    func configureCell2(cellData: MultiHistoricCarListingPaginatedArr){
       
        carName.text = cellData.listing_title
        if AppUtility.showCurrentHistoric{
            carPrice.text = numberFormatter.string(from: NSNumber(value: Int(cellData.max_bid ?? "0") ?? 0))
        }else{
            carPrice.text = numberFormatter.string(from: NSNumber(value: cellData.price ?? 0))
        }
        let formattedString = strNumber.string(from: NSNumber(value: Int(cellData.mileage ?? "0") ?? 0))
        carMilage.text = formattedString! + " Miles"
        imageView.sd_setImage(with: URL(string: cellData.images?[0].image_url ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
        
        carId = cellData.id
        
        addTitlePicture(cellData: cellData.title_info ?? "")
        addTransmissionPicture(cellData: cellData.transmission_type ?? "")
        addAccidentPicture(cellData: cellData.carfax_info ?? "")
        driveTypeAndEnginePicture(cellData: cellData.drive_type ?? "",cellData2: cellData.engine_layout ?? "")
        
    }
    
    func configureCarDetailSimilarListing(cellData:CarDetailsSimilarListingsSimilarListing,is_Live:Bool){
        if is_Live{
            carPrice.text = numberFormatter.string(from: NSNumber(value: Int(cellData.max_bid ?? "0") ?? 0))

        }else{
            carPrice.text = numberFormatter.string(from: NSNumber(value: cellData.price ?? 0))

        }
        carName.text = cellData.listing_title
        let formattedString = strNumber.string(from: NSNumber(value: Int(cellData.mileage ?? "0") ?? 0))
        carMilage.text = formattedString! + " Miles"
        imageView.sd_setImage(with: URL(string: cellData.images?[0].image_url ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
        carId = cellData.id ?? 0
        
        addTitlePicture(cellData: cellData.title_info ?? "")
        addTransmissionPicture(cellData: cellData.transmission_type ?? "")
        addAccidentPicture(cellData: cellData.carfax_info ?? "")
        driveTypeAndEnginePicture(cellData: cellData.drive_type ?? "",cellData2: cellData.engine_layout ?? "")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.configureShadow(cornerRadius: 10)
        viewButton.layer.shadowColor = UIColor.black.cgColor
        viewButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        viewButton.layer.shadowRadius = 2
        viewButton.layer.shadowOpacity = 0.2
        viewButton.layer.masksToBounds = false
        viewButton.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 12)!
    }
    
    @IBAction func onClickGarageButton(_ sender: Any) {
        addToGaragebtnTapAction?()

    }
   
    @IBAction func onClickSaveButton(_ sender: Any) {
        

        if favImg.image == UIImage(named: "favourite"){
            favImg.image = UIImage(named: "heart2")
        }else{
            favImg.image = UIImage(named: "favourite")
        }
        
        addToSavedbtnTapAction?()
    }
 
    @IBAction func onClickViewButton(_ sender: Any) {
        if carId != 0 {
            viewbtnTapAction?(carId ?? 0)

        }else{
            viewbtnTapActionLive?(carUUId ?? "")

        }
    }
}
