//
//  SaleListingCell.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 02/03/2023.
//

import UIKit
import SDWebImage

class SaleListingCell: UICollectionViewCell {

    @IBOutlet weak var miles: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var viewButton: UIButton!
    
    @IBOutlet weak var carName: UILabel!
    
    @IBOutlet weak var engineImg: UIImageView!
    
    @IBOutlet weak var accidentImg: UIImageView!
    @IBOutlet weak var tranmissionImg: UIImageView!
    @IBOutlet weak var paperImg: UIImageView!
    
    @IBOutlet weak var price: UILabel!
    
    var btnClicke : ((String)->())?
    let numberFormatter = NumberFormatter()

    var uuid:String?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(cellData:GetuserSaleListingoMdelListingID){
//        image.sd_setImage(with: URL(string: "https://bringatrailer.com/wp-content/uploads/2022/11/1961_chevrolet_corvette_img_6008-3-82964.jpg"), placeholderImage: UIImage(named: "placeholder.png"))
        uuid = cellData.uuid

        image.sd_setImage(with: URL(string: "\(cellData.images?[0] ?? "")"), placeholderImage: UIImage(named: "placeholder.png"))
        
        if let customFont = UIFont(name: "Inter-Medium", size: 12) {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5

            let attributedString = NSMutableAttributedString(string: "\(cellData.car_make?.make ?? "NA") | \(cellData.car_model?.model ?? "NA") | \(cellData.car_generation?.generation ?? "NA") | \(cellData.car_sub_generation?.sub_generation ?? "NA") | \(cellData.trim_definition?.car_trim ?? "NA")")
            attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
            attributedString.addAttribute(.font, value: customFont, range: NSMakeRange(0, attributedString.length))
            carName.attributedText = attributedString
        }
        
        
        numberFormatter.numberStyle = .decimal
        numberFormatter.currencySymbol = .none
        numberFormatter.minimumFractionDigits = 0
        if cellData.car_mileage != nil {
            let mag = numberFormatter.string(from: NSNumber(value:Int(exactly: cellData.car_mileage ?? 0)!))
            miles.text = "\(mag ?? "N/A") Miles"
        }else{
            let mag = numberFormatter.string(from: NSNumber(value:Int(exactly: cellData.car_max_mileage ?? 0)!))
            let mag2 = numberFormatter.string(from: NSNumber(value:Int(exactly: cellData.car_min_mileage ?? 0)!))
            miles.text = "\(mag2 ?? "N/A") - \(mag ?? "N/A") Miles"
        }
        
        let magqa = numberFormatter.string(from: NSNumber(value:Int(exactly: cellData.listing_price!)!))
        price.text = "$ \(magqa ?? "0")"
        
        addTitlePicture(cellData: cellData.title_info ?? "")
        addTransmissionPicture(cellData: cellData.transmission_type ?? "")
        addAccidentPicture(cellData: cellData.carfax_accident_info ?? "")
        driveTypeAndEnginePicture(cellData: cellData.trim_definition?.drive_type ?? "", cellData2: cellData.car_sub_generation?.engine_layout ?? "")
        

    }
    func configureCell2(cellData:HomeCarDetailListingListingID){
//        image.sd_setImage(with: URL(string: "https://bringatrailer.com/wp-content/uploads/2022/11/1961_chevrolet_corvette_img_6008-3-82964.jpg"), placeholderImage: UIImage(named: "placeholder.png"))
        uuid = cellData.uuid

        image.sd_setImage(with: URL(string: "\(cellData.images?[0] ?? "")"), placeholderImage: UIImage(named: "placeholder.png"))
        carName.text = "\(cellData.car_make?.make ?? "NA") | \(cellData.car_model?.model ?? "NA") | \(cellData.car_generation?.generation ?? "NA") | \(cellData.car_sub_generation?.sub_generation ?? "NA") | \(cellData.trim_definition?.car_trim ?? "NA")"
        
        numberFormatter.numberStyle = .decimal
        numberFormatter.currencySymbol = .none
        numberFormatter.minimumFractionDigits = 0
        if cellData.car_mileage != nil {
            let mag = numberFormatter.string(from: NSNumber(value:Int(exactly: cellData.car_mileage ?? 0)!))
            miles.text = "\(mag ?? "N/A") Miles"
        }else{
            let mag = numberFormatter.string(from: NSNumber(value:Int(exactly: cellData.car_max_mileage ?? 0)!))
            let mag2 = numberFormatter.string(from: NSNumber(value:Int(exactly: cellData.car_min_mileage ?? 0)!))
            miles.text = "\(mag2 ?? "N/A") - \(mag ?? "N/A") Miles"
        }
        
        addTitlePicture(cellData: cellData.title_info ?? "")
        addTransmissionPicture(cellData: cellData.transmission_type ?? "")
        addAccidentPicture(cellData: cellData.carfax_accident_info ?? "")
        driveTypeAndEnginePicture(cellData: cellData.trim_definition?.drive_type ?? "", cellData2: cellData.car_sub_generation?.engine_layout ?? "")
        

    }
    
    @IBAction func onCLickBtn(_ sender: Any) {
        btnClicke?(uuid ?? "")
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
    
    func addTitlePicture(cellData:String){
        let title: String = cellData
        switch title {
        case TitleInfo.Clean.rawValue:
            let image = UIImage(named: "paper")?.withRenderingMode(.alwaysTemplate)
            paperImg.image = image
            paperImg.tintColor = UIColor(named: "titleGreen")
        case TitleInfo.Salvage.rawValue:
            let image = UIImage(named: "paper")?.withRenderingMode(.alwaysTemplate)
            paperImg.image = image
            paperImg.tintColor = UIColor(named: "titlered")
        case TitleInfo.flood.rawValue:
            let image = UIImage(named: "paper")?.withRenderingMode(.alwaysTemplate)
            paperImg.image = image
            paperImg.tintColor = UIColor(named: "titlered")
        case TitleInfo.rebuilt.rawValue:
            let image = UIImage(named: "paper")?.withRenderingMode(.alwaysTemplate)
            paperImg.image = image
            paperImg.tintColor = UIColor(named: "titlered")
        case TitleInfo.unknown.rawValue:
            let image = UIImage(named: "paper")?.withRenderingMode(.alwaysTemplate)
            paperImg.image = image
            paperImg.tintColor = .lightGray
        default:
            paperImg.isHidden = true
        }
    }
    
    func addTransmissionPicture(cellData:String){
        let transmission: String = cellData
        switch transmission{
        case TransmissionType.auto.rawValue:
            tranmissionImg.isHidden = true
        case TransmissionType.manual.rawValue:
            tranmissionImg.isHidden = false
        default:
            tranmissionImg.isHidden = false
        }

    }
    
    func addAccidentPicture(cellData:String){
        
        let accidentInfo: String = cellData
        switch accidentInfo{
        case CarfaxAccidentInfo.accident.rawValue:
            let image = UIImage(named: "accident")?.withRenderingMode(.alwaysTemplate)
            accidentImg.image = image
            accidentImg.tintColor = UIColor(named: "accidentRed")
        case CarfaxAccidentInfo.noAccident.rawValue:
            accidentImg.isHidden = true
        case CarfaxAccidentInfo.unknown.rawValue:
            let image = UIImage(named: "accident")?.withRenderingMode(.alwaysTemplate)
            accidentImg.image = image
            accidentImg.tintColor = .lightGray
        case CarfaxAccidentInfo.noCarfax.rawValue:
            let image = UIImage(named: "accident")?.withRenderingMode(.alwaysTemplate)
            accidentImg.image = image
            accidentImg.tintColor = .lightGray
        default:
            let image = UIImage(named: "accident")?.withRenderingMode(.alwaysTemplate)
            accidentImg.image = image
            accidentImg.tintColor = .lightGray
        }
        
    }
    
    
    func driveTypeAndEnginePicture(cellData:String,cellData2:String){
        let driveType: String = cellData
        let engineLayour: String = cellData2
        
        switch driveType{
        case DriveTypeENUM.RWD.rawValue:
            switch engineLayour{
            case EngineLayout.rear.rawValue:
                engineImg.image = UIImage(named: "RWDR")
            case EngineLayout.mid.rawValue:
                engineImg.image = UIImage(named: "RWDM")
            case EngineLayout.front.rawValue:
                engineImg.image = UIImage(named: "RWDF")
            default:
                engineImg.isHidden = true
            }
        case DriveTypeENUM.AWD.rawValue:
            switch engineLayour{
            case EngineLayout.rear.rawValue:
                engineImg.image = UIImage(named: "AWDR")
            case EngineLayout.mid.rawValue:
                engineImg.image = UIImage(named: "AWDM")
            case EngineLayout.front.rawValue:
                engineImg.image = UIImage(named: "AWD")
            default:
                engineImg.isHidden = true
            }
        case DriveTypeENUM.FWD.rawValue:
            switch engineLayour{
            case EngineLayout.rear.rawValue:
                engineImg.image = UIImage(named: "FWD")
            case EngineLayout.mid.rawValue:
                engineImg.image = UIImage(named: "FWD")
            case EngineLayout.front.rawValue:
                engineImg.image = UIImage(named: "FWD")
            default:
                engineImg.isHidden = true
            }
        case DriveTypeENUM.Ani.rawValue:
            switch engineLayour{
            case EngineLayout.rear.rawValue:
                engineImg.isHidden = true
            case EngineLayout.mid.rawValue:
                engineImg.isHidden = true
            case EngineLayout.front.rawValue:
                engineImg.isHidden = true
            default:
                engineImg.isHidden = true
            }
        default:
            engineImg.isHidden = true
            
        }
    }
}
