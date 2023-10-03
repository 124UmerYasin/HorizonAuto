//
//  graphFilter.swift
//  CarBois
//
//  Created by Umer Yasin on 25/08/2022.
//

import UIKit

class graphFilter: UICollectionViewCell {
    
    @IBOutlet weak var segmentcontrol: UISegmentedControl!
    
    var segmentCompletion : ((String)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.gray], for: .normal)
        fixBackgroundSegmentControl(segmentcontrol)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.configureShadow(cornerRadius: 5)
    }
    
    
    func fixBackgroundSegmentControl( _ segmentControl: UISegmentedControl){
        if #available(iOS 13.0, *) {
            //just to be sure it is full loaded
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                for i in 0...(segmentControl.numberOfSegments-1)  {
                    let backgroundSegmentView = segmentControl.subviews[i]
                    //it is not enogh changing the background color. It has some kind of shadow layer
                    backgroundSegmentView.isHidden = true
                }
            }
        }
    }
    
        
        @IBAction func onSegmentValue(_ sender: UISegmentedControl) {
            if sender.selectedSegmentIndex == 0 {
                segmentCompletion?(tenure.oneMonth.rawValue)
                AppUtility.SelectedIndex = 0
                AppUtility.Tenure = tenure(rawValue: tenure.oneMonth.rawValue)
            } else if sender.selectedSegmentIndex == 1 {
                segmentCompletion?(tenure.threeMonth.rawValue)
                AppUtility.SelectedIndex = 1
                AppUtility.Tenure = tenure(rawValue: tenure.threeMonth.rawValue)
            } else if sender.selectedSegmentIndex == 2 {
                segmentCompletion?(tenure.sixMonth.rawValue)
                AppUtility.SelectedIndex = 2
                AppUtility.Tenure = tenure(rawValue: tenure.sixMonth.rawValue)
            }else if sender.selectedSegmentIndex == 3 {
                segmentCompletion?(tenure.oneYear.rawValue)
                AppUtility.SelectedIndex = 3
                AppUtility.Tenure = tenure(rawValue: tenure.oneYear.rawValue)
            }else if sender.selectedSegmentIndex == 4 {
                segmentCompletion?(tenure.twoYest.rawValue)
                AppUtility.SelectedIndex = 4
                AppUtility.Tenure = tenure(rawValue: tenure.twoYest.rawValue)
            }else if sender.selectedSegmentIndex == 5 {
                segmentCompletion?(tenure.threeYear.rawValue)
                AppUtility.SelectedIndex = 5
                AppUtility.Tenure = tenure(rawValue: tenure.threeYear.rawValue)
            }else if sender.selectedSegmentIndex == 6 {
                segmentCompletion?(tenure.all.rawValue)
                AppUtility.SelectedIndex = 6
                AppUtility.Tenure = tenure(rawValue: tenure.all.rawValue)
            }
        }
    }
