//
//  SellTrimCell.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 10/02/2023.
//

import UIKit

class SellTrimCell: UITableViewCell {

    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var trimName: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if isSelected{
            trimName.textColor = .black
            imgView.image =  UIImage(named: "tick")

        }else{
            trimName.textColor = .lightGray
            imgView.image =  UIImage(named: "uncheck")

        }
    }
    
}
