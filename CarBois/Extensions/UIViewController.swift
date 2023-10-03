//
//  UIViewController.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 22/09/2022.
//

import Foundation
import UIKit
import PUGifLoading

extension UIViewController{
    
    func showLoader(loader : PUGIFLoading){
        loader.hide()
        loader.show("", gifimagename: "asd",iWidth: 150,iHight: 150)
    }
    
    func hideLoader(loader : PUGIFLoading){
        loader.hide()
    }
    
    func navigateToVC(storyboard:String,vc:String){
        let viewController = UIStoryboard.init(name: storyboard, bundle: Bundle.main).instantiateViewController(withIdentifier: vc)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func getTime() -> String{
        // let hour = NSCalendar.currentCalendar().component(.Hour, fromDate: NSDate()) Swift 2 legacy
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
            
        case 6..<12 : return "Good Morning"
//        case 12 : return "Good Noon"
        case 12..<17 : return "Good Afternoon"
        case 17..<22 : return "Good Evening"
        default:  return "Good Night"
            
        }
    }
}
