//
//  SellYourCarSearchVC.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 08/02/2023.
//

import UIKit
import FittedSheets
import PUGifLoading

class SellYourCarSearchVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tabkeView: UIView!
    var temp = "polo"
    
    var makeData = AppUtility.dashboardFilterData?.data?.carMake!
    var modelData = AppUtility.dashboardFilterData?.data?.carMake![AppUtility.selectedMake].models
    var generationData = AppUtility.dashboardFilterData?.data?.carMake![AppUtility.selectedMake].models![AppUtility.selectedModel].carGenerations

    var subGenerationData = [CarMakeModelSubGeneration]()
    var trimData = [CarMakeModelTrimDefinition]()
    
    var onCLickSubmit : ((String)->())?

    private var dashboardFilterViewModel = FilterVcViewModel()
    let loading = PUGIFLoading()

    
    var makeID:Int?
    var modelID:Int?
    var genID:Int?
    var subGenID:Int?
    var trimID:Int?
    
    var makeName:String?
    var modelName:String?
    var genName:String?
    var subGenName:String?
    var trimName:String?

    var isFromWhere : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

        if AppUtility.isfromBuy{
            if AppUtility.isfromHome {
                if AppUtility.selectedBuyFilterHome != nil{
                    makeID = AppUtility.selectedBuyFilterHome?.make
                    modelID = AppUtility.selectedBuyFilterHome?.model
                    genID = AppUtility.selectedBuyFilterHome?.gen
                    subGenID = AppUtility.selectedBuyFilterHome?.subgen
                    trimID = AppUtility.selectedBuyFilterHome?.trim
                    trimData.removeAll()
                }
            }else{
                if AppUtility.selectedBuyFilter  != nil{
                    makeID = AppUtility.selectedBuyFilter?.make
                    modelID = AppUtility.selectedBuyFilter?.model
                    genID = AppUtility.selectedBuyFilter?.gen
                    subGenID = AppUtility.selectedBuyFilter?.subgen
                    trimID = AppUtility.selectedBuyFilter?.trim
                    trimData.removeAll()
                }
            }
           
        }else{
            if AppUtility.isfromHome {
                if AppUtility.selectedSellFilterHome != nil{
                    makeID = AppUtility.selectedSellFilterHome?.make
                    modelID = AppUtility.selectedSellFilterHome?.model
                    genID = AppUtility.selectedSellFilterHome?.gen
                    subGenID = AppUtility.selectedSellFilterHome?.subgen
                    trimID = AppUtility.selectedSellFilterHome?.trim
                    trimData.removeAll()
                }
            }else{
                if AppUtility.selectedSellFilter != nil{
                    makeID = AppUtility.selectedSellFilter?.make
                    modelID = AppUtility.selectedSellFilter?.model
                    genID = AppUtility.selectedSellFilter?.gen
                    subGenID = AppUtility.selectedSellFilter?.subgen
                    trimID = AppUtility.selectedSellFilter?.trim
                    trimData.removeAll()

                }
            }
           
        }
       
        
        // Do any additional setup after loading the view.
        let SellMakeCell = UINib(nibName: "SellMakeCell", bundle: nil)
        self.tableView.register(SellMakeCell, forCellReuseIdentifier: "SellMakeCell")
        
        let SellModelCell = UINib(nibName: "SellModelCell", bundle: nil)
        self.tableView.register(SellModelCell, forCellReuseIdentifier: "SellModelCell")

        let SellYearCell = UINib(nibName: "SellYearCell", bundle: nil)
        self.tableView.register(SellYearCell, forCellReuseIdentifier: "SellYearCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
        
        tabkeView.dropShadow3()
        
        getMakeData()
        
    }
    
    func getMakeData(){
        showLoader(loader: loading)
        dashboardFilterViewModel.getCarMake(){ [self] (makeResult) in
            switch makeResult{
            case .success(let makeResult):
                print(makeResult)
                hideLoader(loader: loading)
                makeData = makeResult.data?.carMake
            case .failure(let error):
                hideLoader(loader: loading)
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in}
            
            }
        }
    }
    
    func getModelsData(){
        dashboardFilterViewModel.getCarModels(id: makeID ?? 3){ [self] (modelResult) in
            switch modelResult{
            case .success(let modelResult):
                print(modelResult)
                modelData = modelResult.data?.carModels
               
            case .failure(let error):
                hideLoader(loader: loading)
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in}
            }
        }

    }

    func getGenerationsData(){
        
         dashboardFilterViewModel.getCarGenerations(id: modelID ?? 1){ [self] (generationResult) in
             switch generationResult{
             case .success(let generationResult):
                 print(generationResult)
                 generationData = generationResult.data?.carGenerations
                                         
             case .failure(let error):
                 hideLoader(loader: loading)
                 let err = CustomError(description: (error as? CustomError)?.description ?? "")
                 print(err)
                 AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in}
             }
         }

    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SellYearCell", for: indexPath) as? SellYearCell {
                
                cell.updateData(labeltext: "Make", placeHolder: "Select Make")
                
                // get make data from API
                if(makeData == nil){
                    getMakeData()
                }else{
                    for item in makeData!{
                        if item.id == makeID {
                            
                            //                            modelData = item.models
                            //                            generationData = item.models![0].carGenerations
                            //                            SubgenerationData = item.models![0].carGenerations![0].carSubGenerations
                            makeID = item.id
                            makeName = item.make
                            getModelsData()
                            cell.field.text = item.make
                            tableView.reloadSections([1,2,3,4], with: .automatic)
                            
                        }
                    }
                }
                
                cell.onClickBtn = { [self] () in
                    presentSheetForMake(makeData: makeData!) { [self] make, id , selectedIndex in
                        cell.field.text = make
                        for item in makeData!{
                            if item.id == id {
                              
                                
                                makeID = id
                                makeName = make
                                getModelsData()
                                
//                                modelData = item.models
//                                generationData = item.models![0].carGenerations
//                                SubgenerationData = item.models![0].carGenerations![0].carSubGenerations
                                
                                
                                trimData.removeAll()
                                modelID = nil
                                genID = nil
                                subGenID = nil
                                trimID = nil
                                modelName = nil
                                genName = nil
                                subGenName = nil
                                trimName = nil
                                tableView.reloadSections([1,2,3,4], with: .automatic)
                                
                            }
                        }
                    }
                }
                
                return cell
            }else{
                return UITableViewCell()
            }
        }else if indexPath.section == 1 {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SellYearCell", for: indexPath) as? SellYearCell {
                
                cell.updateData(labeltext: "Model", placeHolder: "Select Model")
                
                if(modelData != nil){
                    for item in modelData!{
                        if item.id == modelID {
                            //                            generationData = item.carGenerations
                            //                            SubgenerationData = item.carGenerations![0].carSubGenerations
                            modelID = item.id
                            modelName = item.model
                            getGenerationsData()
                            
                            cell.field.text = item.model
                            tableView.reloadSections([2,3,4], with: .automatic)
                        }
                    }
                }
                
                cell.onClickBtn = { [self] () in
                    if makeID != nil {
                        presentSheetForModel(modelData: modelData!) { [self] model, id , selectedIndex in
                            cell.field.text = model
                            for item in modelData!{
                                if item.id == id {
                                    
                                    
//                                    generationData = item.carGenerations
//                                    SubgenerationData = item.carGenerations![0].carSubGenerations
                                    modelID = id
                                    modelName = model
                                    getGenerationsData()
                                    
                                    genID = nil
                                    subGenID = nil
                                    trimID = nil
                                    genName = nil
                                    subGenName = nil
                                    trimName = nil
                                    trimData.removeAll()
                                    
                                    tableView.reloadSections([2,3,4], with: .automatic)
                                    
                                }
                            }
                        }
                    }else{
                        AlertHelper.showAlertWithTitle(self, title: "Please choose Make first.", dismissButtonTitle: "OK") { () -> Void in}
                    }
                }
                
                return cell
            }else{
                return UITableViewCell()
            }
        }else if indexPath.section == 2{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SellYearCell", for: indexPath) as? SellYearCell {
                
                cell.updateData(labeltext: "Generation", placeHolder: "Select Generation")
                
                if(generationData != nil){
                    
                    for item in generationData!{
                        if item.id == genID {
                            cell.field.text = item.generation
                            genID = item.id
                            genName = item.generation
                            gettrimsAndPrices(generationId: genID!)
                            tableView.reloadSections([3,4], with: .automatic)
                            
                        }
                    }
                }
                
                cell.onClickBtn = { [self] () in
                    if makeID != nil {
                        if modelID != nil {
                            presentSheetForGeneration(makeData: generationData!) { [self] gen, id , selectedIndex in
                                cell.field.text = gen
                                for item in generationData!{
                                    if item.id == id {
//                                        SubgenerationData = item.carSubGenerations
                                        genID = id
                                        genName = gen
                                        
                                        gettrimsAndPrices(generationId: id)
                                        
                                        subGenID = nil
                                        trimID = nil
                                        subGenName = nil
                                        trimName = nil
                                        trimData.removeAll()
                                        tableView.reloadSections([3,4], with: .automatic)
                                        
                                    }
                                }
                            }
                        }else{
                            AlertHelper.showAlertWithTitle(self, title: "Please choose Model first.", dismissButtonTitle: "OK") { () -> Void in}
                        }
                    }else{
                        AlertHelper.showAlertWithTitle(self, title: "Please choose Make first.", dismissButtonTitle: "OK") { () -> Void in}
                    }
                    
                }
                
                return cell
            }else{
                return UITableViewCell()
            }
        }else if indexPath.section == 3{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SellYearCell", for: indexPath) as? SellYearCell {
                cell.updateData(labeltext: "Sub Generation", placeHolder: "Select Sub Generation")
                
                if(!subGenerationData.isEmpty){
                    for item in subGenerationData{
                        if item.id == subGenID {
                            cell.field.text = item.subGeneration
                            subGenID = item.id
                            subGenName = item.subGeneration
                            trimData = item.trimDefinition!
                            tableView.reloadSections([4], with: .automatic)
                            break
                            
                        }
                    }
                }
                
                cell.onClickBtn = { [self] () in
                    if makeID != nil {
                        if modelID != nil {
                            if genID != nil {
                                presentSheetForSubGeneration(makeData: subGenerationData) { [self] subgen, id , selectedIndex in
                                    cell.field.text = subgen
                                    subGenID = id
                                    subGenName = subgen
                                    trimData.removeAll()

                                    for item in subGenerationData{
                                        if item.id == subGenID {
                                            trimData = item.trimDefinition!
                                            break
                                        }
                                    }

                                    trimID = nil
                                    trimName = nil

                                    tableView.reloadSections([4], with: .automatic)

                                }
                            }else{
                                AlertHelper.showAlertWithTitle(self, title: "Please choose Generation first.", dismissButtonTitle: "OK") { () -> Void in}
                            }
                        }else{
                            AlertHelper.showAlertWithTitle(self, title: "Please choose Model first.", dismissButtonTitle: "OK") { () -> Void in}
                        }
                    }else{
                        AlertHelper.showAlertWithTitle(self, title: "Please choose Make first.", dismissButtonTitle: "OK") { () -> Void in}
                    }
                 
                }
                return cell
            }else{
                return UITableViewCell()
            }
        }else if indexPath.section == 4{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SellYearCell", for: indexPath) as? SellYearCell {
                cell.updateData(labeltext: "Trims", placeHolder: "Select Trim")

                    if !trimData.isEmpty{
                        for item in trimData{
                            if item.id == trimID{
                                cell.field.text = item.carTrim
                                trimID = item.id
                                self.trimName = item.carTrim
                            }
                        }
                    }
                
                cell.onClickBtn = { [self] () in
                    if makeID != nil {
                        if modelID != nil {
                            if genID != nil {
                                if subGenID != nil {
                                    presentSheetTrims { [self] trimId,trimName in
                                        cell.field.text = trimName
                                        trimID = trimId
                                        self.trimName = trimName
                                    }
                                }else{
                                    AlertHelper.showAlertWithTitle(self, title: "Please choose SubGeneration first.", dismissButtonTitle: "OK") { () -> Void in}
                                }
                            }else{
                                AlertHelper.showAlertWithTitle(self, title: "Please choose Generation first.", dismissButtonTitle: "OK") { () -> Void in}
                            }
                        }else{
                            AlertHelper.showAlertWithTitle(self, title: "Please choose Model first.", dismissButtonTitle: "OK") { () -> Void in}
                        }
                    }else{
                        AlertHelper.showAlertWithTitle(self, title: "Please choose Make first.", dismissButtonTitle: "OK") { () -> Void in}
                    }
                    
                }
                
                return cell
            }else{
                return UITableViewCell()
            }
        }
        return UITableViewCell()

    }

    func presentSheetForModel(modelData:[Model],completion: @escaping (String,Int,Int) -> Void){

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
        for item in modelData {
            searchData.append(dataForDetailSearch(name: item.model ?? "N/A", id: item.id ?? -1, index: 0))
        }
        
        vc.addDataModel(carMake: searchData, title: "Choose Model")
        
        sheetController.didDismiss = { vc in
            let vc = vc.childViewController as! DetailSearchVC
            if vc.isSelected{
                completion(vc.selectedValue ?? "fa",vc.selectedIndex ?? -1,vc.indexSelectedOfArr ?? 0)
            }
        }
        
        self.present(sheetController, animated: true, completion: nil)
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
        
        self.present(sheetController, animated: true, completion: nil)
    }
    
    func presentSheetForGeneration(makeData:[CarGeneration],completion: @escaping (String,Int,Int) -> Void){

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
            searchData.append(dataForDetailSearch(name: item.generation ?? "N/A", id: item.id ?? -1, index: 0))
        }
        
        vc.addDataGeneration(carMake: searchData, title: "Choose Generation")
        
        sheetController.didDismiss = { vc in
            let vc = vc.childViewController as! DetailSearchVC
            if vc.isSelected{
                completion(vc.selectedValue ?? "fa",vc.selectedIndex ?? -1,vc.indexSelectedOfArr ?? 0)
            }
        }
        
        self.present(sheetController, animated: true, completion: nil)
    }
    
    func presentSheetForSubGeneration(makeData:[CarMakeModelSubGeneration],completion: @escaping (String,Int,Int) -> Void){

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
            searchData.append(dataForDetailSearch(name: item.subGeneration ?? "N/A", id: item.id ?? -1, index: 0))
        }
        
        vc.addDataGeneration(carMake: searchData, title: "Choose Generation")
        
        sheetController.didDismiss = { vc in
            let vc = vc.childViewController as! DetailSearchVC
            if vc.isSelected{
                completion(vc.selectedValue ?? "fa",vc.selectedIndex ?? -1,vc.indexSelectedOfArr ?? 0)
            }
        }
        
        self.present(sheetController, animated: true, completion: nil)
    }
   
    func presentSheetTrims(completion: @escaping (Int,String) -> Void){

        
        let controller = UIStoryboard(name: "SellYourCar", bundle: nil).instantiateViewController(withIdentifier: "ChooseTrimVC")
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
        
        let vc = sheetController.childViewController as! ChooseTrimVC
        
        vc.addTrimData(trimData: trimData)
                
        sheetController.didDismiss = { vc in
            let vc = vc.childViewController as! ChooseTrimVC
            if vc.isSelected{
                completion(vc.trimId,vc.trimName)
            }
        }
        self.present(sheetController, animated: true, completion: nil)
    }
    
    
    func gettrimsAndPrices(generationId:Int){
        
        showLoader(loader: loading)

        dashboardFilterViewModel.getTrimRanges(id: genID ?? -1) { [self] (result) in
            switch result{
            case .success(let result):
                subGenerationData = result.data!.subGenerations!
               
//                for item in result.data!.subGenerations!{
//                    if item.id == subGenId {
//                        trimData = item.trimDefinition!
//                        tableView.reloadSections([4], with: .automatic)
//                    }
//                }
                hideLoader(loader: loading)
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                }
                hideLoader(loader: loading)
            }
        }
    }
    
    @IBAction func onClickSubmitBtn(_ sender: Any) {
        
        if isFromWhere{
            
            if makeID != nil {
                if modelID != nil {
                    onCLickSubmit?(temp)
                    if AppUtility.isfromBuy{
                        if AppUtility.isfromHome {
                            AppUtility.selectedBuyFilterHome = searchSelection(make: makeID ?? -1, model: modelID ?? -1, gen: genID ?? -1, subgen: subGenID ?? -1, trim: trimID ?? -1)
                        }else{
                            AppUtility.selectedBuyFilter = searchSelection(make: makeID ?? -1, model: modelID ?? -1, gen: genID ?? -1, subgen: subGenID ?? -1, trim: trimID ?? -1)
                        }
                    }else{
                        if AppUtility.isfromHome {
                            AppUtility.selectedSellFilterHome = searchSelection(make: makeID ?? -1, model: modelID ?? -1, gen: genID ?? -1, subgen: subGenID ?? -1, trim: trimID ?? -1)
                        }else{
                            AppUtility.selectedSellFilter = searchSelection(make: makeID ?? -1, model: modelID ?? -1, gen: genID ?? -1, subgen: subGenID ?? -1, trim: trimID ?? -1)

                        }

                    }
                    dismiss(animated: true)
                }else{
                    AlertHelper.showAlertWithTitle(self, title: "Please choose Model first.", dismissButtonTitle: "OK") { () -> Void in}
                }
            }else{
                AlertHelper.showAlertWithTitle(self, title: "Please choose Make first.", dismissButtonTitle: "OK") { () -> Void in}
            }
            
//            if makeID != nil && modelID != nil {
//
//            }else{
//                AlertHelper.showAlertWithTitle(self, title: "Please choose all fields.", dismissButtonTitle: "OK") { () -> Void in
//
//                }
//            }
        }else{
            if makeID != nil {
                if modelID != nil {
                    if genID != nil {
                        if subGenID != nil {
                            if trimID != nil {
                                onCLickSubmit?(temp)
                                if AppUtility.isfromBuy{
                                    if AppUtility.isfromHome {
                                        AppUtility.selectedBuyFilterHome = searchSelection(make: makeID ?? -1, model: modelID ?? -1, gen: genID ?? -1, subgen: subGenID ?? -1, trim: trimID ?? -1)
                                    }else{
                                        AppUtility.selectedBuyFilter = searchSelection(make: makeID ?? -1, model: modelID ?? -1, gen: genID ?? -1, subgen: subGenID ?? -1, trim: trimID ?? -1)
                                    }
                                }else{
                                    if AppUtility.isfromHome {
                                        AppUtility.selectedSellFilterHome = searchSelection(make: makeID ?? -1, model: modelID ?? -1, gen: genID ?? -1, subgen: subGenID ?? -1, trim: trimID ?? -1)
                                    }else{
                                        AppUtility.selectedSellFilter = searchSelection(make: makeID ?? -1, model: modelID ?? -1, gen: genID ?? -1, subgen: subGenID ?? -1, trim: trimID ?? -1)

                                    }

                                }
                                dismiss(animated: true)
                            }else{
                                AlertHelper.showAlertWithTitle(self, title: "Please choose Trim first.", dismissButtonTitle: "OK") { () -> Void in}
                            }
                        }else{
                            AlertHelper.showAlertWithTitle(self, title: "Please choose SubGeneration first.", dismissButtonTitle: "OK") { () -> Void in}
                        }
                    }else{
                        AlertHelper.showAlertWithTitle(self, title: "Please choose Generation first.", dismissButtonTitle: "OK") { () -> Void in}
                    }
                }else{
                    AlertHelper.showAlertWithTitle(self, title: "Please choose Model first.", dismissButtonTitle: "OK") { () -> Void in}
                }
            }else{
                AlertHelper.showAlertWithTitle(self, title: "Please choose Make first.", dismissButtonTitle: "OK") { () -> Void in}
            }
//            if makeID != nil && modelID != nil && genID != nil && subGenID != nil && trimID != nil{
//
//            }else{
//                AlertHelper.showAlertWithTitle(self, title: "Please choose all fields.", dismissButtonTitle: "OK") { () -> Void in
//
//                }
//            }
        }
    }
}
