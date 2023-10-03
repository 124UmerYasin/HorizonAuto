//
//  TableHeader.swift
//  CarBois
//
//  Created by Umer Yasin on 09/09/2022.
//

import UIKit

class TableHeader: UITableViewCell {

    @IBOutlet weak var stackHeight: NSLayoutConstraint!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var cellHeading: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let myDogs = [
                      Dog(name: "Saleks", gender: "Male", speed: 50),
                      Dog(name: "Balto", gender: "Male", speed: 70),
                      Dog(name: "Mila", gender: "Female", speed: 20)
                  ]

       
              
        for _ in myDogs {
            
            let child = UINib(nibName: "CustomView", bundle: .main).instantiate(withOwner: nil, options: nil).first as! UIView
            stackView.addArrangedSubview(child)
         }
        
        stackHeight.constant = CGFloat(myDogs.count * 25)
         stackView.translatesAutoresizingMaskIntoConstraints = false
    

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state

    }
    
}

struct Dog{
    var name:String
    var gender:String
    var speed:Int

}

