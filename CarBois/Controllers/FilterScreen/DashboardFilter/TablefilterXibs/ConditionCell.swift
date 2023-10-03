//
//  ConditionCell.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 21/09/2022.
//

import UIKit

class ConditionCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
     var cellDelegate: ConditionCollectionViewCellDelegate?

    private let demoLabel = UILabel()
    private let minCellSpacing: CGFloat = 0.0
    private var maxCellWidth: CGFloat! = 0.0
    
    @IBOutlet weak var conditionCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeignt: NSLayoutConstraint!
    
    var conditionData = ["Used"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.maxCellWidth = UIScreen.main.bounds.width - (minCellSpacing * 2)
        let layout = FlowLayout()
        conditionCollectionView.register(UINib(nibName: "FilterCells", bundle: nil), forCellWithReuseIdentifier: "FilterCells")
        conditionCollectionView.dataSource = self
        conditionCollectionView.delegate = self
        conditionCollectionView.collectionViewLayout = layout
        

    }

    override func layoutSubviews() {
        collectionViewHeignt.constant = self.conditionCollectionView.collectionViewLayout.collectionViewContentSize.height + 25
        conditionCollectionView.layoutIfNeeded()
    }
    
    func makeCellHighlight(row:Int,section:Int){
        conditionData = ["Used"]
        self.conditionCollectionView.reloadData()
        let path = IndexPath(row: row, section: section)
        conditionCollectionView.selectItem(at: path, animated: true, scrollPosition: .bottom)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return conditionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCells", for: indexPath) as! FilterCells
        cell.cellLabel.text = conditionData[indexPath.row]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? FilterCells
        print("I'm tapping the \(indexPath.item)")
        self.cellDelegate?.conditionCollectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        self.demoLabel.text = conditionData[indexPath.row]
        self.demoLabel.sizeToFit()
        return CGSize(width: min(self.demoLabel.frame.width + 16 + 12, self.maxCellWidth + 12), height: 30)

    }
}


protocol ConditionCollectionViewCellDelegate {
    func conditionCollectionView(collectionviewcell: FilterCells?, index: Int, didTappedInTableViewCell: ConditionCell)
}
