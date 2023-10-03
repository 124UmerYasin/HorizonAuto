//
//  carDetailText.swift
//  CarBois
//
//  Created by Umer Yasin on 02/09/2022.
//

import UIKit
import MaterialShowcase

class carDetailText: UICollectionViewCell,MaterialShowcaseDelegate {
    
    @IBOutlet weak var textVire: UIView!
    
    @IBOutlet weak var carModel: UILabel!
    
    @IBOutlet weak var carTrim: UILabel!
    
    @IBOutlet weak var currentPrice: UILabel!
    
    @IBOutlet weak var priceChange: UILabel!
    
    @IBOutlet weak var priceChangeImage: UIImageView!
    
    @IBOutlet weak var priceVsMarket: UILabel!
    
    
    @IBOutlet weak var listedTime: UILabel!
    
    @IBOutlet weak var currentTitle: UILabel!
    
    
    @IBOutlet weak var filterCarModel: UILabel!
    @IBOutlet weak var filterCarSubGen: UILabel!
    @IBOutlet weak var filterCarTrims: UILabel!
    
    
    @IBOutlet weak var viewSourceStack: UIStackView!
    
    var onClickFilterHistory : (()->())?
    var onviewSource : (()->())?

    @IBOutlet weak var viewSourceImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewSourceStack.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: Notification.Name("myNotification2"), object: nil)

    }
    @objc func handleNotification(_ notification: Notification) {
        // Handle the notification
        showTutorial()
    }
    override func layoutSubviews() {
        
        textVire.layer.cornerRadius = 5
        textVire.layer.shadowRadius = 1
        textVire.layer.shadowOpacity = 0.3
        textVire.layer.shadowOffset = CGSize(width: 0, height: 0)
        textVire.layer.shadowColor = UIColor.black.cgColor
        textVire.layer.masksToBounds = false
        
    }
    
    
    @IBAction func onClickFilterHistory(_ sender: Any) {
        onClickFilterHistory?()
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        onviewSource?()
    }
    
    func showTutorial(){
        let showcase = MaterialShowcase()
        showcase.setTargetView(view: viewSourceImage) // always required to set targetView
        showcase.primaryText = "View Source"
        showcase.primaryTextSize = CGFloat(30)
        showcase.secondaryText = "View the orignal listing of this car by tapping here."
        showcase.secondaryTextSize = CGFloat(20)
        showcase.backgroundPromptColor = UIColor(named: "AccentColor")
        showcase.show(completion: {
            // You can save showcase state here
            // Later you can check and do not show it again
        })
        showcase.delegate = self
    }
    
    func showCaseDidDismiss(showcase: MaterialShowcase, didTapTarget: Bool) {
        UserDefaults.standard.set(true, forKey: "cardetail")
    }
    
}
