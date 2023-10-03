//
//  CarouselSliderCellShimmer.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 09/05/2023.
//

import UIKit

class CarouselSliderCellShimmer: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var carImahe: UIImageView!
    @IBOutlet weak var images: UIStackView!
    @IBOutlet weak var miles: UILabel!
    @IBOutlet weak var detailName: UILabel!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func makeCellAnimate(){
        let views = [carImahe,images,miles,detailName,name]
        name.skeletonTextLineHeight = .fixed(40)
        carImahe.skeletonCornerRadius = 10
        views.forEach {$0?.showAnimatedGradientSkeleton()}
    }
    
    func stopAinmation(){
        let views = [carImahe,images,miles,detailName,name]
        views.forEach {$0?.stopSkeletonAnimation()}
    }

}
