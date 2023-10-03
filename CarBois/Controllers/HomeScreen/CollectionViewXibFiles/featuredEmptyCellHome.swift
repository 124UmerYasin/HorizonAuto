//
//  featuredEmptyCellHome.swift
//  Horizon Auto
//
//  Created by MAC on 19/07/2023.
//

import UIKit

class featuredEmptyCellHome: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 10
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        
        title.textAlignment = .center
        label.textAlignment = .center
    }
    
}
