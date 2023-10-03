//
//  SellYearCell.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 09/02/2023.
//

import UIKit

class SellYearCell: UITableViewCell {

    @IBOutlet weak var selectButton: UIButton!
    
    var onClickBtn : (()->())?
    
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateData(labeltext:String,placeHolder:String){
        label.text = labeltext
        field.placeholder = placeHolder
        field.text = ""
    }
    
    @IBAction func onClickSelectButton(_ sender: Any) {
        onClickBtn?()
    }
}
