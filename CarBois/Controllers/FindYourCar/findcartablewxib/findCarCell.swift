//
//  findCarCell.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 17/02/2023.
//

import UIKit
import SDWebImage

class findCarCell: UICollectionViewCell {

    var uuid:String?
    @IBOutlet weak var macMileage: UILabel!
    @IBOutlet weak var minMileage: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameModelLbl: UILabel!
    @IBOutlet weak var btn: UIButton!
    
    var comp : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureImage(image:String,uuid:String){
        self.uuid = uuid

    }
    
    func configureMinMax(min:String,max:String){
        minMileage.text = "\(min)\(max)"
//        macMileage.text = max
    }
    
    func configureMile(min:String,max:String){
        minMileage.text = min
//        macMileage.isHidden = true
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.configureShadow(cornerRadius: 10)
//        viewButton.layer.shadowColor = UIColor.black.cgColor
//        viewButton.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
//        viewButton.layer.shadowRadius = 4
//        viewButton.layer.shadowOpacity = 0.3
//        viewButton.layer.masksToBounds = false
//        viewButton.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 12)!
    }
    
    @IBAction func onCickBtn(_ sender: Any) {
        comp?()
    }
}
