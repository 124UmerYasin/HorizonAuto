//
//  screen1.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 15/05/2023.
//

import UIKit

class screen1: UICollectionViewCell {

    @IBOutlet weak var v4: UIView!
    @IBOutlet weak var v3: UIView!
    @IBOutlet weak var v2: UIView!
    @IBOutlet weak var v1: UIView!
    
    @IBOutlet weak var exteriorColor: UILabel!
    @IBOutlet weak var interiorCar: UILabel!
    @IBOutlet weak var specialOption: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var mileage: UILabel!
    
    let numberFormatter = NumberFormatter()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.configureShadow2(vi: v1)
        self.configureShadow2(vi: v2)
        self.configureShadow2(vi: v3)
        self.configureShadow2(vi: v4)
    }
    
    
    func configureCellData(cellData:HomecardetailModelCarDetails){
        exteriorColor.text = cellData.exterior_color
        interiorCar.text = cellData.interior_color
        
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
        
        var spOpt = ""
        for item in cellData.specialOptions ?? [String](){
            spOpt += "\(item), "
        }
        spOpt = String(spOpt.dropLast())
        specialOption.text = spOpt
        email.text = cellData.posterEmail
    }
    
}
