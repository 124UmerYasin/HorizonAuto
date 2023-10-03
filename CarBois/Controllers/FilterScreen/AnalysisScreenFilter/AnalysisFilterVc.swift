//
//  AnalysisFilterVc.swift
//  CarBois
//
//  Created by Umer Yasin on 09/09/2022.
//

import UIKit

class AnalysisFilterVc: UIViewController {
    
    @IBOutlet weak var applyFilerButton: UIButton!
    @IBOutlet weak var currentFilterButton: UIButton!
    @IBOutlet weak var historicFilterButton: UIButton!
    @IBOutlet weak var optionFIlterLabel: UILabel!
    @IBOutlet weak var individualListingButton: UIButton!
    @IBOutlet weak var averageButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        applyFilerButton.dropShadow()
        addboarderAndCornerRadius(button: currentFilterButton)
        addboarderAndCornerRadius(button: historicFilterButton)
       

        if !AppUtility.showAverage! {
            averageButton.setImage(UIImage(named: "uncheck"), for: .normal)
            averageButton.setTitleColor(UIColor(named: "unSelected"), for: .normal)
            
        }else{
            averageButton.setImage(UIImage(named: "check"), for: .normal)
            averageButton.setTitleColor(.black, for: .normal)
        }
        
        if !AppUtility.showIndividualListing! {
            individualListingButton.setImage(UIImage(named: "uncheck"), for: .normal)
            individualListingButton.setTitleColor(UIColor(named: "unSelected"), for: .normal)
        }else{
            individualListingButton.setImage(UIImage(named: "check"), for: .normal)
            individualListingButton.setTitleColor(.black, for: .normal)
        }
        
        if AppUtility.showCurrentHistoric{
            currentFilterButton.sendActions(for: .touchUpInside)
        }else{
            historicFilterButton.sendActions(for: .touchUpInside)

        }
    }
    
    
    func addboarderAndCornerRadius(button:UIButton){
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
    }
    
    
    @IBAction func onClickAverage(_ sender: Any) {
        if AppUtility.showAverage! {
            averageButton.setImage(UIImage(named: "uncheck"), for: .normal)
            averageButton.setTitleColor(UIColor(named: "unSelected"), for: .normal)
            AppUtility.showAverage = false
            AppUtility.showCurrentHistoric = false
            AppUtility.ToggleState = false

            
        }else{
            averageButton.setImage(UIImage(named: "check"), for: .normal)
            averageButton.setTitleColor(.black, for: .normal)
            AppUtility.showAverage = true
            AppUtility.showCurrentHistoric = false
            AppUtility.ToggleState = false


        }
    }
    
    @IBAction func onCLickIndividualListing(_ sender: Any) {
        if AppUtility.showIndividualListing! {
            individualListingButton.setImage(UIImage(named: "uncheck"), for: .normal)
            individualListingButton.setTitleColor(UIColor(named: "unSelected"), for: .normal)
            AppUtility.showIndividualListing = false

        }else{
            individualListingButton.setImage(UIImage(named: "check"), for: .normal)
            individualListingButton.setTitleColor(.black, for: .normal)
            AppUtility.showIndividualListing = true

        }
        
    }
    @IBAction func onClickHistoricButton(_ sender: Any) {
        historicFilterButton.backgroundColor = .black
        historicFilterButton.setTitleColor(.white, for: .normal)

        currentFilterButton.backgroundColor = .white
        currentFilterButton.setTitleColor(.black, for: .normal)

        optionFIlterLabel.isHidden = false
        individualListingButton.isHidden = false
        averageButton.isHidden = false
        AppUtility.showCurrentHistoric = false
        AppUtility.ToggleState = false


    }
    @IBAction func onCLickCurrentButton(_ sender: Any) {
        currentFilterButton.backgroundColor = .black
        currentFilterButton.setTitleColor(.white, for: .normal)
        
        historicFilterButton.backgroundColor = .white
        historicFilterButton.setTitleColor(.black, for: .normal)

        optionFIlterLabel.isHidden = true
        individualListingButton.isHidden = true
        averageButton.isHidden = true
        
        AppUtility.showCurrentHistoric = true
        AppUtility.ToggleState = true

        individualListingButton.setImage(UIImage(named: "uncheck"), for: .normal)
        individualListingButton.setTitleColor(UIColor(named: "unSelected"), for: .normal)
        AppUtility.showIndividualListing = false

        averageButton.setImage(UIImage(named: "uncheck"), for: .normal)
        averageButton.setTitleColor(UIColor(named: "unSelected"), for: .normal)
        AppUtility.showAverage = false

    }
    @IBAction func onClickApplyFilterButton(_ sender: Any) {
        if !AppUtility.showAverage! && !AppUtility.showIndividualListing! && !AppUtility.showCurrentHistoric{
            let alet = UIAlertController(title: "Error", message: "You have to select at least one option for Historic Filter to work.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .destructive)
            alet.addAction(action)
            self.present(alet, animated: true)
        }else{
            AppUtility.is_filter_Applied = true
            AppUtility.FilterApplied = nil
            self.dismiss(animated: true, completion: nil)
        }
        
    }
}
