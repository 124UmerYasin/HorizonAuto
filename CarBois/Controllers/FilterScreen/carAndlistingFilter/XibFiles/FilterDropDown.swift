//
//  FilterDropDown.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 19/12/2022.
//

import UIKit
import DropDown

class FilterDropDown: UITableViewCell {

    @IBOutlet weak var SortName: UILabel!
    @IBOutlet weak var sortView: UIView!
    
    let dropDown = DropDown()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        dropDown.anchorView = sortView
        dropDown.dataSource = ["Car", "Motorcycle", "Truck"]
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        sortView.addGestureRecognizer(tap)
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        dropDown.show()
    }
    
}
