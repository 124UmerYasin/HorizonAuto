//
//  screen3.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 16/05/2023.
//

import UIKit

class screen3: UITableViewCell {

    @IBOutlet weak var v4: UIView!
    @IBOutlet weak var v1: UIView!
    
    @IBOutlet weak var v2: UIView!
    
    @IBOutlet weak var v3: UIView!
    
    
    
    @IBOutlet weak var carYear: UILabel!
    @IBOutlet weak var vin: UILabel!
    @IBOutlet weak var mileage: UILabel!
    @IBOutlet weak var intcol: UILabel!
    @IBOutlet weak var extCol: UILabel!
    @IBOutlet weak var engineImg: UIImageView!
    @IBOutlet weak var transmission: UILabel!
    @IBOutlet weak var engineType: UILabel!
    
    let numberFormatter = NumberFormatter()

    
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
    
    func configureCellData(cellData:HomecardetailModelCarDetails){
        carYear.text = "\(cellData.car_year ?? 0)"
        vin.text = cellData.vin
        
        numberFormatter.numberStyle = .decimal
        numberFormatter.currencySymbol = .none
        numberFormatter.minimumFractionDigits = 0
        if cellData.car_mileage != nil {
            let mag = numberFormatter.string(from: NSNumber(value:Int(exactly: cellData.car_mileage ?? 0)!))
            mileage.text = "\(mag ?? "N/A") Miles"
        }else{
            let mag = numberFormatter.string(from: NSNumber(value:Int(exactly: cellData.car_max_mileage ?? 0)!))
            let mag2 = numberFormatter.string(from: NSNumber(value:Int(exactly: cellData.car_min_mileage ?? 0)!))
            mileage.text = "\(mag2 ?? "N/A") - \(mag ?? "N/A") Miles"
        }
        
        intcol.text = cellData.interior_color
        extCol.text = cellData.exterior_color
        
        transmission.text = cellData.transmission_type
        
        driveTypeAndEnginePicture(cellData: cellData.trim_definition?.drive_type ?? "", cellData2: cellData.car_sub_generation?.engine_layout ?? "")

        
        
    }
    
    func driveTypeAndEnginePicture(cellData:String,cellData2:String){
        let driveType: String = cellData
        let engineLayour: String = cellData2
        engineType.text = "Front Engined, FWD"
        switch driveType{
        case DriveTypeENUM.RWD.rawValue:
            switch engineLayour{
            case EngineLayout.rear.rawValue:
                engineImg.image = UIImage(named: "RWDR")
                engineType.text = "Rear Engined, RWD"
            case EngineLayout.mid.rawValue:
                engineImg.image = UIImage(named: "RWDM")
                engineType.text = "Mid Engined, RWD"
            case EngineLayout.front.rawValue:
                engineImg.image = UIImage(named: "RWDF")
                engineType.text = "Front Engined, RWD"
            default:
                engineImg.isHidden = true
            }
        case DriveTypeENUM.AWD.rawValue:
            switch engineLayour{
            case EngineLayout.rear.rawValue:
                engineImg.image = UIImage(named: "AWDR")
                engineType.text = "Rear Engined, AWDR"
            case EngineLayout.mid.rawValue:
                engineImg.image = UIImage(named: "AWDM")
                engineType.text = "Mid Engined, AWDR"
            case EngineLayout.front.rawValue:
                engineImg.image = UIImage(named: "AWD")
                engineType.text = "Front Engined, AWDR"
            default:
                engineImg.isHidden = true
            }
        case DriveTypeENUM.FWD.rawValue:
            switch engineLayour{
            case EngineLayout.rear.rawValue:
                engineImg.image = UIImage(named: "FWD")
                engineType.text = "Rear Engined, FWD"
            case EngineLayout.mid.rawValue:
                engineImg.image = UIImage(named: "FWD")
                engineType.text = "Mid Engined, FWD"
            case EngineLayout.front.rawValue:
                engineImg.image = UIImage(named: "FWD")
                engineType.text = "Front Engined, FWD"
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
