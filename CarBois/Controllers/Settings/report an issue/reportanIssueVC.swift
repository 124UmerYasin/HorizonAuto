//
//  reportanIssueVC.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 12/01/2023.
//

import UIKit
import AVFoundation

class reportanIssueVC: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
   
    

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var browseButton: UIButton!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var browseView: UIView!
    
    
    @IBOutlet weak var imageCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if images.isEmpty{
            imageCollectionViewHeight.constant = 0
        }else{
            imageCollectionViewHeight.constant = 100

        }
        
        backView.dropShadow()
        browseView.addLineDashedStroke(pattern: [6, 6], radius: 10, color: UIColor.gray.cgColor,button: browseButton)
        
        imageCollectionView.register(UINib(nibName: "ImageViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageViewCell")
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if images.isEmpty{
            imageCollectionViewHeight.constant = 0
        }else{
            imageCollectionViewHeight.constant = 100

        }
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageViewCell", for: indexPath) as! ImageViewCell
        cell.imageView.image = images[indexPath.row]
        cell.delImage = { [self] () in
            images.remove(at: indexPath.row)
            imageCollectionView.reloadData()
        }
        cell.viewimage = { [self] () in
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "fullScreenImage") as? fullScreenImage
            vc?.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
            vc?.img = images[indexPath.row]
            present(vc!, animated: true, completion: nil)
            //            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let cellSize = CGSize(width: collectionView.bounds.height - 20, height: collectionView.bounds.height - 20)
        return cellSize
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
    }
    
    @IBAction func onClickBrowseButton(_ sender: Any) {
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
    
    @IBAction func onClickBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    
    @IBAction func onClickDoneButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    @IBAction func onClickSubmitButton(_ sender: Any) {
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
             title: "Need Camera Access",
             message: "Camera access is required to make full use of this app.",
             preferredStyle: UIAlertController.Style.alert
         )
     
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Allow Camera", style: .cancel, handler: { (alert) -> Void in
            UIApplication.shared.open(settingsAppURL, options: [:], completionHandler: nil)
        }))
    
        present(alert, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        images.append((image ?? UIImage(named: "car2"))!)
        imageCollectionView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension UIView {
    @discardableResult
    func addLineDashedStroke(pattern: [NSNumber]?, radius: CGFloat, color: CGColor,button:UIButton) -> CALayer {
        let borderLayer = CAShapeLayer()

        borderLayer.strokeColor = color
        borderLayer.lineDashPattern = pattern
        borderLayer.frame = bounds
        borderLayer.fillColor = nil
        borderLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius)).cgPath

        layer.addSublayer(borderLayer)
        return borderLayer
    }
}
