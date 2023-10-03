//
//  ShimmerCell.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 30/12/2022.
//

import UIKit
import SkeletonView

class ShimmerCell: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var l2: UILabel!
    @IBOutlet weak var l1: UILabel!
    
    @IBOutlet weak var l3: UILabel!
    
    @IBOutlet weak var img1: UIImageView!
    
    @IBOutlet weak var viewButton: UIButton!
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var lx: UILabel!
    @IBOutlet weak var img2: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func makeCellAnimate(){
        let views = [img,l1,l2,l3,img1,img2,img3,img4,lx]
        lx.skeletonTextLineHeight = .fixed(30)
        views.forEach {$0?.showAnimatedGradientSkeleton()}
    }
    
    func stopAinmation(){
        let views = [img,l1,l2,l3,img1,img2,img3,img4,lx]
        views.forEach {$0?.stopSkeletonAnimation()}
    }
}
