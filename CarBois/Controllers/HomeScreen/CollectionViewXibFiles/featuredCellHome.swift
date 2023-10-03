//
//  featuredCellHome.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 02/03/2023.
//

import UIKit
import SDWebImage

class featuredCellHome: UICollectionViewCell {
    
    @IBOutlet weak var carImages: UIImageView!
    @IBOutlet weak var carInfoImages: UIStackView!
    @IBOutlet weak var miles: UILabel!
    @IBOutlet weak var carDetails: UILabel!
    @IBOutlet weak var carName: UILabel!
    
    let numberFormatter = NumberFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func addData(cellData:FeaturedListingModelDatum){
        
        carName.text = "\(cellData.car_make?.make ?? "N/A") \(cellData.car_model?.model ?? "N/A")"
        
        if let customFont = UIFont(name: "Inter-Medium", size: 12) {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5
            
            let attributedString = NSMutableAttributedString(string: "\(cellData.car_make?.make ?? "N/A") | \(cellData.car_model?.model ?? "N/A") | \(cellData.car_generation?.generation ?? "N/A") | \(cellData.car_sub_generation?.sub_generation ?? "N/A") | \(cellData.trim_definition?.car_trim ?? "N/A")")
            attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
            attributedString.addAttribute(.font, value: customFont, range: NSMakeRange(0, attributedString.length))
            carDetails.attributedText = attributedString
        }
        carImages.layer.cornerRadius = 10
        
        //        carDetails.text = "\(cellData.car_make?.make ?? "N/A") | \(cellData.car_model?.model ?? "N/A") | \(cellData.car_generation?.generation ?? "N/A") | \(cellData.car_sub_generation?.sub_generation ?? "N/A") | \(cellData.trim_definition?.car_trim ?? "N/A")"
        
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
        carImages.sd_setImage(with: URL(string: cellData.images?[0] ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
    }
    
}
