//
//  MakeCell.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 21/09/2022.
//

import UIKit
import FittedSheets
class MakeCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var makeData = [CarMake]()
    var cellDelegate: MakeCollectionViewCellDelegate?

    private let demoLabel = UILabel()
    private let minCellSpacing: CGFloat = 0.0
    private var maxCellWidth: CGFloat! = 0.0
    
    @IBOutlet weak var makeCollectionView: UICollectionView!
    @IBOutlet weak var makeCollectionViewHeight: NSLayoutConstraint!
    
    
    var totalWidthPerRow = CGFloat(0)
    let spaceBetweenCell = 10
    var rowCounts = 0
    var numberOfItems = 0
    @IBOutlet weak var viewAllBtn: UIButton!
    
    var ccd : UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.maxCellWidth = UIScreen.main.bounds.width - (minCellSpacing * 2)
        let layout = FlowLayout()
        makeCollectionView.register(UINib(nibName: "FilterCells", bundle: nil), forCellWithReuseIdentifier: "FilterCells")
        makeCollectionView.dataSource = self
        makeCollectionView.delegate = self
        makeCollectionView.collectionViewLayout = layout
        
        let seconds = 0.1
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) { [self] in
          showVisibleCount()
        }
        
    }

    
    override func layoutSubviews() {
        makeCollectionViewHeight.constant = self.makeCollectionView.collectionViewLayout.collectionViewContentSize.height
        makeCollectionView.layoutIfNeeded()
    }
    
    func makeCellHighlight(row:Int,section:Int){
        let path = IndexPath(row: row, section: section)
        makeCollectionView.selectItem(at: path, animated: true, scrollPosition: .bottom)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state

    }
    
    func updateCellWith(carMake: [CarMake]) {
        self.makeData = carMake
        self.makeCollectionView.reloadData()
        makeCellHighlight(row: 0, section: 0)

    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return makeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCells", for: indexPath) as! FilterCells
        cell.cellLabel.text = makeData[indexPath.row].make!.capitalizingFirstLetter()
        if AppUtility.selectedMake == indexPath.row{
            makeCellHighlight(row: AppUtility.selectedMake, section: 0)
        }
        if AppUtility.selectedMake > numberOfItems - 1 {
            makeCellHighlight(row: 0, section: 0)

        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        self.demoLabel.text = makeData[indexPath.row].make!.capitalizingFirstLetter()
        self.demoLabel.sizeToFit()
        
        
        let collectionViewWidth = UIScreen.main.bounds.width
        let dynamicCellWidth = demoLabel.frame.width
        totalWidthPerRow += (dynamicCellWidth + CGFloat(spaceBetweenCell))
        if (totalWidthPerRow > collectionViewWidth) {
            rowCounts += 1
        }
        if rowCounts > 2{
            viewAllBtn.isHidden = false
            return CGSize(width: 0, height: 0)
        }else{
            viewAllBtn.isHidden = true
            numberOfItems += 1
            return CGSize(width: min(self.demoLabel.frame.width + 16 + 12, self.maxCellWidth + 12), height: 30)
        }
    }
    
    func showVisibleCount(){
        let visibleItemCount = makeCollectionView.visibleCells.count
        print("The collection view is currently showing \(visibleItemCount) items.")
        if AppUtility.selectedMake > numberOfItems - 1 {
//            rowCounts = 0
//            totalWidthPerRow = 0
//            numberOfItems = 0
//            makeData.swapAt(0, AppUtility.selectedMake)
//            self.makeCollectionView.reloadData()
            rowCounts = 0
            totalWidthPerRow = 0
            numberOfItems = 0
            makeData.swapAt(0, AppUtility.selectedMake)
            updateCellWith(carMake: makeData)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? FilterCells
        print("I'm tapping the \(indexPath.item)")
        self.cellDelegate?.makeCollectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    @IBAction func onClickViewAllBtn(_ sender: Any) {
        presentSheetForMake(makeData: makeData) { [self] make, id , selectedIndex in
            let cell = self.makeCollectionView.cellForItem(at: IndexPath(row: selectedIndex, section: 0)) as? FilterCells
            self.cellDelegate?.makeCollectionView(collectionviewcell: cell, index: selectedIndex, didTappedInTableViewCell: self)
            rowCounts = 0
            totalWidthPerRow = 0
            numberOfItems = 0
            makeData.swapAt(0, selectedIndex)
            updateCellWith(carMake: makeData)
        }
    }
    
    
    
    func presentSheetForMake(makeData:[CarMake],completion: @escaping (String,Int,Int) -> Void){

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
            searchData.append(dataForDetailSearch(name: item.make ?? "N/A", id: item.id ?? -1, index: 0))
        }
        
        vc.addDataMake(carMake: searchData, title: "Choose Make")
        
        sheetController.didDismiss = { vc in
            let vc = vc.childViewController as! DetailSearchVC
            if vc.isSelected{
                completion(vc.selectedValue ?? "fa",vc.selectedIndex ?? -1,vc.indexSelectedOfArr ?? 0)
            }
        }
        
        ccd?.present(sheetController, animated: true, completion: nil)
    }
    
    
}


protocol MakeCollectionViewCellDelegate {
    func makeCollectionView(collectionviewcell: FilterCells?, index: Int, didTappedInTableViewCell: MakeCell)
}
