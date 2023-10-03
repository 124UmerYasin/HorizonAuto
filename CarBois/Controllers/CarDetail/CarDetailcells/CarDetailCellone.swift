//
//  CarDetailCellone.swift
//  CarBois
//
//  Created by Umer Yasin on 02/09/2022.
//

import UIKit
import Foundation

class CarDetailCellone: UICollectionViewCell {

    @IBOutlet weak var v1: UIView!
    @IBOutlet weak var v2: UIView!
    @IBOutlet weak var v3: UIView!
    @IBOutlet weak var v4: UIView!
    
    @IBOutlet weak var listingType: UILabel!
    
    @IBOutlet weak var vin: UILabel!

    @IBOutlet weak var aurRes: UILabel!
    @IBOutlet weak var sellingDealerLocation: UILabel!
    @IBOutlet weak var selleingDealerName: UILabel!
    @IBOutlet weak var milage: UILabel!
    @IBOutlet weak var keyOptions: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.configureShadow2(vi: v1)
        self.configureShadow2(vi: v2)
        self.configureShadow2(vi: v3)
        self.configureShadow2(vi: v4)

       
    }
    
    
    func addValuesToViews(carDetail:CarDetailModelCarDetails,is_Live:Bool){
        listingType.text = carDetail.listing_type?.capitalized
        vin.text = carDetail.vin
        selleingDealerName.text = (carDetail.seller?.capitalized ?? "N/A")
        sellingDealerLocation.text = (carDetail.location?.capitalized ?? "N/A")
        
        if (carDetail.listing_subtitle != nil){
            keyOptions.text = "Auction Result"
            keyOptions.text = carDetail.listing_subtitle ?? "N/A"
        }else{
            keyOptions.text = ""
            aurRes.text = "Auction Live"
        }
        
       
       
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 0
        let m = Int(carDetail.mileage ?? "0")
        milage.text = (numberFormatter.string(from: NSNumber(value: m ?? 0)) ?? "N/A") + " miles"
        
        
    }
}
