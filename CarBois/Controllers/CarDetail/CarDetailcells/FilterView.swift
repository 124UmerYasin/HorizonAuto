//
//  FilterView.swift
//  CarBois
//
//  Created by Umer Yasin on 02/09/2022.
//

import UIKit

class FilterView: UICollectionViewCell {

    @IBOutlet weak var filterViewButton: UIButton!
    
    var clickAction : (()-> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        self.configureShadow(cornerRadius: 5)
    }
    
    
    @IBAction func onCLickButton(_ sender: Any) {
        clickAction?()
    }
}
