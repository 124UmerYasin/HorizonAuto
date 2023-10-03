//
//  CustomView.swift
//  CarBois
//
//  Created by Umer Yasin on 13/09/2022.
//

import UIKit

class CustomView: UITableViewCell {
    
    @IBOutlet weak var filterImage: UIImageView!
    @IBOutlet weak var filterText: UILabel!
    @IBOutlet weak var filterNumber: UILabel!
    var selectedIndex:Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}




