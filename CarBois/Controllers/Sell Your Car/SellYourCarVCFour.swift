//
//  SellYourCarVCFour.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 01/02/2023.
//

import UIKit
import AVFoundation
import Alamofire
import PUGifLoading
import SwiftConfettiView

class SellYourCarVCFour: UIViewController,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate  {
    
    @IBOutlet weak var tbv: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var images = [UIImage]()
    
    var link:String?
    let loading = PUGIFLoading()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        backView.dropShadow()
        tableView.dropShadow()
        tbv.dropShadow()
        let sell = UINib(nibName: "SellYourCarFour", bundle: nil)
        self.tableView.register(sell, forCellReuseIdentifier: "SellYourCarFour")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SellYourCarFour", for: indexPath) as? SellYourCarFour {
            cell.vc = self
            cell.onCLickNext = { [self] () in
                moveToNextVC()
            }
            cell.onCLickUpload = { [self] () in
                if images.count >= 10 {
                    AlertHelper.showAlertWithTitle(self, title: "You can select maximum 10 images.", dismissButtonTitle: "OK") { () -> Void in
                    }
                }else{
                    showAlertSheet()
                }
            }
            cell.deleteImage = { [self] (ind) in
                images.remove(at: ind)
            }
            cell.onCLickSubmit = { [self] () in
                if images.count < 1{
                    AlertHelper.showAlertWithTitle(self, title: "Please select at least 1 image.", dismissButtonTitle: "OK") { () -> Void in
                    }
                }else{
                    uploadImages()
                }
                
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func moveToNextVC(){
        let vc = UIStoryboard.init(name: "SellYourCar", bundle: Bundle.main).instantiateViewController(withIdentifier: "SellYourCarVCFour") as? SellYourCarVCFour
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    
    @IBAction func onClickBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK: -
    //show camera sheet
    func showAlertSheet(){
        DispatchQueue.main.async { [self] in
            
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
    }
    
    //MARK: -
    //open camera
    func requestCameraPermission(type:String) {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: {accessGranted in
            guard accessGranted == true else { return }
            self.presentCamera(type: type)
        })
    }
    
    func presentCamera(type:String) {
        DispatchQueue.main.async { [self] in
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
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: -
    // open camera
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        images.append((image ?? UIImage(named: "car2"))!)
        let imageDataDict:[String: [UIImage]] = ["image": images]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateImage"), object: nil, userInfo: imageDataDict)
        self.dismiss(animated: true, completion: nil)
    }
    
    func uploadImages(){
        showLoader(loader: loading)
        let group = DispatchGroup()
        
        for image in images {
            guard let imageData = image.jpegData(compressionQuality: 0.5) else {
                return
            }
            // Set up the request
            let headers: HTTPHeaders = ["Content-Type": "image/jpeg"]
            var request = URLRequest(url: URL(string: link!)!)
            request.headers = headers
            request.httpMethod = "PUT"
            request.timeoutInterval = 100
            let upload = AF.upload(imageData, with: request)
            group.enter()
            upload.validate().response { response in
                defer {
                    group.leave()
                }
                switch response.result {
                case .success:
                    print("Image uploaded successfully.")
                case .failure(let error):
                    print("Image upload failed with error: \(error.localizedDescription)")
                }
            }
            
        }
        group.notify(queue: DispatchQueue.main) { [self] in
            hideLoader(loader: loading)
            let confettiView = SwiftConfettiView(frame: self.view.bounds)
            self.view.addSubview(confettiView)
            confettiView.type = .confetti
            confettiView.startConfetti()
            AlertHelper.showAlertWithTitle(self, title: AppUtility.messageToShowAfterForm, dismissButtonTitle: "OK") { () -> Void in
                if(AppUtility.isUUidPresent){
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "navigateToModelAnalysis"), object: nil, userInfo: nil)
                    AppUtility.fromContactBuyer = true
                }else{
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "navigateToSellYouCarVCHome"), object: nil, userInfo: nil)
                    AppUtility.fromContactBuyer = false
                }
                confettiView.stopConfetti()
                self.dismiss(animated: true)
            }
//            let seconds = 1.0
//            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "navigateToModelAnalysis"), object: nil, userInfo: nil)
//                confettiView.stopConfetti()
//                self.dismiss(animated: true)
//            }

        }
        
    }
}
