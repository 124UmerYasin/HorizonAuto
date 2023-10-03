//
//  SettingTableViewCell.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 11/01/2023.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    @IBOutlet weak var ttLabel: UILabel!
    @IBOutlet weak var objView: UIView!
    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func layoutSubviews() {
//        dropShadowHerer()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    
//    func dropShadowHerer() {
//        objView.layer.shadowColor = UIColor(named: "newShadow")?.cgColor
//        objView.layer.shadowOffset = CGSize(width: 0, height: 1)
//        objView.layer.shadowRadius = 0.2
//        objView.layer.shadowOpacity = 15
//        objView.layer.masksToBounds = false
//    }
    
}
