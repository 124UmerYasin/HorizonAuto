//
//  CarFilterCell.swift
//  CarBois
//
//  Created by Umer Yasin on 02/09/2022.
//

import UIKit
import MaterialShowcase

class CarFilterCell: UICollectionViewCell {
    
    @IBOutlet weak var filterImage: UIImageView!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var lbl: UILabel!
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var listingLbl: UILabel!
    var onCLickFilterButtonAction : (()->())?
    
    var isShowTutorial:Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        filterImage.dropShadowonImage()
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: Notification.Name("myNotification"), object: nil)

    }
    
    func hideButtonAndViews(){
        filterButton.isUserInteractionEnabled = false
        listingLbl.isHidden = true
        filterImage.isHidden = true
        lineView.isHidden = true
    }
    

    @objc func handleNotification(_ notification: Notification) {
        // Handle the notification
        showTutorial()
    }
    
    @IBAction func onCLickFilterButton(_ sender: Any) {
        onCLickFilterButtonAction?()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func showTutorial(){
        if isShowTutorial{
            let showcase = MaterialShowcase()
            showcase.setTargetView(view: filterImage) // always required to set targetView
            showcase.primaryText = "Filters"
            showcase.primaryTextSize = CGFloat(30)
            showcase.secondaryText = "Apply the car related filters to get accurate car listings."
            showcase.secondaryTextSize = CGFloat(20)
            showcase.backgroundPromptColor = UIColor(named: "AccentColor")
            showcase.show(completion: {
                // You can save showcase state here
                // Later you can check and do not show it again
            })
            isShowTutorial = false
        }
    }
}


extension UIImageView {
    func dropShadowonImage() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 2
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
