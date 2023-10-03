//
//  MyGarageViewController.swift
//  CarBois
//
//  Created by Umer Yasin on 25/08/2022.
//

import UIKit

class MyGarageViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var cLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        
//        collectionView.register(UINib(nibName: "HeadingCell", bundle: nil), forCellWithReuseIdentifier: "HeadingCell")
//        collectionView.register(UINib(nibName: "GraphCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GraphCollectionViewCell")
//        collectionView.register(UINib(nibName: "CarouselSliderCell", bundle: nil), forCellWithReuseIdentifier: "CarouselSliderCell")
//        collectionView.register(UINib(nibName: "CarDisplayCell", bundle: nil), forCellWithReuseIdentifier: "CarDisplayCell")
//        collectionView.register(UINib(nibName: "graphFilter", bundle: nil), forCellWithReuseIdentifier: "graphFilter")
//        collectionView.register(UINib(nibName: "CarsFilter", bundle: nil), forCellWithReuseIdentifier: "CarsFilter")
//
//        
//        
//        collectionView.dataSource = self
//        collectionView.delegate = self
        
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cLabel.center.x = view.center.x // Place it in the center x of the view.
        cLabel.center.x -= view.bounds.width // Place it on the left of the view with the width = the bounds'width of the view.
            // animate it from the left to the right
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut,.curveEaseIn], animations: { [self] in
                cLabel.center.x += view.bounds.width
                  self.view.layoutIfNeeded()
            }, completion: nil)
    }
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }else  if section == 1 {
            return 1
        }else  if section == 2 {
            return 1
        }else  {
            return 5
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GraphCollectionViewCell", for: indexPath) as! GraphCollectionViewCell
            return cell
        }else if indexPath.section == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "graphFilter", for: indexPath) as! graphFilter
            return cell
        }else if indexPath.section == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarsFilter", for: indexPath) as! CarsFilter
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarDisplayCell", for: indexPath) as! CarDisplayCell
            cell.viewButton.setTitle("Research", for: .normal)
            cell.addToSavedbtnTapAction = { () in
                print("SAVE BUTTON TAPPED.")
            }
            cell.addToGaragebtnTapAction = { () in
                print("Garage BUTTON TAPPED.")
            }
            cell.viewbtnTapAction = { () in
                print("view BUTTON TAPPED.")

            }
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("you tapped me")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        
        if indexPath.section == 0 {
            let cellSize = CGSize(width: collectionView.bounds.width , height: 225)
            return cellSize
            
        }else if indexPath.section == 1 {
            let cellSize = CGSize(width: collectionView.bounds.width , height: 50)
            return cellSize
            
        }else if indexPath.section == 2 {
            let cellSize = CGSize(width: collectionView.bounds.width , height: 50)
            return cellSize
            
        }else {
            let cellSize = CGSize(width: (collectionView.bounds.width / 2) - 5, height: 250)
            return cellSize
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 18, left: 0, bottom: 0, right: 0)
            
        }else if section == 1 {
            return UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
            
        }else if section == 2 {
            return UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
            
        }else{
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }

}
