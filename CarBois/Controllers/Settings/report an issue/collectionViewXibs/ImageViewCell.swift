//
//  ImageViewCell.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 18/01/2023.
//

import UIKit

class ImageViewCell: UICollectionViewCell {

    @IBOutlet weak var delButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var viewimage : (()->())?
    var delImage : (()->())?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        viewimage?()
    }
    
    @IBAction func onCLickDelButton(_ sender: Any) {
        delImage?()
    }
}
