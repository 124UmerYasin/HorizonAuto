//
//  WTBListingCollectionVIewCEll.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 03/03/2023.
//

import UIKit

class WTBListingCollectionVIewCEll: UICollectionViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var WTBCollectionView: UICollectionView!
    var btnClicked : ((String)->())?
    var clickAction : (()->())?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        WTBCollectionView.register(UINib(nibName: "WTBListingCell", bundle: nil), forCellWithReuseIdentifier: "WTBListingCell")
        WTBCollectionView.register(UINib(nibName: "shimmerCellHome", bundle: nil), forCellWithReuseIdentifier: "shimmerCellHome")
        WTBCollectionView.register(UINib(nibName: "NoCarFoundCell", bundle: nil), forCellWithReuseIdentifier: "NoCarFoundCell")

        WTBCollectionView.dataSource = self
        WTBCollectionView.delegate = self
    }
    
    func configureCell(){
        self.WTBCollectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if AppUtility.WTBListing?.count == 0{
            return 1
        }else{
            return AppUtility.WTBListing?.count ?? 2
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if AppUtility.WTBListing != nil {
            if AppUtility.WTBListing?.count == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoCarFoundCell", for: indexPath) as! NoCarFoundCell
                
                cell.title.textAlignment = .center
                cell.label.textAlignment = .center
                cell.title.text = "Uh-Oh...💩"
                cell.label.text = "You Haven't Created Any \"Want to Buy\" (WTB) Listings Yet. Tap The Button Below To Create One."
                cell.btn.setTitle("Create Want-To-Buy Listing", for: .normal)
//                }
                cell.clickAction = { [self] () in
                    clickAction?()
                }
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WTBListingCell", for: indexPath) as! WTBListingCell
                cell.configureCell(cellData: AppUtility.WTBListing![indexPath.row])
                cell.btnClicke = { [self] (uuid) in
                    btnClicked?(uuid)
                }
                return cell
            }
           
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shimmerCellHome", for: indexPath) as! shimmerCellHome
            cell.makeCellAnimate()
            return cell
        }
       
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if AppUtility.WTBListing?.count == 0 {
        }else{
            btnClicked?(AppUtility.WTBListing![indexPath.row].uuid ?? "")
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if AppUtility.WTBListing != nil {
            if AppUtility.WTBListing?.count == 0{
                let cellSize = CGSize(width: (collectionView.bounds.width) - 8, height: 190)
                return cellSize
            }else{
                let cellSize = CGSize(width: (collectionView.bounds.width / 2) - 9, height: 200)
                return cellSize
            }
        }else{
            let cellSize = CGSize(width: (collectionView.bounds.width / 2) - 9, height: 200)
            return cellSize
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)

    }
}
