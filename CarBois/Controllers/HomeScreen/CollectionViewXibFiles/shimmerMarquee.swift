//
//  shimmerMarquee.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 08/03/2023.
//

import UIKit

class shimmerMarquee: UICollectionViewCell {


    @IBOutlet weak var shimmerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func makeCellAnimate(){
        let views = [shimmerView]
        views.forEach {$0?.showAnimatedGradientSkeleton()}
    }
    
    func stopAinmation(){
        let views = [shimmerView]
        views.forEach {$0?.stopSkeletonAnimation()}
    }
    
}
