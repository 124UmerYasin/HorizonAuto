//
//  carDetailToggleView.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 01/12/2022.
//

import UIKit

class carDetailToggleView: UICollectionViewCell {

    @IBOutlet weak var toggleSwitchCarDetail: UISwitch!
    @IBOutlet weak var carDetailLabel: UILabel!
    var sendSwitchState : ((Bool)->())?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        toggleSwitchCarDetail.transform = CGAffineTransformMakeScale(0.75, 0.75)

    }

    @IBAction func onClickToggleButton(_ sender: Any) {
        if toggleSwitchCarDetail.isSelected{
            toggleSwitchCarDetail.isSelected = false
            sendSwitchState!(false)
            carDetailLabel.text = "Historic Listings"
        }else{
            toggleSwitchCarDetail.isSelected = true
            sendSwitchState!(true)
            carDetailLabel.text = "Live Listings"
            
            
        }
    }
    
    func makeButtonNormal(){
        if !AppUtility.ToggleState!{
            
            toggleSwitchCarDetail.setOn(false, animated: true)
            toggleSwitchCarDetail.isSelected = false
            AppUtility.ToggleState = false
            carDetailLabel.text = "Historic Listings"
        }

    }
    
}
