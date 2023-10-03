//
//  FilterCells.swift
//  CarBois
//
//  Created by Umer Yasin on 26/08/2022.
//

import UIKit

class FilterCells: UICollectionViewCell {
    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var cellLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        outerView.backgroundColor = .clear
        outerView.layer.cornerRadius = 5
        outerView.layer.borderWidth = 1
        outerView.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    override var isSelected: Bool {
        didSet {
            cellLabel.textColor = isSelected ? .white : .black
            outerView.backgroundColor = isSelected ? .black : .clear
        }
    }
    
    
}
