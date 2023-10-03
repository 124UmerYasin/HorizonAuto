//
//  DropDownCell.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 19/12/2022.
//

import UIKit
import DropDown

class DropDownCell: UITableViewCell {

    @IBOutlet weak var dropdownLabel: UILabel!
    @IBOutlet weak var DropDownView: UIView!
    
    let dropDown = DropDown()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        DropDown.startListeningToKeyboard()
        
        DropDownView.layer.borderColor = UIColor.black.cgColor
        DropDownView.layer.cornerRadius = 5
        DropDownView.layer.borderWidth = 1
        
        dropDown.anchorView = DropDownView
//        dropDown.dataSource = ["Car", "Motorcycle", "Truck"]
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        DropDownView.addGestureRecognizer(tap)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        dropDown.show()
    }
    
}
