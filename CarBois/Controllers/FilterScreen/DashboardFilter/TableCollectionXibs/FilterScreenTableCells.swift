//
//  FilterScreenTableCells.swift
//  CarBois
//
//  Created by Umer Yasin on 30/08/2022.
//

import UIKit

class FilterScreenTableCells: UICollectionViewCell {
    
    @IBOutlet weak var cellLabelPrice: UILabel!
    @IBOutlet weak var cellDotImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellImage: UIImageView!

    var CellData:dashboardfilteratabledataModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if isSelected{
            cellLabel.textColor = .black
            cellImage.image =  UIImage(named: "tick")
            cellDotImage.image =  cellDotImage.image!.withTintColor(.systemPink, renderingMode: .automatic)
        }else{
            cellLabel.textColor = .lightGray
            cellImage.image =  UIImage(named: "uncheck")
            cellDotImage.image =  cellDotImage.image!.withTintColor(.clear, renderingMode: .automatic)
        }
    }
    
    override var isSelected: Bool{
        didSet{
            if isSelected {
            }

        }
    }
    
    
}
