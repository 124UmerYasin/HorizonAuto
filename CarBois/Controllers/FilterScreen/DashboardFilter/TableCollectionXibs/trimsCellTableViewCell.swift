//
//  trimsCellTableViewCell.swift
//  CarBois
//
//  Created by Umer Yasin on 14/09/2022.
//

import UIKit
import MaterialShowcase

class trimsCellTableViewCell: UICollectionViewCell,MaterialShowcaseDelegate {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellDotImage: UIImageView!
    @IBOutlet weak var cellLabelPrice: UILabel!

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
    
    func showTutorial(){
        let showcase = MaterialShowcase()
        showcase.setTargetView(view: cellImage) // always required to set targetView
        showcase.primaryText = "Select Trim !"
        showcase.primaryTextSize = CGFloat(30)
        showcase.secondaryText = "you can select two trims to get more accurate results."
        showcase.secondaryTextSize = CGFloat(20)
        showcase.backgroundPromptColor = UIColor(named: "AccentColor")
        showcase.show(completion: {
            // You can save showcase state here
            // Later you can check and do not show it again
        })
        showcase.delegate = self
    }
    @objc func showCaseDidDismiss(showcase: MaterialShowcase, didTapTarget: Bool) {
        UserDefaults.standard.set(true, forKey: "searchfilterTrim")
    }
    
}
