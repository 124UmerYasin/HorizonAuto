//
//  FilterVc.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 21/09/2022.
//

import UIKit
import PUGifLoading


class FilterVc: UIViewController,UITableViewDataSource,UITableViewDelegate,ConditionCollectionViewCellDelegate,MakeCollectionViewCellDelegate,ModelCollectionViewCellDelegate,GenerationCollectionViewCellDelegate,trimAndSubGenCollectionViewCellDelegate,showMessage{
    
    @IBOutlet weak var ApplyFilterButton: UIButton!
    let loading = PUGIFLoading()
    
    @IBOutlet weak var filterTableView: UITableView!
    
    private var dashboardFilterViewModel = FilterVcViewModel()
    
    
    var conditionData = ["all","new","used"]
    var makeData = AppUtility.dashboardFilterData?.data?.carMake
    var modelData = AppUtility.dashboardFilterData?.data?.carMake?[AppUtility.selectedMake].models
    var generationData = AppUtility.dashboardFilterData?.data?.carMake?[AppUtility.selectedMake].models?[AppUtility.selectedModel].carGenerations
//     var generationData  : [CarGeneration]? = [CarGeneration]()

    var tableData : [dashboardfilteratabledataModel] = [dashboardfilteratabledataModel]()
    
    
    var selectedCodition = 2
    var selectedMake = 0
    var selectedModel = 0
    var selectedGeneration = 0
    var seletedTableIndex = [dashboardfilteratabledataModel]()
    
    var limit:Int = 2
    let nc = NotificationCenter.default

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let conditionNib = UINib(nibName: "ConditionCell", bundle: nil)
        let makeNib = UINib(nibName: "MakeCell", bundle: nil)
        let modelNib = UINib(nibName: "ModelCell", bundle: nil)
        let generationNib = UINib(nibName: "GenerationTableCell", bundle: nil)
        let trimCellNibs = UINib(nibName: "TrimAndSubGenCell", bundle: nil)
        
        
        self.filterTableView.register(conditionNib, forCellReuseIdentifier: "ConditionCell")
        self.filterTableView.register(makeNib, forCellReuseIdentifier: "MakeCell")
        self.filterTableView.register(modelNib, forCellReuseIdentifier: "ModelCell")
        self.filterTableView.register(generationNib, forCellReuseIdentifier: "GenerationTableCell")
        self.filterTableView.register(trimCellNibs, forCellReuseIdentifier: "TrimAndSubGenCell")
        
        
        filterTableView.delegate = self
        filterTableView.dataSource = self
        filterTableView.rowHeight = UITableView.automaticDimension
        filterTableView.estimatedRowHeight = 800
        generationData?.insert(CarGeneration(id: 122, generation: "All", carSubGenerations: [CarSubGeneration]()), at: 0)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppUtility.canNavigateFromDashboardFilter = false
        
        selectedMake = AppUtility.selectedMake
        modelData = (AppUtility.dashboardFilterData?.data?.carMake?[selectedMake].models)!
        
        selectedModel = AppUtility.selectedModel
        generationData = (AppUtility.dashboardFilterData?.data?.carMake?[selectedMake].models![selectedModel].carGenerations)!
        
        generationData?.insert(CarGeneration(id: 122, generation: "All", carSubGenerations: [CarSubGeneration]()), at: 0)
        selectedGeneration = AppUtility.selectedGeneration
//        filterTableView.reloadSections([2,3,4], with: .automatic)
        
        makeDataSelected()
        ApplyFilterButton.layer.shadowColor = UIColor.black.cgColor
        ApplyFilterButton.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        ApplyFilterButton.layer.shadowRadius = 4
        ApplyFilterButton.layer.shadowOpacity = 0.3
        ApplyFilterButton.layer.masksToBounds = false
        ApplyFilterButton.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 12)!
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 4 {
            if selectedGeneration != 0 {
                return 1
            }else{
                return 1
            }
        }else{
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ConditionCell", for: indexPath) as? ConditionCell {
                cell.cellDelegate = self
                cell.makeCellHighlight(row: 0, section: 0)
                return cell
            }
        }else if indexPath.section == 1{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MakeCell", for: indexPath) as? MakeCell {
                cell.updateCellWith(carMake: makeData ?? [CarMake]())
                cell.cellDelegate = self
                cell.ccd = self
                return cell
            }
        }else if indexPath.section == 2{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ModelCell", for: indexPath) as? ModelCell {
                cell.updateCellWith(carModel: modelData ?? [Model]())
                cell.cellDelegate = self
                cell.ccd = self
                return cell
            }
        }else if indexPath.section == 3{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "GenerationTableCell", for: indexPath) as? GenerationTableCell {
                cell.updateCellWith(carGeneration: generationData ?? [CarGeneration]())
                cell.cellDelegate = self
                return cell
            }
        }else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "TrimAndSubGenCell", for: indexPath) as? TrimAndSubGenCell {
                cell.updateCellWith(tableData: tableData)
                cell.cellDelegate = self
                cell.messageDelegate = self
                return cell
            }
        }
        
        return UITableViewCell()
    }

    
    
    func conditionCollectionView(collectionviewcell: FilterCells?, index: Int, didTappedInTableViewCell: ConditionCell) {
        selectedCodition = index
    }
    
    func makeDataSelected(){
//        selectedMake = AppUtility.selectedMake
//        modelData = (AppUtility.dashboardFilterData?.data?.carMake?[selectedMake].models)!
//
//        selectedModel = AppUtility.selectedModel
//        generationData = (AppUtility.dashboardFilterData?.data?.carMake?[selectedMake].models![selectedModel].carGenerations)!
//        generationData?.insert(CarGeneration(id: 122, generation: "All", carSubGenerations: [CarSubGeneration]()), at: 0)
//        selectedGeneration = AppUtility.selectedGeneration
//        filterTableView.reloadSections([2,3,4], with: .automatic)
        getDataForTable(id: selectedGeneration)
        
    }
    
    func makeCollectionView(collectionviewcell: FilterCells?, index: Int, didTappedInTableViewCell: MakeCell) {
        AppUtility.seletedTableIndex.removeAll()
        selectedMake = index
        AppUtility.selectedModel = 0
        AppUtility.selectedGeneration = 0
        selectedModel = 0
        selectedGeneration = 0
        getDataForTable(id: selectedGeneration) // to default select All for generations
        
        filterTableView.reloadSections([2,3,4], with: .automatic)
        // call API's to get the relative models
        
        let makeId = AppUtility.dashboardFilterData?.data?.carMake?[selectedMake].id
        
        showLoader(loader: loading)

        dashboardFilterViewModel.getCarModels(id: makeId ?? 3){ [self] (modelResult) in
            switch modelResult{
            case .success(let modelResult):
                print(modelResult)
                AppUtility.dashboardFilterData?.data?.carMake?[selectedMake].models = modelResult.data?.carModels
                // call generations API
                modelData = modelResult.data?.carModels
                
                let modelId = modelResult.data?.carModels?[0].id
                
                dashboardFilterViewModel.getCarGenerations(id: modelId ?? 1){ [self] (generationResult) in
                    switch generationResult{
                    case .success(let generationResult):
                        print(generationResult)
                        AppUtility.dashboardFilterData?.data?.carMake?[selectedMake].models?[0].carGenerations = generationResult.data?.carGenerations
                        generationData = generationResult.data?.carGenerations
                        generationData?.insert(CarGeneration(id: 122, generation: "All", carSubGenerations: [CarSubGeneration]()), at: 0)
                        hideLoader(loader: loading)
                        filterTableView.reloadSections([2,3,4], with: .automatic)
                        
                    case .failure(let error):
                        hideLoader(loader: loading)
                        let err = CustomError(description: (error as? CustomError)?.description ?? "")
                        print(err)
                        AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in}
                    }
                }

                
            case .failure(let error):
                hideLoader(loader: loading)
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in}
            }
        }
        
        
//        modelData = (AppUtility.dashboardFilterData?.data?.carMake?[selectedMake].models)!
        
//        selectedModel = 0
//        generationData = (AppUtility.dashboardFilterData?.data?.carMake?[selectedMake].models![selectedModel].carGenerations)!
//        generationData?.insert(CarGeneration(id: 122, generation: "All", carSubGenerations: [CarSubGeneration]()), at: 0)
//
//
//        //-----
//        selectedGeneration = 0
//        getDataForTable(id: selectedGeneration)
//
//        filterTableView.reloadSections([2,3,4], with: .automatic)
    }
    
    func modelCollectionView(collectionviewcell: FilterCells?, index: Int, didTappedInTableViewCell: ModelCell) {
        AppUtility.selectedGeneration = 0
        AppUtility.seletedTableIndex.removeAll()
        selectedGeneration = 0
        selectedModel = index
        getDataForTable(id: selectedGeneration) // to default select All for generations

        let modelId = modelData?[index].id
        
        showLoader(loader: loading)
        dashboardFilterViewModel.getCarGenerations(id: modelId ?? 1){ [self] (generationResult) in
            switch generationResult{
            case .success(let generationResult):
                print(generationResult)
                AppUtility.dashboardFilterData?.data?.carMake?[selectedMake].models?[selectedModel].carGenerations = generationResult.data?.carGenerations
                generationData = generationResult.data?.carGenerations
                generationData?.insert(CarGeneration(id: 122, generation: "All", carSubGenerations: [CarSubGeneration]()), at: 0)
                hideLoader(loader: loading)
                filterTableView.reloadSections([3,4], with: .automatic)
                
            case .failure(let error):
                hideLoader(loader: loading)
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in}
            }
        }
        
//        generationData = (AppUtility.dashboardFilterData?.data?.carMake?[selectedMake].models![selectedModel].carGenerations)!
//        generationData?.insert(CarGeneration(id: 122, generation: "All", carSubGenerations: [CarSubGeneration]()), at: 0)
//        filterTableView.reloadSections([3,4], with: .automatic)
//        tableData.removeAll()
//        filterTableView.reloadSections([4], with: .automatic)

        
    }
    
    func generationCollectionView(collectionviewcell: GenerationCell?, index: Int, didTappedInTableViewCell: GenerationTableCell) {
//        seletedTableIndex.removeAll()
//        AppUtility.seletedTableIndex.removeAll()
        selectedGeneration = index
        AppUtility.selectedGeneration = index
        nc.post(name: Notification.Name("trimSelected"), object: selectedGeneration)

//        filterTableView.reloadSections([4], with: .automatic)
        getDataForTable(id: selectedGeneration)
    }
    
    func trimAndSubGenCollection(collectionviewcell: trimsCellTableViewCell?, index: Int, didTappedInTableViewCell: TrimAndSubGenCell ) {
        if AppUtility.isColor{
            tableData[index].Color = "sliderLabel"
            AppUtility.seletedTableIndex.append(tableData[index])
            AppUtility.isColor = false
        }else{
            tableData[index].Color = "red"
            AppUtility.seletedTableIndex.append(tableData[index])
            AppUtility.isColor = true
        }
        nc.post(name: Notification.Name("trimSelected"), object: selectedGeneration)

    }
    
    func trimAndSubGenCollectionDeselect(collectionviewcell: trimsCellTableViewCell?, index: Int, didTappedInTableViewCell: TrimAndSubGenCell) {
        if let idx = AppUtility.seletedTableIndex.firstIndex(where: { $0.CarSubGenerationId == tableData[index].CarSubGenerationId && $0.TrimDefinitionId == tableData[index].TrimDefinitionId }) {
            if AppUtility.seletedTableIndex[idx].Color == "red" {
                AppUtility.isColor = false
                AppUtility.seletedTableIndex.remove(at: idx)
            }else if AppUtility.seletedTableIndex[idx].Color == "sliderLabel"{
                AppUtility.isColor  = true
                AppUtility.seletedTableIndex.remove(at: idx)
            }

        }
        nc.post(name: Notification.Name("trimSelected"), object: selectedGeneration)
    }
    
    func trimAndSubGenCollection(collectionviewcell: FilterScreenTableCells?, index: Int, didTappedInTableViewCell: TrimAndSubGenCell) {
        if AppUtility.isColor{
            tableData[index].Color = "sliderLabel"
            AppUtility.seletedTableIndex.append(tableData[index])
            AppUtility.isColor = false
        }else{
            tableData[index].Color = "red"
            AppUtility.seletedTableIndex.append(tableData[index])
            AppUtility.isColor = true
        }
        nc.post(name: Notification.Name("trimSelected"), object: selectedGeneration)

    }
    
    func trimAndSubGenCollectionDeselect(collectionviewcell: FilterScreenTableCells?, index: Int, didTappedInTableViewCell: TrimAndSubGenCell) {
        if let idx = AppUtility.seletedTableIndex.firstIndex(where: { $0.CarSubGenerationId == tableData[index].CarSubGenerationId && $0.TrimDefinitionId == tableData[index].TrimDefinitionId }) {
            if AppUtility.seletedTableIndex[idx].Color == "red" {
                AppUtility.isColor = false
                AppUtility.seletedTableIndex.remove(at: idx)
            }else if AppUtility.seletedTableIndex[idx].Color == "sliderLabel"{
                AppUtility.isColor  = true
                AppUtility.seletedTableIndex.remove(at: idx)
            }
        }
        nc.post(name: Notification.Name("trimSelected"), object: selectedGeneration)

    }
    
    
    //MARK: - get data For tableView (subgen and trims)
    func getDataForTable(id:Int){
        
        showLoader(loader: loading)
       
        if selectedGeneration == 0 {
            AppUtility.seletedTableIndex.removeAll()
            tableData.removeAll()
            filterTableView.reloadSections([4], with: .automatic)
            hideLoader(loader: loading)
        }else{
            tableData.removeAll()
            dashboardFilterViewModel.getTrimRanges(id: generationData![selectedGeneration].id!) { [self] (result) in
                switch result{
                case .success(let result):
                    let subGen = result.data
                    if subGen != nil{
                        for (index,item) in subGen!.subGenerations!.enumerated() {
                            
                            tableData.append(dashboardfilteratabledataModel(gen:generationData![selectedGeneration].id!,carGenerationID:generationData![selectedGeneration].id!, CarSubGenerationId: item.id ?? -1 , CarSubGenerationName: item.subGeneration ?? "N/A", CarSubGenerationPrice: item.average ?? 0, CarSubGenerationdirection: item.direction ?? "N/A", TrimDefinitionId:  -1, TrimDefinitionName: item.subGeneration ?? "N/A", TrimDefinitionPrice: item.average ?? 0, TrimDefinitiondirection: item.direction ?? "N/A", isSubGen: true, Color: "clear", isSelected: false))
                            
                            for item3 in subGen!.subGenerations![index].trimDefinition ?? [] {
                                tableData.append(dashboardfilteratabledataModel(gen:generationData![selectedGeneration].id!,carGenerationID:generationData![selectedGeneration].id!,CarSubGenerationId: item.id ?? -1, CarSubGenerationName: item.subGeneration ?? "N/A", CarSubGenerationPrice: item.average ?? 0, CarSubGenerationdirection: item.direction ?? "N/A", TrimDefinitionId: item3.id ?? 0, TrimDefinitionName: item3.carTrim ?? "N/A", TrimDefinitionPrice: item3.average ?? 0, TrimDefinitiondirection: item3.direction ?? "N/A", isSubGen: false,Color: "clear",isSelected: false))
                            }
                        }
                    }
                   
                    filterTableView.reloadSections([4], with: .automatic)
                    hideLoader(loader: loading)
                case .failure(let error):
                    let err = CustomError(description: (error as? CustomError)?.description ?? "")
                    print(err)
                    AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                    }
                    filterTableView.reloadSections([4], with: .automatic)
                    hideLoader(loader: loading)
                }
            }
        }
        
       
        
    
    }
    
    @IBAction func onCLickApplyFilter(_ sender: Any) {
        AppUtility.FilterApplied = nil
        AppUtility.SortApplied = nil
        AppUtility.showAverage = true
        AppUtility.showIndividualListing = false
        AppUtility.canNavigateFromDashboardFilter = true
        AppUtility.filterRequestBody = nil
        AppUtility.averageGraphCarList = [AverageGraphCarListModelCurrentTenureCarsList]()
        AppUtility.Tenure = nil
        AppUtility.historicGraphRequestBody = nil
        AppUtility.multiHistoricGraphCarList = [MultiHistoricGraphDataModelDataPoint]()
        AppUtility.SelectedIndex = 3
        makeValuesRefresh()
        makeFilterString()
        print("\(selectedCodition) -- \(selectedMake) -- \(selectedModel) -- \(selectedGeneration) -- \(AppUtility.seletedTableIndex)")
        
        AppUtility.selectedCodition = selectedCodition
        AppUtility.selectedMake = selectedMake
        AppUtility.selectedModel = selectedModel
        AppUtility.selectedGeneration = selectedGeneration
        AppUtility.seletedTableIndex = AppUtility.seletedTableIndex
        
        AppUtility.filterAppliedFromCarDetailScreen = true
        
        AppUtility.SortApplied = nil
//        AppUtility.ToggleState = false
//        AppUtility.showCurrentHistoric = false
        showLoader(loader: loading)
        if AppUtility.seletedTableIndex.isEmpty {
            var request = averageGraphRequestModel(carType: conditionData[selectedCodition], carMakeId: makeData![selectedMake].id!, carModelId: modelData![selectedModel].id!, tenure: tenure.oneYear.rawValue)
            if AppUtility.showCurrentHistoric || AppUtility.ToggleState!{
                request.view_live_data = true
            }else{
                request.view_live_data = false
            }
            AppUtility.filterRequestBody = request
            AppUtility.selectedCoditionValue = conditionData[selectedCodition]
            AppUtility.selectedMakeValue = makeData![selectedMake].id!
            AppUtility.selectedModelValue = modelData![selectedModel].id!

            if request.view_live_data! {
                
                let genAndTrim = sub_gens_and_trim_defs()
                let request = gethomecardetailGraphRequest(carModelId: request.carModelId , carMakeId: request.carMakeId, sub_gens_and_trim_defs: [sub_gens_and_trim_defs]())
                dashboardFilterViewModel.getHomeCarDetailgraph(requestModel: request) { [self] (result) in
                    switch result{
                    case .success(let result):
                        AppUtility.graphDataInLiveCase = result.data
                        AppUtility.graphData = AverageGraphDataModelDataClass(filtersApplied: nil, averageGraphData: nil)
                        modelPricingDataApi(check: false)
                    case .failure(let error):
                        let err = CustomError(description: (error as? CustomError)?.description ?? "")
                        print(err)
                        AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                        }
                        hideLoader(loader: loading)
                    }
                }

            }else{
                dashboardFilterViewModel.getGraphData(requestModel: request) { [self] (result) in
                    switch result{
                        
                    case .success(let result):
                        AppUtility.graphData = result.data
                        modelPricingDataApi(check: false)
                    case .failure(let error):
                        let err = CustomError(description: (error as? CustomError)?.description ?? "")
                        print(err)
                        AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                        }
                        hideLoader(loader: loading)
                    }
                }
            }
        }else{
            AppUtility.selectedCoditionValue = conditionData[selectedCodition]
            AppUtility.selectedMakeValue = makeData![selectedMake].id!
            AppUtility.selectedModelValue = modelData![selectedModel].id!
            var request2 = multiHistoricGraphRequestModel(tenure: tenure.oneYear.rawValue, cars: [car]())
            if AppUtility.showCurrentHistoric || AppUtility.ToggleState!{
                request2.view_live_data = true
            }else{
                request2.view_live_data = false
            }
            for item in AppUtility.seletedTableIndex {
                if item.isSubGen{
                    let mb = car(subGenerationId: item.CarSubGenerationId)
                    request2.cars.append(mb)
                }else{
                    let mb = car(subGenerationId: item.CarSubGenerationId, trimDefinitionId: item.TrimDefinitionId)
                    request2.cars.append(mb)
                }
            }
            AppUtility.historicGraphRequestBody = request2
            
            if request2.view_live_data!{
                
                var genAndTrim = [sub_gens_and_trim_defs]()
                
                for item in request2.cars{
                    genAndTrim.append(sub_gens_and_trim_defs(carSubGenerationId: item.subGenerationId ?? nil,trimDefinitionId: item.trimDefinitionId ?? nil))
                }
                                      
                let request = gethomecardetailGraphRequest(carModelId: makeData![selectedMake].id! , carMakeId: modelData![selectedModel].id!, sub_gens_and_trim_defs: genAndTrim)
                

                
                dashboardFilterViewModel.getHomeCarDetailgraph(requestModel: request) { [self] (result) in
                    switch result{
                    case .success(let result):
                        AppUtility.graphDataInLiveCase = result.data
                        AppUtility.graphData = nil
                        AppUtility.multiHistoricGraphData = MultiHistoricGraphDataModelHistoricGraphData(graphData: nil)

                        modelPricingDataApi(check: true)
                    case .failure(let error):
                        let err = CustomError(description: (error as? CustomError)?.description ?? "")
                        print(err)
                        AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                        }
                        hideLoader(loader: loading)
                    }
                }
                
                
            }else{
                dashboardFilterViewModel.getHistoricGraphData(requestModel: request2) { [self] (result) in
                    switch result{
                    case .success(let result):
                        AppUtility.multiHistoricGraphData = result.data?.historicGraphData
                        modelPricingDataApi(check: true)
                    case .failure(let error):
                        let err = CustomError(description: (error as? CustomError)?.description ?? "")
                        print(err)
                        AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                        }
                        hideLoader(loader: loading)
                    }
                }
            }
        }
    }
    
    func modelPricingDataApi(check:Bool){
        let request3 = ModelPricingDataRequest(carType: conditionData[selectedCodition], carMakeId: makeData?[selectedMake].id ?? 0, carModelId: modelData?[selectedModel].id ?? 0)
        dashboardFilterViewModel.getModelPricingData(requestModel: request3) { [self] (result) in
            switch result{
            case .success(let result):
                AppUtility.ModelPricingDataModel = result.data
                if check{
                    getHistoricCars()
                   
                }else{
                    var req = AverageGraphCarListRequest(carType: conditionData[selectedCodition], carMakeId: makeData![selectedMake].id!, carModelId: modelData![selectedModel].id!, tenure: tenure.oneYear.rawValue, limit: 20, offset: 0)
                    if AppUtility.showCurrentHistoric || AppUtility.ToggleState!{
                        req.view_live_data = true
                    }else{
                        req.view_live_data = false
                    }
                    if req.view_live_data!{
                        getLiveListingCars(req: req)
                    }else{
                        getAverageGraphCarList(request: req)
                    }
                }
              
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                }
                hideLoader(loader: loading)
            }
        }
    }
    
    func getHistoricCars(){
        var req = multiHistoriccarRequestModel(tenure: AppUtility.historicGraphRequestBody!.tenure, cars: AppUtility.historicGraphRequestBody!.cars, limit: 20, offset: 0, view_live_data: false)
        if AppUtility.showCurrentHistoric || AppUtility.ToggleState!{
            req.view_live_data = true
        }else{
            req.view_live_data = false
        }
        AppUtility.historiccarListModelreq = req
        
        if req.view_live_data{
            var genAndTrim = [sub_gens_and_trim_defs]()
            
            for item in req.cars{
                genAndTrim.append(sub_gens_and_trim_defs(carSubGenerationId: item.subGenerationId ?? nil,trimDefinitionId: item.trimDefinitionId ?? nil))
            }
                                  
            var request = gethomecardetailListinghRequest(carModelId: makeData![selectedMake].id! , carMakeId: modelData![selectedModel].id!, sub_gens_and_trim_defs: genAndTrim)
            request.pageLimit = 40
            request.pageOffset = 0
            
            dashboardFilterViewModel.getLiveListing(requestModel: request) { [self] (result) in
                switch result{
                case .success(let result):
                    AppUtility.carListInModelAnalysisInLiveCase = result.data?.listings ?? [WantToSaleListingModelListing]()
                    AppUtility.totalCarsAverage = result.data?.NumOfListings
                    AppUtility.averageGraphCarList = [AverageGraphCarListModelCurrentTenureCarsList]()
                    AppUtility.multiHistoricCarList = [MultiHistoricCarListingPaginatedArr]()
                  
                    hideLoader(loader: loading)
                    self.dismiss(animated: true)
                case .failure(let error):
                    let err = CustomError(description: (error as? CustomError)?.description ?? "")
                    print(err)
                    AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                    }
                }
            }
        }else{
            dashboardFilterViewModel.getHistoriccarList(requestModel: req) { [self] (result) in
                switch result{
                case .success(let result):
                    AppUtility.multiHistoricCarList = result.data?.matchingHistoricListings?.paginatedArr ?? []
                    AppUtility.toatalCarsHistoric = result.data?.matchingHistoricListings?.actualArrLength
                    hideLoader(loader: loading)
                    self.dismiss(animated: true)
                case .failure(let error):
                    let err = CustomError(description: (error as? CustomError)?.description ?? "")
                    AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                    }
                    hideLoader(loader: loading)
                }
            }
        }
    
    }
    
    func makeValuesRefresh(){
        AppUtility.graphData = nil
        AppUtility.multiHistoricGraphData = nil
        AppUtility.ModelPricingDataModel = nil
        AppUtility.generation = nil
        AppUtility.subGen = nil
        AppUtility.subTrims = nil
    }
    
    func makeFilterString(){
        
        print("\(selectedCodition) -- \(selectedMake) -- \(selectedModel) -- \(selectedGeneration) -- \(AppUtility.seletedTableIndex)")
        if !AppUtility.seletedTableIndex.isEmpty {
            AppUtility.generation = ""
            AppUtility.subTrims = ""
            AppUtility.subGen = ""
            AppUtility.generation = generationData?[selectedGeneration].generation ?? "N/A"
            AppUtility.Tenure = tenure.oneYear
            
            var carSubGen:Set<String> = []
            var carTrims:Set<String> = []
            
            for item in AppUtility.seletedTableIndex {
                if item.isSubGen{
                    carSubGen.insert("\(item.CarSubGenerationName)")
                }else{
                    carSubGen.insert("\(item.CarSubGenerationName)")
                    carTrims.insert("\(item.TrimDefinitionName)")
                }
            }
            
            let carTrimArray: [String] = Array(carTrims)
            let string = carTrimArray.map { String($0) }
                .joined(separator: ",")
            AppUtility.subTrims = string
            
            let carsubgenArray: [String] = Array(carSubGen)
            let string2 = carsubgenArray.map { String($0) }
                .joined(separator: ",")
            AppUtility.subGen = string2
            
            if AppUtility.subTrims == "" {
                AppUtility.subTrims = "All"
            }
            if AppUtility.subGen == "" {
                AppUtility.subGen = "All"
            }
        }else{
            AppUtility.generation = generationData?[selectedGeneration].generation ?? "N/A"
            AppUtility.subTrims = "All"
            AppUtility.subGen = "All"
            
        }
        
        
    }
    
    func getAverageGraphCarList(request:AverageGraphCarListRequest){
        AppUtility.averageGraphCarListRequest = request

        dashboardFilterViewModel.getAverageGraphCarList(requestModel: request) { [self] (result) in
            switch result{
            case .success(let result):
                AppUtility.averageGraphCarList = result.data?.averageGraphCarsList?.currentTenureCarsList ?? [AverageGraphCarListModelCurrentTenureCarsList]()
                AppUtility.totalCarsAverage = result.data?.averageGraphCarsList?.totalRecords
                hideLoader(loader: loading)
                self.dismiss(animated: true)
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                }
            }
        }
    }
    
    func getLiveListingCars(req:AverageGraphCarListRequest){
        
        let genAndTrim = sub_gens_and_trim_defs(carSubGenerationId: 1,trimDefinitionId:1)
        var request2 = gethomecardetailListinghRequest(carModelId: req.carModelId , carMakeId: req.carMakeId, sub_gens_and_trim_defs: [sub_gens_and_trim_defs]())
        request2.pageLimit = 40
        request2.pageOffset = 0
        
        dashboardFilterViewModel.getLiveListing(requestModel: request2) { [self] (result) in
            switch result{
            case .success(let result):
                AppUtility.carListInModelAnalysisInLiveCase = result.data?.listings ?? [WantToSaleListingModelListing]()
                AppUtility.totalCarsAverage = result.data?.NumOfListings
                AppUtility.averageGraphCarList = [AverageGraphCarListModelCurrentTenureCarsList]()

                hideLoader(loader: loading)
                self.dismiss(animated: true)
            case .failure(let error):
                let err = CustomError(description: (error as? CustomError)?.description ?? "")
                print(err)
                AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                }
            }
        }
    }
    
    func showErrorMessage(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}



struct averageGraphRequestModel : Codable{
    var carType:String
    var carMakeId:Int
    var carModelId:Int
    var tenure:String
    var filters:[filtersRequest]?
    var view_live_data:Bool?
    var sortBy:String?

}

struct historicGraphRequestModel : Codable{
    var subGenerationId:Int
    var tenure:String
    var trimDefinitionId:Int
}

struct dashboardfilteratabledataModel:Codable{
    
    var gen:Int?
    var carGenerationID:Int
    
    var CarSubGenerationId:Int
    var CarSubGenerationName:String
    var CarSubGenerationPrice:Int
    var CarSubGenerationdirection:String
    
    
    var TrimDefinitionId:Int
    var TrimDefinitionName:String
    var TrimDefinitionPrice:Int
    var TrimDefinitiondirection:String
    
    var isSubGen : Bool
    
    var Color:String
    var isSelected:Bool
    
}


struct multiHistoricGraphRequestModel : Codable{
    var tenure:String
    var cars:[car]
    var filters:[filtersRequest]?
    var view_live_data:Bool?
    var sortBy:String?


}
struct car : Codable {
    var subGenerationId:Int?
    var trimDefinitionId:Int?
}

struct ModelPricingDataRequest :Codable {
    var carType:String
    var carMakeId:Int
    var carModelId:Int
}

struct AverageGraphCarListRequest :Codable{
    var carType: String
    var carMakeId: Int
    var carModelId: Int
    var tenure: String
    var limit: Int
    var offset: Int
    var filters:[filtersRequest]?
    var view_live_data:Bool?
    var sortBy:String?

}

struct multiHistoriccarRequestModel : Codable{
    var tenure:String
    var cars:[car]
    var limit:Int
    var offset:Int
    var view_live_data:Bool
    var filters:[filtersRequest]?
    var sortBy:String?


}
