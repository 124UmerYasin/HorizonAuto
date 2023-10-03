//
//  AnalysisFilter.swift
//  CarBois
//
//  Created by Umer Yasin on 08/09/2022.
//

import UIKit

class AnalysisFilter: UICollectionViewCell {

    @IBOutlet var filterButton: UIButton!
    
    @IBOutlet weak var filterImage: UIImageView!
    var onCLickFilterButton : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        filterImage.dropShadowonImage()

    }

    @IBAction func onCLickFilterButton(_ sender: Any) {
        
        onCLickFilterButton?()
    }
}
