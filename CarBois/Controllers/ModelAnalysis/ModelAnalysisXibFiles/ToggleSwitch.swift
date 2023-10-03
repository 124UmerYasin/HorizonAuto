//
//  ToggleSwitch.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 29/11/2022.
//

import UIKit

class ToggleSwitch: UICollectionViewCell {

    @IBOutlet weak var toggleSwitchButton: UISwitch!
    
    @IBOutlet weak var listingLabels: UILabel!
    var sendSwitchState : ((Bool)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        toggleSwitchButton.transform = CGAffineTransformMakeScale(0.75, 0.75)

        // Initialization code
    }

    @IBAction func onClickToggleButton(_ sender: Any) {
        if toggleSwitchButton.isSelected{
            toggleSwitchButton.isSelected = false
            sendSwitchState!(false)
            listingLabels.text = "Historic Listings"
        }else{
            toggleSwitchButton.isSelected = true
            sendSwitchState!(true)
            listingLabels.text = "Live Listings"
        }
    }
    
    func makeButtonNormal(){
        if !AppUtility.ToggleState! || !AppUtility.showCurrentHistoric{
            
            toggleSwitchButton.setOn(false, animated: true)
            toggleSwitchButton.isSelected = false
            AppUtility.ToggleState = false
            AppUtility.showCurrentHistoric = false
            listingLabels.text = "Historic Listings"
        }else{
            toggleSwitchButton.setOn(true, animated: true)
            toggleSwitchButton.isSelected = true
            AppUtility.ToggleState = true
            AppUtility.showCurrentHistoric = true
            listingLabels.text = "Live Listings"
        }

    }
}
