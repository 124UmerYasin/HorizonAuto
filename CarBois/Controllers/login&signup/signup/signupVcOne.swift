//
//  signupVcOne.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 06/01/2023.
//

import UIKit

class signupVcOne: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onclickNext(_ sender: Any) {
        let vc = UIStoryboard.init(name: "login", bundle: Bundle.main).instantiateViewController(withIdentifier: "sgnupvc2") as? sgnupvc2
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    @IBAction func onCLickBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
