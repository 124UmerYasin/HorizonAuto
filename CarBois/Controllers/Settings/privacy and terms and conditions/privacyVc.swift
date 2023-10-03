//
//  privacyVc.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 12/01/2023.
//

import UIKit

class privacyVc: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var termButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        backView.dropShadow()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onClickBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func onclickDoneButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickTermButton(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "termandConditionVC") as? termandConditionVC
        self.navigationController?.pushViewController(vc!, animated: true)

    }
}
