//
//  priceRange.swift
//  CarBois
//
//  Created by Umer Yasin on 13/09/2022.
//

import UIKit
import RangeSeekSlider
import TTRangeSlider

class priceRange: UITableViewCell,TTRangeSliderDelegate {

    @IBOutlet weak var sliderPrice: TTRangeSlider!
    
    var sendMinMax : ((String,Int,Int)->())?
    var actualValue : ((String,Int,Int)->())?

    var type:String?
    
    var orignalMin:Double?
    var orignalMax:Double?
    var minRange:Double?
    var maxRange:Double?

    override func awakeFromNib() {
        super.awakeFromNib()
        sliderPrice.delegate = self
        // Initialization code
        sliderPrice.tintColor = UIColor(named: "pricefilterColor")

        sliderPrice.maxLabelFont = UIFont(name: "Inter-SemiBold", size: 14)!
        sliderPrice.minLabelColour = UIColor(named: "AccentColor")
        sliderPrice.minLabelFont = UIFont(name: "Inter-SemiBold", size: 14)!
        sliderPrice.maxLabelColour = UIColor(named: "AccentColor")
        sliderPrice.lineHeight = 12.0
        sliderPrice.handleColor = .white
        sliderPrice.handleBorderWidth = 1.0
        sliderPrice.handleBorderColor = .gray
        sliderPrice.handleDiameter = 20
        sliderPrice.selectedHandleDiameterMultiplier = 1.2
        sliderPrice.step = 1.0
        sliderPrice.enableStep = true
        sliderPrice.minDistance = 0.1
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setRanges(minRange:Double,maxRange:Double,type:String,orignalMin:Double,orignalMax:Double){
        

        
        self.type = type
        sliderPrice.minValue = Float(orignalMin)
        sliderPrice.maxValue = Float(orignalMax)
        sliderPrice.selectedMinimum = Float(minRange)
        sliderPrice.selectedMaximum = Float(maxRange)


        if type == "year"{
            let m = NumberFormatter()
            m.numberStyle = .none
            sliderPrice.numberFormatterOverride = m
        }else  if type == "price"{
            let m = NumberFormatter()
            m.numberStyle = .currency
            m.maximumFractionDigits = 0
            m.currencySymbol = "$"
            sliderPrice.numberFormatterOverride = m
        }else  if type == "mileage"{
            let m = NumberFormatter()
            m.numberStyle = .decimal
            m.maximumFractionDigits = 0
            sliderPrice.numberFormatterOverride = m
        }
     
        if orignalMin == orignalMax && minRange == maxRange{
            sliderPrice.disableRange = true
        }
        
        
//        sendMinMax?(type,Int(minRange),Int(maxRange))

    }
    
    func didEndTouches(in sender: TTRangeSlider!) {
        print("yoo")
        if sender.selectedMaximum > 0 {
            sendMinMax?(type!,Int(sender.selectedMinimum),Int(sender.selectedMaximum))
        }
//        actualValue?(type!,Int(sender.selectedMinimum),Int(sender.selectedMaximum))
    }
    
    func rangeSlider(_ sender: TTRangeSlider!, didChangeSelectedMinimumValue selectedMinimum: Float, andMaximumValue selectedMaximum: Float) {
//        sendMinMax?(type!,Int(selectedMinimum),Int(selectedMaximum))
//        print("Standard slider updated. Min Value: \(selectedMinimum) Max Value: \(selectedMaximum)")
    }
}
