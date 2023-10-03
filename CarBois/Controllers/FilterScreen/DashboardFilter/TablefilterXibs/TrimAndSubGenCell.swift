//
//  TrimAndSubGenCell.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 21/09/2022.
//

import UIKit
import Foundation

class TrimAndSubGenCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var AllLabel: UILabel!
    @IBOutlet weak var trimAndSubGenCollectionView: UICollectionView!
    @IBOutlet weak var trimAndSubGenCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var allLabelView: UIView!
    
    var tableData : [dashboardfilteratabledataModel] = [dashboardfilteratabledataModel]()
    var limit:Int = 2
    
    var cellDelegate: trimAndSubGenCollectionViewCellDelegate?
    
    var messageDelegate: showMessage?

    var checkImgae:[String] = [String]()
    
    var redColor : Bool = false
    var blueColor : Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        AllLabel.isHidden = true
        trimAndSubGenCollectionView.dataSource = self
        trimAndSubGenCollectionView.delegate = self
        trimAndSubGenCollectionView.register(UINib(nibName: "trimsCellTableViewCell", bundle: nil), forCellWithReuseIdentifier: "trimsCellTableViewCell")
        trimAndSubGenCollectionView.register(UINib(nibName: "FilterScreenTableCells", bundle: nil), forCellWithReuseIdentifier: "FilterScreenTableCells")
        
        trimAndSubGenCollectionViewHeight.constant = 250
        trimAndSubGenCollectionView.layoutIfNeeded()
        
        trimAndSubGenCollectionView.allowsMultipleSelection = true
        
    }
    
    
    override func layoutSubviews() {
        // border radius
        allLabelView.layer.cornerRadius = 10.0

        // drop shadow
        allLabelView.layer.shadowColor = UIColor.black.cgColor
        allLabelView.layer.shadowOpacity = 0.2
        allLabelView.layer.shadowRadius = 1
        allLabelView.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
    }

    func updateCellWith(tableData: [dashboardfilteratabledataModel]) {
        if tableData.count > 0 {
            allLabelView.isHidden = true
            AllLabel.isHidden = true

            trimAndSubGenCollectionView.isHidden = false
            self.tableData = tableData
            self.trimAndSubGenCollectionView.reloadData()
            
            
            let seconds = 0.3
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) { [self] in
                let indexPath = IndexPath(item: 1, section: 0);
                if let customCell = trimAndSubGenCollectionView.cellForItem(at: indexPath) as? trimsCellTableViewCell {
                    if !UserDefaults.standard.bool(forKey: "searchfilterTrim"){
                        customCell.showTutorial()
                    }
                }
            }
        }else{
            allLabelView.isHidden = false
            AllLabel.isHidden = false

            trimAndSubGenCollectionView.isHidden = true
        }
       
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if tableData[indexPath.row].isSubGen{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterScreenTableCells", for: indexPath) as! FilterScreenTableCells
            cell.cellLabel.text = tableData[indexPath.row].CarSubGenerationName
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .currency
            numberFormatter.currencySymbol = "$"
            numberFormatter.minimumFractionDigits = 0
            cell.cellLabelPrice.text = numberFormatter.string(from: NSNumber(value: tableData[indexPath.row].CarSubGenerationPrice))
            if tableData[indexPath.row].CarSubGenerationdirection == "increase"{
                cell.cellLabelPrice.textColor = UIColor(named: "grapgGreen")
            }else{
                cell.cellLabelPrice.textColor = .red
            }
            cell.CellData = tableData[indexPath.row]
            for item in AppUtility.seletedTableIndex {
                if item.TrimDefinitionId == tableData[indexPath.row].TrimDefinitionId && item.CarSubGenerationId == tableData[indexPath.row].CarSubGenerationId {
                    cell.cellLabel.textColor = .black
                    cell.cellImage.image =  UIImage(named: "tick")
                    cell.cellDotImage.image =  cell.cellDotImage.image!.withTintColor(UIColor(named: item.Color)!, renderingMode: .automatic)
                    self.trimAndSubGenCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
                }
            }
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trimsCellTableViewCell", for: indexPath) as! trimsCellTableViewCell
            cell.cellLabel.text = tableData[indexPath.row].TrimDefinitionName
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .currency
            numberFormatter.currencySymbol = "$"
            numberFormatter.minimumFractionDigits = 0
            cell.cellLabelPrice.text = numberFormatter.string(from: NSNumber(value: tableData[indexPath.row].TrimDefinitionPrice))
            
            if tableData[indexPath.row].TrimDefinitiondirection == "increase"{
                cell.cellLabelPrice.textColor = UIColor(named: "grapgGreen")
            }else{
                cell.cellLabelPrice.textColor = .red
            }
            cell.CellData = tableData[indexPath.row]
            for item in AppUtility.seletedTableIndex {
                if item.TrimDefinitionId == tableData[indexPath.row].TrimDefinitionId && item.CarSubGenerationId == tableData[indexPath.row].CarSubGenerationId {
                    cell.cellLabel.textColor = .black
                    cell.cellImage.image =  UIImage(named: "tick")
                    cell.cellDotImage.image =  cell.cellDotImage.image!.withTintColor(UIColor(named: item.Color)!, renderingMode: .automatic)
                    self.trimAndSubGenCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])

                }
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
        if ((collectionView.cellForItem(at: indexPath) as? trimsCellTableViewCell) != nil) {
            let cell = collectionView.cellForItem(at: indexPath) as? trimsCellTableViewCell
            self.cellDelegate?.trimAndSubGenCollection(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
        }else{
            let cell = collectionView.cellForItem(at: indexPath) as? FilterScreenTableCells
            self.cellDelegate?.trimAndSubGenCollection(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
        }
        trimAndSubGenCollectionView.reloadItems(at: [indexPath])
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if ((collectionView.cellForItem(at: indexPath) as? trimsCellTableViewCell) != nil) {
            let cell = collectionView.cellForItem(at: indexPath) as? trimsCellTableViewCell
            self.cellDelegate?.trimAndSubGenCollectionDeselect(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
        }else{
            let cell = collectionView.cellForItem(at: indexPath) as? FilterScreenTableCells
            self.cellDelegate?.trimAndSubGenCollectionDeselect(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
        }
        trimAndSubGenCollectionView.reloadItems(at: [indexPath])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: trimAndSubGenCollectionView.bounds.width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 1, height: 20)

    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        if tableData[indexPath.row].isSubGen{
            for (index,temp) in tableData.enumerated(){
                if temp.CarSubGenerationId == tableData[indexPath.row].CarSubGenerationId && !temp.isSubGen{
                    let cell = collectionView.cellForItem(at: indexPath) as? FilterScreenTableCells
                    self.cellDelegate?.trimAndSubGenCollectionDeselect(collectionviewcell: cell, index: index, didTappedInTableViewCell: self)
                    trimAndSubGenCollectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
                }
            }
        }else{
            for (index,temp) in tableData.enumerated(){
                if temp.TrimDefinitionId == -1 && temp.CarSubGenerationId == tableData[indexPath.row].CarSubGenerationId{
                    let cell = collectionView.cellForItem(at: indexPath) as? trimsCellTableViewCell
                    self.cellDelegate?.trimAndSubGenCollectionDeselect(collectionviewcell: cell, index: index, didTappedInTableViewCell: self)
                    trimAndSubGenCollectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
                }
            }
        }
        
        if AppUtility.seletedTableIndex.count == limit {
            print("cant selected")
            messageDelegate?.showErrorMessage(message: "Uh-oh, a maximum of two values can be selected.")
            return false
        }
        return true
        
    }
}


protocol trimAndSubGenCollectionViewCellDelegate {
    func trimAndSubGenCollection(collectionviewcell: trimsCellTableViewCell?, index: Int, didTappedInTableViewCell: TrimAndSubGenCell)
    func trimAndSubGenCollectionDeselect(collectionviewcell: trimsCellTableViewCell?, index: Int, didTappedInTableViewCell: TrimAndSubGenCell)
    
    func trimAndSubGenCollection(collectionviewcell: FilterScreenTableCells?, index: Int, didTappedInTableViewCell: TrimAndSubGenCell)
    func trimAndSubGenCollectionDeselect(collectionviewcell: FilterScreenTableCells?, index: Int, didTappedInTableViewCell: TrimAndSubGenCell)
    
}


protocol showMessage{
    func showErrorMessage(message:String)
}
