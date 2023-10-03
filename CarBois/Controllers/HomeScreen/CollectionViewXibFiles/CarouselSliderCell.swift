//
//  CarouselSliderCell.swift
//  CarBois
//
//  Created by Umer Yasin on 23/08/2022.
//

import UIKit
import FSPagerView


class CarouselSliderCell: UICollectionViewCell,ViewPagerDataSource {
   
    

    @IBOutlet weak var swipeView: ViewPager!
    
    @IBOutlet weak var pageControl: UIView!
    
    var viewbtnTapAction : (()->())?

    
    let pageControl2 = WOPageControl(frame: CGRect(x: 0, y: 0, width: 50, height: 50))

    
    override func awakeFromNib() {
        super.awakeFromNib()
        

        swipeView.layer.cornerRadius = 10
        swipeView.dataSource = self
        swipeView.scrollToPage(index: 0)
        swipeView.pageControl.isHidden = true
//        swipeView.animationNext()
        
//        pageControl2.cornerRadius = 3;
        pageControl2.dotHeight = 2;
        pageControl2.dotSpace = 3;
        pageControl2.currentDotWidth = 16;
        pageControl2.otherDotWidth = 8;
        pageControl2.otherDotColor = UIColor(named: "currentDotWidth")
        pageControl2.currentDotColor = .black
        pageControl2.numberOfPages = 4;
        
        pageControl.addSubview(pageControl2)
    }
    
    func didSelectedItem(index: Int) {
        viewbtnTapAction?()
    }
    override func layoutSubviews() {
        self.configureShadow(cornerRadius: 10)
    }

    
    func numberOfItems(viewPager: ViewPager) -> Int {
        return 4
    }
    
    func viewAtIndex(viewPager: ViewPager, index: Int, view: UIView?) -> UIView {
        if index == 0 {
            let newView = UIView()
            let child = UINib(nibName: "featuredCellHome", bundle: .main).instantiate(withOwner: nil, options: nil).first as! featuredCellHome
            child.frame = newView.bounds
            child.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            if AppUtility.featuredListing?.count ?? 0 > 0{
                child.addData(cellData: (AppUtility.featuredListing?[0])!)
            }
            newView.addSubview(child)
            return newView
        }else if index == 1{
            let newView = UIView()
            let child = UINib(nibName: "featuredCellHome", bundle: .main).instantiate(withOwner: nil, options: nil).first as! featuredCellHome
            child.frame = newView.bounds
            child.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            if AppUtility.featuredListing?.count ?? 0 > 0{
                child.addData(cellData: (AppUtility.featuredListing?[1])!)
            }
            newView.addSubview(child)
            return newView
        }else if index == 2{
            let newView = UIView()
            let child = UINib(nibName: "featuredCellHome", bundle: .main).instantiate(withOwner: nil, options: nil).first as! featuredCellHome
            child.frame = newView.bounds
            child.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            if AppUtility.featuredListing?.count ?? 0 > 0{
                child.addData(cellData: (AppUtility.featuredListing?[2])!)
            }
            newView.addSubview(child)
            return newView
        }else{
            let newView = UIView()
            let child = UINib(nibName: "featuredCellHome", bundle: .main).instantiate(withOwner: nil, options: nil).first as! featuredCellHome
            child.frame = newView.bounds
            child.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            if AppUtility.featuredListing?.count ?? 0 > 3{
                child.addData(cellData: (AppUtility.featuredListing?[3])!)
            }
            newView.addSubview(child)
            return newView
        }
    }
    
    func currentIndex(index: Int) {
        if index == 0 {
            pageControl2.currentPage = 0
        }else if index == 1 {
            pageControl2.currentPage = 1
        }else if index == 2 {
            pageControl2.currentPage = 2
        }else if index == 3 {
            pageControl2.currentPage = 3
        }
    }
    
}
