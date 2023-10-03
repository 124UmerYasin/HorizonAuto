//
//  fullScreenImage.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 18/01/2023.
//

import UIKit

class fullScreenImage: UIViewController {

    @IBOutlet weak var fullScreenImage: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    var img = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullScreenImage.image = img

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

    @IBAction func onCLickCloseImage(_ sender: Any) {
        dismiss(animated: true)
    }
}
