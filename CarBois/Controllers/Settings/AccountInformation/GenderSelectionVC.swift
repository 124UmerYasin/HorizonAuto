//
//  GenderSelectionVC.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 19/01/2023.
//

import UIKit

class GenderSelectionVC: UIViewController {

    @IBOutlet weak var otherButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var maleButton: UIButton!
    
    
    @IBOutlet weak var maleSelected: UIImageView!
    @IBOutlet weak var femaleSelected: UIImageView!
    @IBOutlet weak var otherSelected: UIImageView!
    
    var selected:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        selected = AppUtility.Gender
        defaultSelected()
    }
    
    func defaultSelected(){
        if selected == "Male"{
            selected = "Male"
            maleSelected.image = UIImage(named: "selected")
            femaleSelected.image = nil
            otherSelected.image = nil
        }else if selected == "Female"{
            selected = "Female"
            maleSelected.image = nil
            femaleSelected.image = UIImage(named: "selected")
            otherSelected.image = nil
        }else{
            selected = "Other"
            maleSelected.image = nil
            femaleSelected.image = nil
            otherSelected.image = UIImage(named: "selected")
        }
    }
    
    @IBAction func onClickMaleButton(_ sender: Any) {
        AppUtility.Gender = "Male"
        selected = "Male"
        maleSelected.image = UIImage(named: "selected")
        femaleSelected.image = nil
        otherSelected.image = nil
        self.dismiss(animated: true)

        
    }
    
    @IBAction func onClickFemailButton(_ sender: Any) {
        AppUtility.Gender = "Female"
        selected = "Female"
        maleSelected.image = nil
        femaleSelected.image = UIImage(named: "selected")
        otherSelected.image = nil
        self.dismiss(animated: true)

    }
    
    @IBAction func onClickOtherButton(_ sender: Any) {
        AppUtility.Gender = "Other"
        selected = "Other"
        maleSelected.image = nil
        femaleSelected.image = nil
        otherSelected.image = UIImage(named: "selected")
        self.dismiss(animated: true)

    }
}
