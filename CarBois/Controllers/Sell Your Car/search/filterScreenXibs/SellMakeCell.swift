//
//  SellMakeCell.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 08/02/2023.
//

import UIKit

class SellMakeCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    
    

    private let demoLabel = UILabel()
    private let minCellSpacing: CGFloat = 0.0
    private var maxCellWidth: CGFloat! = 0.0
    
    @IBOutlet weak var makeCollectionVIew: UICollectionView!
    @IBOutlet weak var makeCollectionViewHeight: NSLayoutConstraint!
    
    var makeData : [CarMake]?

    var updateData = [CarMake]()
    
    @IBOutlet weak var viewMoreButton: UIButton!
    
    var onClickBtn : (()->())?
    var selectedModel : ((String,Int)->())?
    var AlreadyselectedModel : ((String,Int)->())?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.maxCellWidth = UIScreen.main.bounds.width - (minCellSpacing * 2)
        let layout = FlowLayout()
        makeCollectionVIew.register(UINib(nibName: "FilterCells", bundle: nil), forCellWithReuseIdentifier: "FilterCells")
        makeCollectionVIew.dataSource = self
        makeCollectionVIew.delegate = self
        makeCollectionVIew.collectionViewLayout = layout
                
        makeCollectionViewHeight.constant = 80
        makeCollectionVIew.layoutIfNeeded()
    }
    
    func updateMakeData(makeData:[CarMake]){
        self.makeData = makeData
        updateData = makeData
        makeCollectionVIew.reloadData()
//        makeCellHighlight(row: 0, section: 0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedModel?(updateData[indexPath.row].make ?? "N/A",updateData[indexPath.row].id ?? -1)
    }
    
    func makeCellHighlight(row:Int,section:Int){
        let path = IndexPath(row: row, section: section)
        makeCollectionVIew.selectItem(at: path, animated: true, scrollPosition: .bottom)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if updateData.count > 8{
            return 8
        }else{
            return updateData.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCells", for: indexPath) as! FilterCells
        cell.cellLabel.text = updateData[indexPath.row].make
        if AppUtility.isfromBuy{
            if AppUtility.isfromHome {
                if updateData[indexPath.row].id == AppUtility.selectedBuyFilterHome?.make{
                    makeCollectionVIew.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
                    AlreadyselectedModel?(updateData[indexPath.row].make ?? "N/A",updateData[indexPath.row].id ?? -1)
                }
            }else{
                if updateData[indexPath.row].id == AppUtility.selectedBuyFilter?.make{
                    makeCollectionVIew.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
                    AlreadyselectedModel?(updateData[indexPath.row].make ?? "N/A",updateData[indexPath.row].id ?? -1)
                }
            }
            
        }else{
            if AppUtility.isfromHome {
                if updateData[indexPath.row].id == AppUtility.selectedSellFilterHome?.make{
                    makeCollectionVIew.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
                    AlreadyselectedModel?(updateData[indexPath.row].make ?? "N/A",updateData[indexPath.row].id ?? -1)
                }
            }else{
                if updateData[indexPath.row].id == AppUtility.selectedSellFilter?.make{
                    makeCollectionVIew.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
                    AlreadyselectedModel?(updateData[indexPath.row].make ?? "N/A",updateData[indexPath.row].id ?? -1)
                }
            }
            
        }
       
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        self.demoLabel.text = updateData[indexPath.row].make
        self.demoLabel.sizeToFit()
        return CGSize(width: min(self.demoLabel.frame.width + 16 + 12, self.maxCellWidth + 12), height: 30)

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    @IBAction func onClickViewMoreBtn(_ sender: Any) {
        onClickBtn?()
    }
}
