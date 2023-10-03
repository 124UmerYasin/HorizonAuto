//
//  UiCollectionViewCell.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 30/09/2022.
//

import Foundation

extension UICollectionViewCell{
    func configureShadow(cornerRadius:Int){
        self.contentView.layer.cornerRadius = CGFloat(cornerRadius)
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 3
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowColor = UIColor(named: "shadow")?.cgColor
        
        self.layer.masksToBounds = false
    }
    
    
    func configureShadow2(vi:UIView){
        vi.layer.cornerRadius = 7
        vi.layer.shadowRadius = 3
        vi.layer.shadowOpacity = 3
        vi.layer.shadowOffset = CGSize(width: 0, height: 1)
        vi.layer.shadowColor = UIColor(named: "shadow")?.cgColor
        vi.layer.masksToBounds = false
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
    
    func resizeImagenew(image: UIImage, newWidth: CGFloat) -> UIImage {

        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.draw(in: CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    
    func resizedImage(at image: UIImage, for size: CGSize) -> UIImage? {
        let image = image

        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
   
    
}
