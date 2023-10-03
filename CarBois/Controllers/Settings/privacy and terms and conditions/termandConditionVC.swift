//
//  termandConditionVC.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 12/01/2023.
//

import UIKit

class termandConditionVC: UIViewController {

    @IBOutlet weak var ackView: UIView!
    @IBOutlet weak var donButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ackView.dropShadow()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onclickBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func onClickDoneButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
