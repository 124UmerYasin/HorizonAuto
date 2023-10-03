//
//  ModelCell.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 21/09/2022.
//

import UIKit
import FittedSheets

class ModelCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var modelData = [Model]()
    var cellDelegate: ModelCollectionViewCellDelegate?

    @IBOutlet weak var modelCollectionView: UICollectionView!
    @IBOutlet weak var modelCollectionViewHeight: NSLayoutConstraint!
    
    private let demoLabel = UILabel()
    private let minCellSpacing: CGFloat = 0.0
    private var maxCellWidth: CGFloat! = 0.0
    
    var totalWidthPerRow = CGFloat(0)
    var spaceBetweenCell = 15
    var rowCounts = 0
    var numberOfItems = 0

    @IBOutlet weak var viewAllBtn: UIButton!
    var ccd : UIViewController?

    @IBOutlet weak var cellHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.maxCellWidth = UIScreen.main.bounds.width - (minCellSpacing * 2)
        let layout = FlowLayout()
        modelCollectionView.register(UINib(nibName: "FilterCells", bundle: nil), forCellWithReuseIdentifier: "FilterCells")
        modelCollectionView.dataSource = self
        modelCollectionView.delegate = self
        modelCollectionView.collectionViewLayout = layout
          
        let seconds = 0.1
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) { [self] in
          showVisibleCount()
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        modelCollectionViewHeight.constant = 110
//        modelCollectionView.layoutIfNeeded()
        rowCounts = 0
        totalWidthPerRow = 0
        numberOfItems = 0
    }
    
    override func layoutSubviews() {
//        modelCollectionViewHeight.constant = 110
//        modelCollectionView.layoutIfNeeded()
    }
    
    func makeCellHighlight(row:Int,section:Int){
        let path = IndexPath(row: row, section: section)
        modelCollectionView.selectItem(at: path, animated: true, scrollPosition: .bottom)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func updateCellWith(carModel: [Model]) {
        self.modelData = carModel
        self.modelCollectionView.reloadData()
        makeCellHighlight(row: 0, section: 0)
        
    }
    


    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCells", for: indexPath) as! FilterCells
        cell.cellLabel.text = modelData[indexPath.row].model?.capitalizingFirstLetter()
        if AppUtility.selectedModel == indexPath.row{
            makeCellHighlight(row: AppUtility.selectedModel, section: 0)
        }
        if AppUtility.selectedModel > numberOfItems - 1 {
            makeCellHighlight(row: 0, section: 0)

        }
        return cell
    }
    func tableView(_ collectionView: UICollectionView, canFocusRowAt indexPath: IndexPath) -> Bool {
          return false
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{

        self.demoLabel.text = modelData[indexPath.row].model
        self.demoLabel.sizeToFit()

        let collectionViewWidth = UIScreen.main.bounds.width
        let dynamicCellWidth = demoLabel.frame.width
        totalWidthPerRow += (dynamicCellWidth + CGFloat(spaceBetweenCell))
        if (totalWidthPerRow > collectionViewWidth) {
            rowCounts += 1
        }
        
        if rowCounts > 2{
            viewAllBtn.isHidden = false
            cellHeight.constant = 40
            return CGSize(width: 0, height: 0)
        }else{
            viewAllBtn.isHidden = true
            cellHeight.constant = 0
            numberOfItems += 1
            return CGSize(width: min(self.demoLabel.frame.width + 16 + 12, self.maxCellWidth + 12), height: 30)
        }

    }
    
    func showVisibleCount(){
        let visibleItemCount = modelCollectionView.visibleCells.count
        print("The collection view is currently showing \(visibleItemCount) items.")
        if AppUtility.selectedModel > numberOfItems - 1 {
            modelData.swapAt(0, AppUtility.selectedModel)
            rowCounts = 0
            totalWidthPerRow = 0
            numberOfItems = 0
            updateCellWith(carModel: modelData)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? FilterCells
        print("I'm tapping the \(indexPath.item)")
        self.cellDelegate?.modelCollectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    @IBAction func onCLickViewAllBtn(_ sender: Any) {
        presentSheetForMake(makeData: modelData) { [self] make, id , selectedIndex in
            let cell = self.modelCollectionView.cellForItem(at: IndexPath(row: selectedIndex, section: 0)) as? FilterCells
            self.cellDelegate?.modelCollectionView(collectionviewcell: cell, index: selectedIndex, didTappedInTableViewCell: self)
            rowCounts = 0
            totalWidthPerRow = 0
            numberOfItems = 0
            modelData.swapAt(0, selectedIndex)
            updateCellWith(carModel: modelData)
        }
    }
    
    func presentSheetForMake(makeData:[Model],completion: @escaping (String,Int,Int) -> Void){

        let controller = UIStoryboard(name: "SellYourCar", bundle: nil).instantiateViewController(withIdentifier: "DetailSearchVC")
        let sheetController = SheetViewController(
            controller: controller,
            sizes: [.percent(0.90)])
        sheetController.gripSize = CGSize(width: 50, height: 6)
        sheetController.gripColor = UIColor(white: 0.868, alpha: 1)
        sheetController.cornerRadius = 20
        sheetController.minimumSpaceAbovePullBar = 50
        sheetController.treatPullBarAsClear = true
        sheetController.dismissOnOverlayTap = true
        sheetController.dismissOnPull = true
        sheetController.allowPullingPastMaxHeight = true
        sheetController.autoAdjustToKeyboard = true
        sheetController.gripColor = .black
                
        let vc = sheetController.childViewController as! DetailSearchVC
        
        var searchData = [dataForDetailSearch]()
        for item in makeData {
            searchData.append(dataForDetailSearch(name: item.model ?? "N/A", id: item.id ?? -1, index: 0))
        }
        
        vc.addDataMake(carMake: searchData, title: "Choose Model")
        
        sheetController.didDismiss = { vc in
            let vc = vc.childViewController as! DetailSearchVC
            if vc.isSelected{
                completion(vc.selectedValue ?? "fa",vc.selectedIndex ?? -1,vc.indexSelectedOfArr ?? 0)
            }
        }
        
        ccd?.present(sheetController, animated: true, completion: nil)
    }
    
}


protocol ModelCollectionViewCellDelegate {
    func modelCollectionView(collectionviewcell: FilterCells?, index: Int, didTappedInTableViewCell: ModelCell)
}
