//
//  SellYourCarFour.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 02/02/2023.
//

import UIKit
import MBRadioCheckboxButton
import AVFoundation

class SellYourCarFour: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {



    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    
    @IBOutlet weak var uploadBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!

    
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var imageCollectionViewHeight: NSLayoutConstraint!
    var images = [UIImage]()

    
    var onCLickNext : (()->())?
    var onCLickUpload : (()->())?
    var deleteImage : ((Int)->())?

    var vc : UIViewController!
    
    var onCLickSubmit : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imageCollectionView.register(UINib(nibName: "ImageViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageViewCell")
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.addimage(_:)), name: NSNotification.Name(rawValue: "updateImage"), object: nil)

    }
    
    @objc func addimage(_ notification: NSNotification) {
        if let image = notification.userInfo?["image"] as? [UIImage] {
            self.images = image
            imageCollectionView.reloadData()
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @IBAction func onClickUploadBtn(_ sender: Any) {
        onCLickUpload?()
    }
    
    @IBAction func onCLickSubmitBtn(_ sender: Any) {
        onCLickSubmit?()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageViewCell", for: indexPath) as! ImageViewCell
        cell.imageView.image = images[indexPath.row]
        cell.delButton.backgroundColor = UIColor(named: "AppNewColor")!
        cell.delImage = { [self] () in
            deleteImage?(indexPath.row)
            images.remove(at: indexPath.row)
            imageCollectionView.reloadData()
        }
        cell.viewimage = { [self] () in
            let vcc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "fullScreenImage") as? fullScreenImage
            vcc?.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
            vcc?.img = images[indexPath.row]
            vc!.present(vcc!, animated: true, completion: nil)
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
    
    
}
