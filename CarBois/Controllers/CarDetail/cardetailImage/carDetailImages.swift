//
//  carDetailImages.swift
//  CarBois
//
//  Created by Umer Yasin on 05/09/2022.
//

import UIKit
import ImageSlideshow

class carDetailImages: UICollectionViewCell,ImageSlideshowDelegate {

    @IBOutlet weak var imageViewCar: ImageSlideshow!
    let localSource = [BundleImageSource(imageString: "img1")]
    
    var vc = UIViewController()
    var sdWebImageSource = [SDWebImageSource]()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
        imageViewCar.contentScaleMode = UIViewContentMode.scaleAspectFill
        imageViewCar.activityIndicator = DefaultActivityIndicator()
        imageViewCar.delegate = self
        imageViewCar.setImageInputs(localSource)
        
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        imageViewCar.addGestureRecognizer(recognizer)
        
    }
    @objc func didTap() {
        let fullScreenController = imageViewCar.presentFullScreenController( from: vc)
        fullScreenController.slideshow.pageIndicator?.view.isHidden = true
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .large, color: nil)
    }
    
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        print("current page:", page)
    }
    
    func addImage(imageLink:URL){
        imageViewCar.pageIndicator = nil
        sdWebImageSource.append(SDWebImageSource(url: imageLink,placeholder: UIImage(named: "placeholder")))
        imageViewCar.setImageInputs(sdWebImageSource)

    }

}
