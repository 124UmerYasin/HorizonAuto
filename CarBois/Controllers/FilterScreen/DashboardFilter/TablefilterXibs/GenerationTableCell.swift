//
//  GenerationTableCell.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 21/09/2022.
//

import UIKit
import MaterialShowcase

class GenerationTableCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, MaterialShowcaseDelegate {

    var generationData = [CarGeneration]()
    var cellDelegate: GenerationCollectionViewCellDelegate?

    @IBOutlet weak var generationCollectionView: UICollectionView!
    private let demoLabel = UILabel()
    private let minCellSpacing: CGFloat = 0.0
    private var maxCellWidth: CGFloat! = 0.0
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.maxCellWidth = UIScreen.main.bounds.width - (minCellSpacing * 2)
        generationCollectionView.register(UINib(nibName: "GenerationCell", bundle: nil), forCellWithReuseIdentifier: "GenerationCell")
        generationCollectionView.dataSource = self
        generationCollectionView.delegate = self
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(userLoggedIn), name: Notification.Name("trimSelected"), object: nil)

    }
    
    
    @objc func userLoggedIn(notification: NSNotification){
        generationCollectionView.reloadData()
    }
 
    func makeCellHighlight(row:Int,section:Int){
        let path = IndexPath(row: row, section: section)
        generationCollectionView.selectItem(at: path, animated: true, scrollPosition: .bottom)
    }

    func updateCellWith(carGeneration: [CarGeneration]) {
        self.generationData = carGeneration
        self.generationCollectionView.reloadData()
        makeCellHighlight(row: 0, section: 0)
        let seconds = 0.3
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) { [self] in
            if !UserDefaults.standard.bool(forKey: "searchfilterGen"){
                showTutorial()
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return generationData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenerationCell", for: indexPath) as! GenerationCell
        let attributedString = NSMutableAttributedString.init(string: generationData[indexPath.row].generation?.capitalizingFirstLetter() ?? "Not Found")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 0, length: attributedString.length))
        cell.cellLabel.attributedText = attributedString
        if AppUtility.selectedGeneration == indexPath.row{
            cell.cellLabel.textColor = .black
        }else{
            cell.cellLabel.textColor = .gray
        }
        for item in AppUtility.seletedTableIndex{
            if generationData[indexPath.row].id == item.carGenerationID{
                cell.cellLabel.textColor = UIColor(named: item.Color)
                self.generationCollectionView.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)
            }
        }
        return cell
        
    }
    func showTutorial(){
        let showcase = MaterialShowcase()
        showcase.setTargetView(collectionView: generationCollectionView, section: 0, item: 1) // always required to set targetView
        showcase.primaryText = "Select Generation !"
        showcase.primaryTextSize = CGFloat(30)
        showcase.secondaryText = "Please Select a generation if you'd like to search for a specific sub-generation and trim."
        showcase.secondaryTextSize = CGFloat(20)
        showcase.backgroundPromptColor = UIColor(named: "AccentColor")
        showcase.targetHolderRadius = 30
        showcase.targetHolderColor = .white
        showcase.show(completion: {
            // You can save showcase state here
            // Later you can check and do not show it again
        })
        showcase.delegate = self
    }
    @objc func showCaseDidDismiss(showcase: MaterialShowcase, didTapTarget: Bool) {
        UserDefaults.standard.set(true, forKey: "searchfilterGen")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? GenerationCell
        print("I'm tapping the \(indexPath.item)")
        self.generationCollectionView.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)
        self.cellDelegate?.generationCollectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        self.demoLabel.text = generationData[indexPath.row].generation
        self.demoLabel.sizeToFit()
        return CGSize(width: min(self.demoLabel.frame.width + 6  , self.maxCellWidth + 6 ), height: 25)

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
    
}


protocol GenerationCollectionViewCellDelegate {
    func generationCollectionView(collectionviewcell: GenerationCell?, index: Int, didTappedInTableViewCell: GenerationTableCell)
}
