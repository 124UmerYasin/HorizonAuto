//
//  CarDetailCellTwo.swift
//  CarBois
//
//  Created by Umer Yasin on 05/09/2022.
//

import UIKit

class CarDetailCellTwo: UITableViewCell {

    @IBOutlet weak var v1: UIView!
    @IBOutlet weak var v2: UIView!
    @IBOutlet weak var v3: UIView!
    @IBOutlet weak var v4: UIView!
    
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var transmission: UILabel!
    @IBOutlet weak var carDetail: UILabel!
    @IBOutlet weak var vin: UILabel!
    @IBOutlet weak var owners: UILabel!
    @IBOutlet weak var accident: UILabel!
    
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var driveType: UIImageView!
    
    @IBOutlet weak var accidentWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var accidentImage: UIImageView!
    @IBOutlet weak var distConst: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.configureShadow2(vi: v1)
        self.configureShadow2(vi: v2)
        self.configureShadow2(vi: v3)
        self.configureShadow2(vi: v4)

    }

    func configureShadow2(vi:UIView){
        vi.layer.cornerRadius = 7
        vi.layer.shadowRadius = 1
        vi.layer.shadowOpacity = 0.3
        vi.layer.shadowOffset = CGSize(width: 0, height: 0)
        vi.layer.shadowColor = UIColor.black.cgColor
        vi.layer.masksToBounds = false
    }
    
    func addValuesToViews(carDetail:CarDetailModelCarDetails){
        title.text = carDetail.title_info?.capitalized
        vin.text = carDetail.vin
        transmission.text = carDetail.transmission_type?.capitalized
        self.carDetail.text = carDetail.drive_type?.capitalized
        addTitlePicture(cellData: carDetail.title_info?.capitalized ?? "")
        driveTypeAndEnginePicture(cellData: carDetail.drive_type?.capitalized ?? "", cellData2: carDetail.engine_layout?.capitalized ?? "")
        accident.text = carDetail.carfax_info
        addAccidentPicture(cellData: carDetail.carfax_info ?? "")
       
    }
    
    func addAccidentPicture(cellData:String){
        
        let accidentInfo: String = cellData
        switch accidentInfo{
        case CarfaxAccidentInfo.accident.rawValue:
            let image = UIImage(named: "accident")?.withRenderingMode(.alwaysTemplate)
            accidentImage.image = image
            accidentImage.tintColor = UIColor(named: "accidentRed")
            accidentWidthConstraint.constant = 40
            distConst.constant = 4
        case CarfaxAccidentInfo.noAccident.rawValue:
            accidentImage.isHidden = true
            accidentWidthConstraint.constant = 0
            distConst.constant = 0
        case CarfaxAccidentInfo.unknown.rawValue:
            let image = UIImage(named: "accident")?.withRenderingMode(.alwaysTemplate)
            accidentImage.image = image
            accidentImage.tintColor = .lightGray
            accidentWidthConstraint.constant = 40
            distConst.constant = 4
        case CarfaxAccidentInfo.noCarfax.rawValue:
            let image = UIImage(named: "accident")?.withRenderingMode(.alwaysTemplate)
            accidentImage.image = image
            accidentImage.tintColor = .lightGray
            accidentWidthConstraint.constant = 40
            distConst.constant = 4
        default:
            let image = UIImage(named: "accident")?.withRenderingMode(.alwaysTemplate)
            accidentImage.image = image
            accidentImage.tintColor = .lightGray
            accidentWidthConstraint.constant = 40
            distConst.constant = 4
        }
        
    }
    
    
    func addTitlePicture(cellData:String){
        let title: String = cellData
        switch title {
        case TitleInfo.Clean.rawValue:
            let image = UIImage(named: "paper")?.withRenderingMode(.alwaysTemplate)
            titleImage.image = image
            titleImage.tintColor = UIColor(named: "titleGreen")
        case TitleInfo.Salvage.rawValue:
            let image = UIImage(named: "paper")?.withRenderingMode(.alwaysTemplate)
            titleImage.image = image
            titleImage.tintColor = UIColor(named: "titlered")
        case TitleInfo.flood.rawValue:
            let image = UIImage(named: "paper")?.withRenderingMode(.alwaysTemplate)
            titleImage.image = image
            titleImage.tintColor = UIColor(named: "titlered")
        case TitleInfo.rebuilt.rawValue:
            let image = UIImage(named: "paper")?.withRenderingMode(.alwaysTemplate)
            titleImage.image = image
            titleImage.tintColor = UIColor(named: "titlered")
        case TitleInfo.unknown.rawValue:
            let image = UIImage(named: "paper")?.withRenderingMode(.alwaysTemplate)
            titleImage.image = image
            titleImage.tintColor = .lightGray
        default:
            titleImage.isHidden = false
            titleImage.tintColor = .lightGray

        }
    }
    
    func driveTypeAndEnginePicture(cellData:String,cellData2:String){
        let driveType23: String = cellData
        let engineLayour: String = cellData2
        
        switch driveType23{
        case DriveTypeENUM.RWD.rawValue:
            switch engineLayour{
            case EngineLayout.rear.rawValue:
                driveType.image = UIImage(named: "RWDR")
            case EngineLayout.mid.rawValue:
                driveType.image = UIImage(named: "RWDM")
            case EngineLayout.front.rawValue:
                driveType.image = UIImage(named: "RWDF")
            default:
                driveType.isHidden = true
            }
        case DriveTypeENUM.AWD.rawValue:
            switch engineLayour{
            case EngineLayout.rear.rawValue:
                driveType.image = UIImage(named: "AWDR")
            case EngineLayout.mid.rawValue:
                driveType.image = UIImage(named: "AWDM")
            case EngineLayout.front.rawValue:
                driveType.image = UIImage(named: "AWD")
            default:
                driveType.isHidden = true
            }
        case DriveTypeENUM.FWD.rawValue:
            switch engineLayour{
            case EngineLayout.rear.rawValue:
                driveType.image = UIImage(named: "FWD")
            case EngineLayout.mid.rawValue:
                driveType.image = UIImage(named: "FWD")
            case EngineLayout.front.rawValue:
                driveType.image = UIImage(named: "FWD")
            default:
                driveType.isHidden = true
            }
        case DriveTypeENUM.Ani.rawValue:
            switch engineLayour{
            case EngineLayout.rear.rawValue:
                driveType.isHidden = true
            case EngineLayout.mid.rawValue:
                driveType.isHidden = true
            case EngineLayout.front.rawValue:
                driveType.isHidden = true
            default:
                driveType.isHidden = true
            }
        default:
            driveType.isHidden = true
            
        }
    }
}
