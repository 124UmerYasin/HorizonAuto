//
//  screen5.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 16/05/2023.
//

import UIKit

class screen5: UITableViewCell {

    @IBOutlet weak var v3: UIView!
    
    @IBOutlet weak var v2: UIView!
    @IBOutlet weak var v1: UIView!
    
    
    @IBOutlet weak var accidentImg: UIImageView!
    @IBOutlet weak var carFacxInfo: UILabel!
    @IBOutlet weak var titleInfo: UILabel!
    @IBOutlet weak var zip: UILabel!
    @IBOutlet weak var listingDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.configureShadow2(vi: v1)
        self.configureShadow2(vi: v2)
        self.configureShadow2(vi: v3)
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
        addAccidentPicture(cellData: cellData.carfax_accident_info ?? "")
        carFacxInfo.text = cellData.carfax_accident_info ?? "N/A"
        titleInfo.text = cellData.title_info
        zip.text = cellData.posterZip
        listingDescription.text = cellData.listing_description
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
    
}
