//
//  GenerationCell.swift
//  CarBois
//
//  Created by Umer Yasin on 14/09/2022.
//

import UIKit

class GenerationCell: UICollectionViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    var generationId:Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var isSelected: Bool {
        didSet {
//            cellLabel.textColor = isSelected ? .black : .gray
        }
    }

}
