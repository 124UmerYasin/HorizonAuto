//
//  searchWantToBuyAndSell.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 23/02/2023.
//

import UIKit

class searchWantToBuyAndSell: UICollectionViewCell {

    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var lbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.configureShadow(cornerRadius: 5)
    }

}
