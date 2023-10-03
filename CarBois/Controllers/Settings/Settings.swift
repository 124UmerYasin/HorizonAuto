//
//  Settings.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 02/12/2022.
//

import UIKit
import AVFoundation
import SDWebImage

class Settings: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var reportBtn: UIButton!
    
    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var editImage: UIButton!
    @IBOutlet weak var userName: UILabel!
    
    var attrs = [NSAttributedString.Key.font : UIFont(name: "Inter-Regular", size: 12)!,
                  NSAttributedString.Key.foregroundColor : UIColor.black,
                 NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
    var attributedString = NSMutableAttributedString(string:"")
    
    var attrs2 = [NSAttributedString.Key.font : UIFont(name: "Inter-Regular", size: 12)!,
                  NSAttributedString.Key.foregroundColor : UIColor(named: "AccentColor")!,
                 NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
    var attributedString2 = NSMutableAttributedString(string:"")
    
    var attrs3 = [NSAttributedString.Key.font : UIFont(name: "Inter-Regular", size: 12)!,
                  NSAttributedString.Key.foregroundColor : UIColor(named: "AccentColor")!,
                 NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
    var attributedString3 = NSMutableAttributedString(string:"")
    
    
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailLbl: UILabel!
    
    
    @IBOutlet weak var instagramView: UIView!
    @IBOutlet weak var instagramfield: UITextField!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var editBtnConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var referralCodeView: UIView!
    
    @IBOutlet weak var referalLbl: UILabel!
    
    
    
    @IBOutlet weak var tandcBtn: UIButton!
    @IBOutlet weak var privacyBtn: UIButton!
    
    @IBOutlet weak var logoutBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        instagramfield.delegate = self
        
        let buttonTitleStr = NSMutableAttributedString(string:"Having a Problem? Report an issue", attributes:attrs)
        attributedString.append(buttonTitleStr)
        reportBtn.setAttributedTitle(attributedString, for: .normal)
        
        let buttonTitleStr2 = NSMutableAttributedString(string:"Privacy Policy", attributes:attrs2)
        attributedString2.append(buttonTitleStr2)
        privacyBtn.setAttributedTitle(attributedString2, for: .normal)
        privacyBtn.contentHorizontalAlignment = .left

        let buttonTitleStr3 = NSMutableAttributedString(string:"Terms And Conditions", attributes:attrs3)
        attributedString3.append(buttonTitleStr3)
        tandcBtn.setAttributedTitle(attributedString3, for: .normal)
        tandcBtn.contentHorizontalAlignment = .left

        editBtn.setTitle(nil, for: .normal)
        editBtn.setImage(UIImage(named: "editiconSet")!, for: .normal)
        editBtnConstraint.constant = 30
        editBtn.backgroundColor = .clear
        
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        userName.text = UserDefaults.standard.string(forKey: "username")
        emailLbl.text = UserDefaults.standard.string(forKey: "userEmail")
        nameLbl.text = UserDefaults.standard.string(forKey: "username")

        imageViewProfile.sd_setImage(with: URL(string: UserDefaults.standard.string(forKey: "userPicture") ?? ""), placeholderImage: UIImage(named: "userProfile"))
        
        nameView.dropShadowHerer()
        emailView.dropShadowHerer()
        instagramView.dropShadowHerer()
        referralCodeView.dropShadowHerer()
    }
    
    @IBAction func onClickEditImage(_ sender: Any) {
        
        let alert = UIAlertController(title: "", message: "Choose an Option.", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: UIAlertAction.Style.default, handler: { [self] action in
            let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
            
            switch cameraAuthorizationStatus {
            case .notDetermined:
                requestCameraPermission(type: "camera")
            case .authorized:
                presentCamera(type: "camera")
            case .restricted, .denied:
                alertCameraAccessNeeded()
            @unknown default:
                fatalError()
            }
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default, handler: { [self] action in
            let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
            
            switch cameraAuthorizationStatus {
            case .notDetermined:
                requestCameraPermission(type: "gallery")
            case .authorized:
                presentCamera(type: "gallery")
            case .restricted, .denied:
                alertCameraAccessNeeded()
            @unknown default:
                fatalError()
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    
    func requestCameraPermission(type:String) {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: {accessGranted in
            guard accessGranted == true else { return }
            self.presentCamera(type: type)
        })
    }
    
    func presentCamera(type:String) {
        DispatchQueue.main.async {
            let photoPicker = UIImagePickerController()
            if type == "gallery"{
                photoPicker.sourceType = .photoLibrary
            }else if type == "camera"{
                photoPicker.sourceType = .camera
            }
            photoPicker.allowsEditing = true
            photoPicker.delegate = self
        
            self.present(photoPicker, animated: true, completion: nil)
        }
    }
    
    func alertCameraAccessNeeded() {
        let settingsAppURL = URL(string: UIApplication.openSettingsURLString)!
     
         let alert = UIAlertController(
             title: "Need Camera/Gallery Access",
             message: "Camera/Gallery access is required to make full use of this app.",
             preferredStyle: UIAlertController.Style.alert
         )
     
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Allow Camera/Gallery", style: .cancel, handler: { (alert) -> Void in
            UIApplication.shared.open(settingsAppURL, options: [:], completionHandler: nil)
        }))
    
        present(alert, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        imageViewProfile.image = image
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCLickReportBtn(_ sender: Any) {
    }
    
    @IBAction func onclickPrivacyBtn(_ sender: Any) {
    }
    
    @IBAction func onCLickTANDCBtn(_ sender: Any) {
    }
    
    @IBAction func onClickEditBtn(_ sender: Any) {
        if editBtn.title(for: .normal) == nil || editBtn.title(for: .normal) == "" {
            
            instagramfield.becomeFirstResponder()
//            editBtn.setTitle("Save", for: .normal)
//            editBtn.setImage(nil, for: .normal)
//            editBtnConstraint.constant = 50
//            editBtn.backgroundColor = UIColor(named: "editBackground")

        }else{
            
            instagramfield.resignFirstResponder()
//            editBtn.setTitle(nil, for: .normal)
//            editBtn.setImage(UIImage(named: "editiconSet")!, for: .normal)
//            editBtnConstraint.constant = 30
//            editBtn.backgroundColor = .clear

        }
       
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        editBtn.setTitle("Save", for: .normal)
        editBtn.setImage(nil, for: .normal)
        editBtnConstraint.constant = 50
        editBtn.backgroundColor = UIColor(named: "editBackground")
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        instagramfield.resignFirstResponder()
        editBtn.setTitle(nil, for: .normal)
        editBtn.setImage(UIImage(named: "editiconSet")!, for: .normal)
        editBtnConstraint.constant = 30
        editBtn.backgroundColor = .clear
    }
    @IBAction func onCLickLogoutbtn(_ sender: Any) {
        let customAlert = logoutAlert()
        customAlert.show()
    }
}
