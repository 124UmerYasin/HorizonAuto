//
//  CarDisplayCell.swift
//  CarBois
//
//  Created by Umer Yasin on 23/08/2022.
//

import UIKit
import SDWebImage
import SkeletonView

class CarDisplayCell: UICollectionViewCell {

  
    @IBOutlet weak var addToGarageButton: UIButton!
    @IBOutlet weak var addToSavedButton: UIButton!
    @IBOutlet weak var viewButton: UIButton!
    
    
    var addToGaragebtnTapAction : (()->())?
    var addToSavedbtnTapAction : (()->())?
    var viewbtnTapAction : (()->())?

    @IBOutlet weak var outerView: UIView!
    
    
    @IBOutlet weak var carTrim: UILabel!
    @IBOutlet weak var carMake: UILabel!
    @IBOutlet weak var carPrice: UILabel!
    @IBOutlet weak var carPricePercentageChange: UILabel!
    @IBOutlet weak var priceArrow: UIImageView!
    
    @IBOutlet weak var carImage: UIImageView!
    
    let numberFormatter = NumberFormatter()
    let strNumber = NumberFormatter()
    
    @IBOutlet weak var favImh: UIImageView!
    
    @IBOutlet weak var garageImg: UIImageView!
    
    @IBOutlet weak var stackViewView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = "$"
        numberFormatter.minimumFractionDigits = 0
        strNumber.numberStyle = .decimal
        favImh.image = UIImage(named: "favourite")
        
    }

    func makeCellAnimate(){
        let views = [carTrim, carMake,carPrice,carPricePercentageChange,carImage,priceArrow,viewButton]
        views.forEach {$0?.showAnimatedGradientSkeleton()}

            
    }
    
    func stopAinmation(){
        let views = [carTrim, carMake,carPrice,carPricePercentageChange,carImage,priceArrow,viewButton]
        views.forEach {$0?.stopSkeletonAnimation()}
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.configureShadow(cornerRadius: 10)
        viewButton.layer.shadowColor = UIColor.black.cgColor
        viewButton.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        viewButton.layer.shadowRadius = 4
        viewButton.layer.shadowOpacity = 0.3
        viewButton.layer.masksToBounds = false
        viewButton.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 12)!

    }
    
    @IBAction func onClickGarageButton(_ sender: Any) {
        addToGaragebtnTapAction?()
    }
    
    @IBAction func onClickSaveButton(_ sender: Any) {
    
        if favImh.image == UIImage(named: "favourite"){
            favImh.image = UIImage(named: "heart2")
        }else{
            favImh.image = UIImage(named: "favourite")
        }
        

        
        addToSavedbtnTapAction?()
    }
    @IBAction func onClickViewButton(_ sender: Any) {
        AppUtility.FilterApplied = nil
        AppUtility.SortApplied = nil
        viewbtnTapAction?()
    }
    
    func setData(data:HotPick){
        carTrim.text = data.trim ?? "N/A"
        carMake.text = data.make?.capitalized ?? "N/A"
        
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = "$"
        numberFormatter.minimumFractionDigits = 0
        
        carPrice.text = numberFormatter.string(from: NSNumber(value: data.percentageChange?.currentMonthMarketAverage?.average ?? 0))
        let mag = numberFormatter.string(from: NSNumber(value: data.percentageChange?.percentageChange?.magnitude ?? 0))
        let pc = data.percentageChange?.percentageChange?.percentage ?? 0
        carPricePercentageChange.text = "\(mag ?? "0")(\(pc )%)"
        
        if data.percentageChange?.percentageChange?.direction == "decrease"{
            carPricePercentageChange.textColor = .red
            priceArrow.image = UIImage(named: "decrease")
            carPricePercentageChange.text = "-\(mag ?? "0")(\(pc )%)"
        }else{
            carPricePercentageChange.textColor = UIColor(named: "grapgGreen")
            priceArrow.image = UIImage(named: "upArrow")
        }
        
        carImage.sd_setImage(with: URL(string: data.image ?? ""), placeholderImage: UIImage(named: "placeholder.png"))

    }
    
    
}
