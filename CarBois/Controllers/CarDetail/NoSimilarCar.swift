//
//  NoSimilarCar.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 14/10/2022.
//

import UIKit

class NoSimilarCar: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        self.configureShadow(cornerRadius: 8)
    }
}
