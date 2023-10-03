//
//  screen2.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 16/05/2023.
//

import UIKit

class screen2: UITableViewCell {

    @IBOutlet weak var v4: UIView!
    @IBOutlet weak var v1: UIView!
    @IBOutlet weak var v2: UIView!
    
    
    @IBOutlet weak var v3: UIView!
    
    @IBOutlet weak var purchaseFrom: UILabel!
    
    @IBOutlet weak var listingTimeLine: UILabel!
    
    @IBOutlet weak var zip: UILabel!
    
    @IBOutlet weak var purchasingRightAway: UILabel!
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
        purchaseFrom.text = cellData.dealerOrPrivate
        listingTimeLine.text = cellData.listingTimeline
        zip.text = cellData.posterZip
        if cellData.listingTimeline == "Immediate" {
            purchasingRightAway.text = "Yes"

        }else{
            purchasingRightAway.text = "No"

        }
    }
}
