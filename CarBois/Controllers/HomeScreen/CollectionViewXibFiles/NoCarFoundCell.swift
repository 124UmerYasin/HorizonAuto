//
//  NoCarFoundCell.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 30/05/2023.
//

import UIKit

class NoCarFoundCell: UICollectionViewCell {

    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var title: UILabel!
    
    var clickAction : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // to add shadow to the collection
        self.layer.cornerRadius = 10
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false

    }

    @IBAction func clickBtn(_ sender: Any) {
        clickAction?()
    }
}
