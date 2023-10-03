//
//  DashBoardFilter.swift
//  CarBois
//
//  Created by Umer Yasin on 26/08/2022.
//

import UIKit
import FittedSheets

class DashBoardFilter: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout ,UITableViewDataSource,UITableViewDelegate {
    
    
    
    @IBOutlet weak var conditionCollectionView: UICollectionView!
    @IBOutlet weak var conditionFlowlayout: UICollectionViewFlowLayout!
    @IBOutlet weak var modelCollectionView: UICollectionView!
    @IBOutlet weak var makeCollectionView: UICollectionView!
    @IBOutlet weak var generationCollectionView: UICollectionView!
    
    
    @IBOutlet weak var conditionCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var modelCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var makeCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var generationCollectionViewHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    
    private let demoLabel = UILabel()
    private let minCellSpacing: CGFloat = 0.0
    private var maxCellWidth: CGFloat! = 0.0
    
    var conditionData = ["All","New","Used"]
    var makeData = AppUtility.dashboardFilterData?.data?.carMake
    var modelData = AppUtility.dashboardFilterData?.data?.carMake![0].models
    var generationData = AppUtility.dashboardFilterData?.data?.carMake![0].models![0].carGenerations
    
    
    
    @IBOutlet weak var tableViewFilters: UITableView!
    
    
    var selectedCodition = 0
    var selectedMake = 0
    var selectedModel = 0
    var selectedGeneration = 0

    
        
    var tableData : [dashboardfilteratabledataModel] = [dashboardfilteratabledataModel]()

    var limit:Int = 2
    
    
     private var dashboardFilterViewModel = FilterVcViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sheetViewController!.handleScrollView(self.scrollView)
        
        
        self.maxCellWidth = UIScreen.main.bounds.width - (minCellSpacing * 2)
        let layout = FlowLayout()
        let layout1 = FlowLayout()
        let layout2 = FlowLayout()
        
        
        conditionCollectionView.register(UINib(nibName: "FilterCells", bundle: nil), forCellWithReuseIdentifier: "FilterCells")
        conditionCollectionView.dataSource = self
        conditionCollectionView.delegate = self
        conditionCollectionView.collectionViewLayout = layout
        
        modelCollectionView.register(UINib(nibName: "FilterCells", bundle: nil), forCellWithReuseIdentifier: "FilterCells")
        modelCollectionView.dataSource = self
        modelCollectionView.delegate = self
        modelCollectionView.collectionViewLayout = layout1
        
        makeCollectionView.register(UINib(nibName: "FilterCells", bundle: nil), forCellWithReuseIdentifier: "FilterCells")
        makeCollectionView.dataSource = self
        makeCollectionView.delegate = self
        makeCollectionView.collectionViewLayout = layout2
        
        
        generationCollectionView.register(UINib(nibName: "GenerationCell", bundle: nil), forCellWithReuseIdentifier: "GenerationCell")
        generationCollectionViewHeight.constant = 40
        generationCollectionView.dataSource = self
        generationCollectionView.delegate = self
        
        
        
        tableViewFilters.delegate = self
        tableViewFilters.dataSource = self
        tableViewFilters.estimatedRowHeight = 40
        tableViewFilters.rowHeight = UITableView.automaticDimension
        tableViewFilters.register(UINib(nibName: "trimsCellTableViewCell", bundle: nil), forCellReuseIdentifier: "trimsCellTableViewCell")
        tableViewFilters.register(UINib(nibName: "FilterScreenTableCells", bundle: nil), forCellReuseIdentifier: "FilterScreenTableCells")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let path = IndexPath(row: 0, section: 0)
        conditionCollectionView.selectItem(at: path, animated: true, scrollPosition: .bottom)
        conditionCollectionView.delegate?.collectionView?(conditionCollectionView, didSelectItemAt: path)
        
        makeCollectionView.selectItem(at: path, animated: true, scrollPosition: .bottom)
        makeCollectionView.delegate?.collectionView?(makeCollectionView, didSelectItemAt: path)
        
        modelCollectionView.selectItem(at: path, animated: true, scrollPosition: .bottom)
        modelCollectionView.delegate?.collectionView?(modelCollectionView, didSelectItemAt: path)
        
        generationCollectionView.selectItem(at: path, animated: true, scrollPosition: .bottom)
        generationCollectionView.delegate?.collectionView?(generationCollectionView, didSelectItemAt: path)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        conditionCollectionViewHeight.constant = self.conditionCollectionView.collectionViewLayout.collectionViewContentSize.height
        modelCollectionViewHeight.constant = self.modelCollectionView.collectionViewLayout.collectionViewContentSize.height
        makeCollectionViewHeight.constant = self.makeCollectionView.collectionViewLayout.collectionViewContentSize.height
        makeCollectionView.layoutIfNeeded()
        tableViewFilters.frame = CGRect(x: tableViewFilters.frame.origin.x, y: tableViewFilters.frame.origin.y, width: tableViewFilters.frame.size.width, height: tableViewFilters.contentSize.height)
        tableViewFilters.reloadData()
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == conditionCollectionView{
            return conditionData.count
        }else if collectionView == modelCollectionView{
            return modelData!.count
        }else if collectionView == makeCollectionView{
            return makeData!.count
        }else if collectionView == generationCollectionView{
            return generationData!.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == generationCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenerationCell", for: indexPath) as! GenerationCell
            cell.cellLabel.text = generationData![indexPath.row].generation
            let attributedString = NSMutableAttributedString.init(string: generationData![indexPath.row].generation!)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 2, range: NSRange.init(location: 0, length: attributedString.length))
            cell.cellLabel.attributedText = attributedString
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCells", for: indexPath) as! FilterCells
            if collectionView == conditionCollectionView{
                cell.cellLabel.text = conditionData[indexPath.row]
            }else if collectionView == modelCollectionView{
                cell.cellLabel.text = modelData![indexPath.row].model!.capitalizingFirstLetter()
            }else if collectionView == makeCollectionView{
                cell.cellLabel.text = makeData![indexPath.row].make!.capitalizingFirstLetter()
            }
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == conditionCollectionView {
            selectedCodition = indexPath.row
        }
        if collectionView == makeCollectionView {
            selectedMake = indexPath.row
            modelData = (AppUtility.dashboardFilterData?.data?.carMake?[selectedMake].models)!
            modelCollectionView.reloadData()
        }
        if collectionView == modelCollectionView {
            selectedModel = indexPath.row
            generationData = (AppUtility.dashboardFilterData?.data?.carMake?[selectedMake].models![selectedModel].carGenerations)!
            generationData?.insert(CarGeneration(id: 122, generation: "All", carSubGenerations: [CarSubGeneration]()), at: 0)
            
            generationCollectionView.reloadData()
            let path = IndexPath(row: 0, section: 0)
            generationCollectionView.selectItem(at: path, animated: true, scrollPosition: .bottom)
            generationCollectionView.delegate?.collectionView?(generationCollectionView, didSelectItemAt: path)
        }
        if collectionView == generationCollectionView {
            selectedGeneration = indexPath.row
            if selectedGeneration == 0 {
                tableViewFilters.isHidden = true
            }else{
                tableViewFilters.isHidden = false

            }
            self.generationCollectionView.scrollToItem(at:IndexPath(item: indexPath.row, section: indexPath.section), at: .left, animated: true)
            
            getTrimRanges(id: selectedGeneration)

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if collectionView == conditionCollectionView{
            self.demoLabel.text = conditionData[indexPath.row]
        }else if collectionView == modelCollectionView{
            self.demoLabel.text = modelData![indexPath.row].model!.capitalizingFirstLetter()
        }else if collectionView == makeCollectionView{
            self.demoLabel.text = makeData![indexPath.row].make!.capitalizingFirstLetter()
        }else if collectionView == generationCollectionView{
            self.demoLabel.text = generationData![indexPath.row].generation!.capitalizingFirstLetter()
        }
        self.demoLabel.sizeToFit()
        if collectionView == generationCollectionView {
            return CGSize(width: min(self.demoLabel.frame.width + 6, self.maxCellWidth + 6), height: 25)
        }else{
            return CGSize(width: min(self.demoLabel.frame.width + 16 + 12, self.maxCellWidth + 12), height: 30)
        }
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
    
    @IBAction func onClickApplyFilter(_ sender: Any) {
        print("\(selectedCodition) \(selectedMake)  \(selectedModel)  \(selectedGeneration)  11212")
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func getCarMakes(id:Int){
        
        dashboardFilterViewModel.getCarMake(){ [self] (result) in
            switch result{
            case .success(let result):
                print(result)
                makeData = result.data?.carMake
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                }
            }
        }
    }
    
    // get (subgen and trims)
    func getTrimRanges(id:Int){
        
        tableData.removeAll()
        dashboardFilterViewModel.getTrimRanges(id: generationData![selectedGeneration].id!) { [self] (result) in
            switch result{
            case .success(let result):
                print(result)
                let subGen = result.data
                for item in subGen!.subGenerations ?? [] {
                    
                    tableData.append(dashboardfilteratabledataModel(carGenerationID: generationData![selectedGeneration].id!, CarSubGenerationId: item.id!, CarSubGenerationName: item.subGeneration!, CarSubGenerationPrice: item.average!, CarSubGenerationdirection: item.direction!, TrimDefinitionId: item.id!, TrimDefinitionName: item.subGeneration!, TrimDefinitionPrice: item.average!, TrimDefinitiondirection: item.direction!, isSubGen: true,Color: "clear",isSelected: false))
                    
                    for item in subGen!.subGenerations![0].trimDefinition ?? [] {
                        tableData.append(dashboardfilteratabledataModel(carGenerationID: generationData![selectedGeneration].id!, CarSubGenerationId: item.id!, CarSubGenerationName: item.carTrim!, CarSubGenerationPrice: item.average!, CarSubGenerationdirection: item.direction!, TrimDefinitionId: item.id!, TrimDefinitionName: item.carTrim!, TrimDefinitionPrice: item.average!, TrimDefinitiondirection: item.direction!, isSubGen: false,Color: "clear",isSelected: false))
                    }
                }
                
                tableViewFilters.reloadData()

            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                }
            }
        }
    }
   
    
    
    
}


