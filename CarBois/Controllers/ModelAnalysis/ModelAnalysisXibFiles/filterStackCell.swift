//
//  filterStackCell.swift
//  CarBois
//
//  Created by Umer Yasin on 08/09/2022.
//

import UIKit

class filterStackCell: UICollectionViewCell {

    @IBOutlet weak var modelName: UILabel!
    @IBOutlet weak var currentAveragePrice: UILabel!

    @IBOutlet weak var currentPriceChange: UILabel!
    
    @IBOutlet weak var currentPriceChangeImage: UIImageView!
    
    @IBOutlet weak var lastMonth: UILabel!
    @IBOutlet weak var lastMonthPrice: UILabel!
    
    @IBOutlet weak var makeNmae: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
