//
//  CarAndListingFilter.swift
//  CarBois
//
//  Created by Umer Yasin on 05/09/2022.
//

import UIKit
import PUGifLoading

class CarAndListingFilter: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var filterTableView: UITableView!
    
    var rowFata = [String]()
    var arrayHeader = [Int]()
    
    var selected = [IndexPath]()
    var selectedRange = [rangeStruct]()
    
    var selectedFilters = [selectedFilterName]()
    
    var tableData = [dataModel]()
        
    private var modelAnalysisViewModel = ModelAnalysisViewModel()
    private var CarDetailViewModel = CarDetailVCViewModel()

    let loading = PUGIFLoading()
    
    
    @IBOutlet weak var applyFilterButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        addDataOnTable()
        filterTableView.delegate = self
        filterTableView.dataSource = self
        filterTableView.register(UINib(nibName: "TableHeader", bundle: nil), forCellReuseIdentifier: "TableHeader")
        filterTableView.register(UINib(nibName: "CustomView", bundle: nil), forCellReuseIdentifier: "CustomView")
        filterTableView.register(UINib(nibName: "priceRange", bundle: nil), forCellReuseIdentifier: "priceRange")
        filterTableView.register(UINib(nibName: "DropDownCell", bundle: nil), forCellReuseIdentifier: "DropDownCell")

        
        filterTableView.estimatedRowHeight = 0
        filterTableView.estimatedSectionHeaderHeight = 0
        filterTableView.estimatedSectionFooterHeight = 0
        filterTableView.rowHeight = UITableView.automaticDimension
        
        applyFilterButton.layer.shadowColor = UIColor.black.cgColor
        applyFilterButton.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        applyFilterButton.layer.shadowRadius = 4
        applyFilterButton.layer.shadowOpacity = 0.3
        applyFilterButton.layer.masksToBounds = false
        applyFilterButton.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 14)!
        
        filterTableView.delaysContentTouches = false
    }
    
    func addDataOnTable(){
        tableData.removeAll()
        rowFata.removeAll()
        arrayHeader.removeAll()
        
        if AppUtility.AverageGraphFilter != nil{
            
            rowFata.append("Sort")
            arrayHeader.append(1)
            tableData.append(dataModel(title: "Sort",key: "Sort",fieldType: "Sort",sort: AppUtility.AverageGraphFilter?.data?.sortBy,sortApplied: AppUtility.AverageGraphFilter?.data?.appliedSort))

            
            for (index2,item) in AppUtility.AverageGraphFilter!.data!.averageGraphFilters!.enumerated() {
                rowFata.append(item.title ?? "N/A")
                if item.fieldType == "RANGE" {
                    
                    if AppUtility.FilterApplied != nil {
                        if (AppUtility.FilterApplied!.contains(where: {$0.key == item.key})){
                            for item22 in AppUtility.FilterApplied ?? [] {
                                if item22.key == item.key {
                                    tableData.append(dataModel(title: item.title ?? "N/A",key: item.key ?? "N/A",fieldType: item.fieldType ?? "N/A",min: item22.min ?? 0, max: item22.max ?? 0, listOfValues:nil,orignalMin: item.min, orignalMax: item.max))
                                    let range = rangeStruct(key: item.key ?? "", min: item22.min ?? 0, max: item22.max ?? 0)
                                    selectedRange.append(range)
                                    arrayHeader.append(1)
                                }
                            }
    

                        }else{
                            tableData.append(dataModel(title: item.title ?? "N/A",key: item.key ?? "N/A",fieldType: item.fieldType ?? "N/A",min: item.min ?? 0, max: item.max ?? 0, listOfValues:nil,orignalMin: item.min ?? 0 , orignalMax: item.max ?? 0))
                            arrayHeader.append(0)
                        }
                       

                        
                    }else{
                        tableData.append(dataModel(title: item.title ?? "N/A",key: item.key ?? "N/A",fieldType: item.fieldType ?? "N/A",min: item.min ?? 0, max: item.max ?? 0, listOfValues:nil,orignalMin: item.min ?? 0 , orignalMax: item.max ?? 0))
                        arrayHeader.append(0)
                    }
                    
                    
                }else{
                    var filt = [modelList]()
                    var filterAppliedlist = [String]()
                    var openRow : Int = 0
                    //MARK: make single list of filters applied
                    for p in AppUtility.FilterApplied ?? []{
                        for xc in p.list ?? []{
                            filterAppliedlist.append(xc)
                        }
                    }
                    //MARK: making check which filter is applied.
                    for (index,item2) in item.listOfValues!.enumerated()  {
                        if filterAppliedlist.contains(where: {$0 == item2.name}){
                            filt.append(modelList(name: item2.name ?? "N/A", count: item2.count ?? 0,imgae: "filterSelect", isSelected: true))
                            openRow = 1
                            selected.append(IndexPath(row: index, section: index2))
                            let fil = selectedFilterName(key: item.key,name: [item2.name ?? "N/A"])
                            if let idx = selectedFilters.firstIndex(where: { $0.key == fil.key}) {
                                selectedFilters[idx].name?.append(item2.name ?? "N/A")
                            }else{
                                selectedFilters.append(selectedFilterName(key: item.key ,name: [item2.name ?? "N/A"]))
                            }
                        }else{
                            if item2.count ?? 0 > 0{
                                filt.append(modelList(name: item2.name ?? "N/A", count: item2.count ?? 0,imgae: "filterUnSelect", isSelected: false))
                            }
                        }
                    }
                    tableData.append(dataModel(title: item.title ?? "N/A",key: item.key ?? "N/A",fieldType: item.fieldType ?? "N/A",listOfValues: filt))
                    arrayHeader.append(openRow)
                    filt.removeAll()
                }
            }
        }else if AppUtility.HistoricGraphFilter != nil{
            
            rowFata.append("Sort")
            arrayHeader.append(1)
            tableData.append(dataModel(title: "Sort",key: "Sort",fieldType: "Sort",sort: AppUtility.HistoricGraphFilter?.data?.sortBy,sortApplied: AppUtility.HistoricGraphFilter?.data?.appliedSort))
            
            
            for (index2,item) in AppUtility.HistoricGraphFilter!.data!.historicGraphFilters!.enumerated()  {
                rowFata.append(item.title ?? "N/A")
                if item.fieldType == "RANGE" {
                    if AppUtility.FilterApplied != nil {
                        if AppUtility.FilterApplied!.contains(where: {$0.key == item.key}){
                            for item22 in AppUtility.FilterApplied ?? [] {
                                if item22.key == item.key {
                                    tableData.append(dataModel(title: item.title ?? "N/A",key: item.key ?? "N/A",fieldType: item.fieldType ?? "N/A",min: item22.min ?? 0, max: item22.max ?? 0, listOfValues:nil,orignalMin: item.min, orignalMax: item.max))
                                    let range = rangeStruct(key: item.key ?? "", min: item22.min ?? 0, max: item22.max ?? 0)
                                    selectedRange.append(range)
                                    arrayHeader.append(1)
                                }
                            }
                        }else{
                            tableData.append(dataModel(title: item.title ?? "N/A",key: item.key ?? "N/A",fieldType: item.fieldType ?? "N/A",min: item.min ?? 0, max: item.max ?? 0, listOfValues:nil,orignalMin: item.min ?? 0 , orignalMax: item.max ?? 0))
                            arrayHeader.append(0)
                        }
                    }else{
                        tableData.append(dataModel(title: item.title ?? "N/A",key: item.key ?? "N/A",fieldType: item.fieldType ?? "N/A",min: item.min ?? 0, max: item.max ?? 0, listOfValues:nil,orignalMin: item.min ?? 0 , orignalMax: item.max ?? 0))
                        arrayHeader.append(0)
                    }
                }else{
                    var filt = [modelList]()
                    var filterAppliedlist = [String]()
                    var openRow : Int = 0
                    //MARK: make single list of filters applied
                    for p in AppUtility.FilterApplied ?? []{
                        for xc in p.list ?? []{
                            filterAppliedlist.append(xc)
                        }
                    }
                    //MARK: making check which filter is applied.
                    for (index,item2) in item.listOfValues!.enumerated()  {
                        if filterAppliedlist.contains(where: {$0 == item2.name}){
                            filt.append(modelList(name: item2.name ?? "N/A", count: item2.count ?? 0,imgae: "filterSelect", isSelected: true))
                            openRow = 1
                            selected.append(IndexPath(row: index, section: index2))
                            let fil = selectedFilterName(key: item.key,name: [item2.name ?? "N/A"])
                            if let idx = selectedFilters.firstIndex(where: { $0.key == fil.key}) {
                                selectedFilters[idx].name?.append(item2.name ?? "N/A")
                            }else{
                                selectedFilters.append(selectedFilterName(key: item.key ,name: [item2.name ?? "N/A"]))
                            }
                        }else{
                            if item2.count ?? 0 > 0{
                                filt.append(modelList(name: item2.name ?? "N/A", count: item2.count ?? 0,imgae: "filterUnSelect", isSelected: false))
                            }
                            openRow = 0
                        }
                    }
                    tableData.append(dataModel(title: item.title ?? "N/A",key: item.key ?? "N/A",fieldType: item.fieldType ?? "N/A",listOfValues: filt))
                    arrayHeader.append(openRow)
                    filt.removeAll()
                }
            }
        }else if AppUtility.CarDetailFilter != nil{
            
            rowFata.append("Sort")
            arrayHeader.append(1)
            tableData.append(dataModel(title: "Sort",key: "Sort",fieldType: "Sort",sort: AppUtility.CarDetailFilter?.data?.sortBy,sortApplied: AppUtility.CarDetailFilter?.data?.appliedSort))
            
            
            for (index2,item) in AppUtility.CarDetailFilter!.data!.carDetailsFilters!.enumerated() {
                rowFata.append(item.title ?? "N/A")
                if item.fieldType == "RANGE" {
                    if AppUtility.FilterAppliedCarDetail != nil {
                        if AppUtility.FilterAppliedCarDetail!.contains(where: {$0.key == item.key}){
                            for item22 in AppUtility.FilterAppliedCarDetail ?? [] {
                                if item22.key == item.key {
                                    tableData.append(dataModel(title: item.title ?? "N/A",key: item.key ?? "N/A",fieldType: item.fieldType ?? "N/A",min: item22.min ?? 0, max: item22.max ?? 0, listOfValues:nil,orignalMin: item.min, orignalMax: item.max))
                                    let range = rangeStruct(key: item.key ?? "", min: item22.min ?? 0, max: item22.max ?? 0)
                                    selectedRange.append(range)
                                    arrayHeader.append(1)
                                }
                            }
                        }else{
                            tableData.append(dataModel(title: item.title ?? "N/A",key: item.key ?? "N/A",fieldType: item.fieldType ?? "N/A",min: item.min ?? 0, max: item.max ?? 0, listOfValues:nil,orignalMin: item.min ?? 0 , orignalMax: item.max ?? 0))
                            arrayHeader.append(0)
                        }
                    }else{
                        tableData.append(dataModel(title: item.title ?? "N/A",key: item.key ?? "N/A",fieldType: item.fieldType ?? "N/A",min: item.min ?? 0, max: item.max ?? 0, listOfValues:nil,orignalMin: item.min ?? 0 , orignalMax: item.max ?? 0))
                        arrayHeader.append(0)
                    }
                }else{
                    var filt = [modelList]()
                    var filterAppliedlist = [String]()
                    var openRow : Int = 0
                    //MARK: make single list of filters applied
                    for p in AppUtility.FilterAppliedCarDetail ?? []{
                        for xc in p.list ?? []{
                            filterAppliedlist.append(xc)
                        }
                    }
                    //MARK: making check which filter is applied.
                    for (index,item2) in item.listOfValues!.enumerated()  {
                        if filterAppliedlist.contains(where: {$0 == item2.name}){
                            filt.append(modelList(name: item2.name ?? "N/A", count: item2.count ?? 0,imgae: "filterSelect", isSelected: true))
                            openRow = 1
                            selected.append(IndexPath(row: index, section: index2))
                            let fil = selectedFilterName(key: item.key,name: [item2.name ?? "N/A"])
                            if let idx = selectedFilters.firstIndex(where: { $0.key == fil.key}) {
                                selectedFilters[idx].name?.append(item2.name ?? "N/A")
                            }else{
                                selectedFilters.append(selectedFilterName(key: item.key ,name: [item2.name ?? "N/A"]))
                            }
                        }else{
                            if item2.count ?? 0 > 0{
                                filt.append(modelList(name: item2.name ?? "N/A", count: item2.count ?? 0,imgae: "filterUnSelect", isSelected: false))
                            }
                            openRow = 0
                        }
                    }
                    tableData.append(dataModel(title: item.title ?? "N/A",key: item.key ?? "N/A",fieldType: item.fieldType ?? "N/A",listOfValues: filt))
                    arrayHeader.append(openRow)
                    filt.removeAll()
                }
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 32, height: 25))
        let child = UINib(nibName: "Header", bundle: .main).instantiate(withOwner: nil, options: nil).first as! Header
        child.headerTitle.text = rowFata[section]
        if arrayHeader[section] == 0 {
            child.expandViewImage.image = UIImage(named: "expand")
        }else{
            child.expandViewImage.image = UIImage(named: "minus")
            
        }
       
        let button = UIButton(type: .custom)
        child.frame = viewHeader.bounds
        button.frame = child.bounds
        button.tag = section // Assign section tag to this button
        if section == 0 {
            child.expandViewImage.isHidden = true
        }else{
            button.addTarget(self, action: #selector(tapSection(sender:)), for: .touchUpInside)
        }
        child.addSubview(button)
        viewHeader.addSubview(child)
        return viewHeader
    }
    
    @objc func tapSection(sender: UIButton) {
        self.arrayHeader[sender.tag] = (self.arrayHeader[sender.tag] == 0) ? 1 : 0
        self.filterTableView.reloadSections([sender.tag], with: .none)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return rowFata.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        for view in tableView.subviews {
                   if view is UIScrollView {
                       (view as? UIScrollView)!.delaysContentTouches = false
                       break
                   }
               }
        return (self.arrayHeader[section] == 0) ? 0 : tableData[section].listOfValues?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableData[indexPath.section].fieldType == "Sort"{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownCell", for: indexPath) as! DropDownCell
            cell.dropDown.dataSource.removeAll()
            
            for(index,item) in tableData[indexPath.section].sort!.enumerated(){
                cell.dropDown.dataSource.append(item.value ?? "N/A")
                
                if item.value == tableData[indexPath.section].sortApplied{
                    cell.dropDown.selectRow(at: index)
                    AppUtility.SortApplied = item.value
                    cell.dropdownLabel.text = item.value
                }
            }
            
            if tableData[indexPath.section].sortApplied == ""{
                for(index,item) in tableData[indexPath.section].sort!.enumerated(){
                    if item.key == "auction_sale_date_desc" {
                        cell.dropDown.selectRow(at: index)
                        AppUtility.SortApplied = item.value
                        cell.dropdownLabel.text = item.value
                    }
                }
            }
            
            
            cell.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                cell.dropdownLabel.text = item
                AppUtility.SortApplied = item
                AppUtility.FilterAppliedFromList = true
              }
            cell.layoutSubviews()
            return cell

        }else if tableData[indexPath.section].listOfValues?.count ?? 0 > 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomView", for: indexPath) as! CustomView
            cell.selectionStyle = .none
            cell.filterImage.image = UIImage(named: (tableData[indexPath.section].listOfValues?[indexPath.row].imgae)!)
            cell.filterText.text = tableData[indexPath.section].listOfValues?[indexPath.row].name ?? "N/A"
            cell.selectedIndex = ((tableData[indexPath.section].listOfValues?[indexPath.row].isSelected) != nil)
            cell.filterNumber.text = String(tableData[indexPath.section].listOfValues?[indexPath.row].count ?? 0)
            if tableData[indexPath.section].listOfValues![indexPath.row].isSelected{
                cell.filterText.font = UIFont(name: "Inter-Bold", size: 14)
                cell.filterText.textColor = .black
                
            }else{
                cell.filterText.font = UIFont(name: "Inter-Regular", size: 14)
                cell.filterText.textColor = .lightGray
            }
            cell.layoutSubviews()
            return cell
            
        }else{
            if tableData[indexPath.section].fieldType != "VALUES"{
                let cell = tableView.dequeueReusableCell(withIdentifier: "priceRange", for: indexPath) as! priceRange
                
                cell.setRanges(minRange: Double(tableData[indexPath.section].min ?? 0), maxRange: Double(tableData[indexPath.section].max ?? 0), type: tableData[indexPath.section].key ?? "N/A",orignalMin: Double(tableData[indexPath.section].orignalMin ?? 0),orignalMax: Double(tableData[indexPath.section].orignalMax ?? 0))

                
                cell.sendMinMax = { [self] (type,min,max) in
                    let range = rangeStruct(key: type, min: min, max: max)

                    if selectedRange.contains(where: {$0.key == range.key}){
                        selectedRange.removeAll(where: {$0.key == range.key})
                        selectedRange.append(range)
                    }else{
                        selectedRange.removeAll(where: {$0.key == range.key})
                        selectedRange.append(range)
                    }
                    refreshFilterOnChangeSlider()

                }
                
               
                cell.selectionStyle = .none
                cell.layoutSubviews()
                return cell
            }
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableData[indexPath.section].listOfValues?.count ?? 0 > 0 {
            if let idx = selected.firstIndex(where: { $0 == indexPath }) {
                selected.remove(at: idx)
                let fil = selectedFilterName(key: tableData[indexPath.section].key,name: [tableData[indexPath.section].listOfValues![indexPath.row].name])
                                
                if let idx = selectedFilters.firstIndex(where: { $0.key == fil.key }) {
                    selectedFilters[idx].name?.removeAll(where: {$0 == fil.name?[0]})
                }
                tableData[indexPath.section].listOfValues![indexPath.row].imgae = "filterUnSelect"
                tableData[indexPath.section].listOfValues![indexPath.row].isSelected = false
            }else{
                selected.append(indexPath)
                let fil = selectedFilterName(key: tableData[indexPath.section].key,name: [tableData[indexPath.section].listOfValues![indexPath.row].name])
                if let idx = selectedFilters.firstIndex(where: { $0.key == fil.key}) {
                    selectedFilters[idx].name?.append(tableData[indexPath.section].listOfValues![indexPath.row].name)
                }else{
                    selectedFilters.append(selectedFilterName(key: tableData[indexPath.section].key,name: [tableData[indexPath.section].listOfValues![indexPath.row].name]))
                }
                tableData[indexPath.section].listOfValues![indexPath.row].imgae = "filterSelect"
                tableData[indexPath.section].listOfValues![indexPath.row].isSelected = true
            }
            
//            filterTableView.reloadRows(at: [indexPath], with: .none)
            filterTableView.reloadData()
            print(selected)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 16.0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableData[indexPath.section].listOfValues?.count ?? 0 > 0{
            return 30
        }else{
            return 60
        }
        
    }
    
    private func tableView(tableView: UITableView, animationForRowAtIndexPaths indexPaths: [NSIndexPath]) -> UITableView.RowAnimation {
        return .automatic
    }
    func tableView(tableView: UITableView, animationForRowInSections sections: Set<Int>) -> UITableView.RowAnimation {
        return .automatic
    }
    
    
    @IBAction func onClickApplyFilters(_ sender: Any) {
        var selectedFilterr = [filtersRequest]()
        AppUtility.FilterAppliedFromList = true
        
        for items in selectedFilters{
            let temp = filtersRequest(key: items.key ?? "N/A",list: items.name)
            selectedFilterr.append(temp)
        }
        for item in selectedRange {
            let temp = filtersRequest(key: item.key,min: item.min,max: item.max)
            if !selectedFilterr.contains(temp){
                selectedFilterr.append(temp)
            }
        }
        if AppUtility.CarDetailFilter != nil {
            AppUtility.FilterAppliedCarDetail = selectedFilterr

        }else{
            AppUtility.FilterApplied = selectedFilterr

        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func refreshFilterOnChangeSlider(){
        showLoader(loader: loading)
        var selectedFilterr = [filtersRequest]()
        AppUtility.FilterAppliedFromList = true
        
        for items in selectedFilters{
            let temp = filtersRequest(key: items.key ?? "N/A",list: items.name)
            selectedFilterr.append(temp)
        }
       
        for item in selectedRange {
            let temp = filtersRequest(key: item.key,min: item.min,max: item.max)
            if !selectedFilterr.contains(temp){
                selectedFilterr.append(temp)
            }
        }

//        AppUtility.FilterApplied = selectedFilterr
        if AppUtility.CarDetailFilter != nil {
            AppUtility.FilterAppliedCarDetail = selectedFilterr

        }else{
            AppUtility.FilterApplied = selectedFilterr

        }
        if AppUtility.CarDetailFilter != nil {
            var req = AppUtility.carDetailFilterBody
            if AppUtility.FilterApplied != nil {
                req?.filters = AppUtility.FilterApplied
            }
            req?.sortBy = AppUtility.SortApplied
            CarDetailViewModel.getFilterListing(requestModel: req!) { [self] (Result) in
                switch Result{
                case .success(let res):
                    print(res)
                    AppUtility.AverageGraphFilter = nil
                    AppUtility.HistoricGraphFilter = nil
                    AppUtility.CarDetailFilter = res
                    self.addDataOnTable()
                    self.filterTableView.reloadData()
                   hideLoader(loader: loading)
                case .failure(let error):
                    let err = CustomError(description: (error as? CustomError)?.description ?? "")
                    print(err)
                    self.hideLoader(loader: self.loading)
                    AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                    }
                }
            }
            
        }else if AppUtility.filterRequestBody != nil {
            
            var req = AverageGraphFilterListingRequestModel(carType: AppUtility.selectedCoditionValue ?? "used", carMakeId: AppUtility.selectedMakeValue ?? 0, carModelId: AppUtility.selectedModelValue ?? 0, tenure: AppUtility.Tenure?.rawValue ?? "one_year")
            if AppUtility.FilterApplied != nil {
                req.filters = AppUtility.FilterApplied
            }
            req.sortBy = AppUtility.SortApplied
            modelAnalysisViewModel.getAverageGraphFilterListing(requestModel: req) { [self] (result) in
                switch result{
                case .success(let resp):
                    AppUtility.AverageGraphFilter = resp
                    AppUtility.HistoricGraphFilter = nil
                    AppUtility.CarDetailFilter = nil
                    self.addDataOnTable()
                    self.filterTableView.reloadData()
                   hideLoader(loader: loading)
                case .failure(let error):
                    let err = CustomError(description: (error as? CustomError)?.description ?? "")
                    print(err)
                    AlertHelper.showAlertWithTitle(self, title: err.description ?? "", dismissButtonTitle: "OK") { () -> Void in

                    }
                   hideLoader(loader: loading)

                }
            }
            
            
        }else{
            var reqq = AppUtility.historicGraphRequestBody
            reqq?.tenure = AppUtility.Tenure?.rawValue ?? "one_year"
            if AppUtility.FilterAppliedCarDetail != nil {
                reqq?.filters = AppUtility.FilterAppliedCarDetail
            }
            reqq?.sortBy = AppUtility.SortApplied
            modelAnalysisViewModel.getHistoricGraphFilterListing(request: reqq!) { [self] (result) in
                switch result{
                case .success(let resp):
                    AppUtility.AverageGraphFilter = nil
                    AppUtility.HistoricGraphFilter = resp
                    AppUtility.CarDetailFilter = nil
                    self.addDataOnTable()
                    self.filterTableView.reloadData()
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
    }
    
}

struct selectedListingFilter{
    var key:String?
    var min:Int?
    var max:Int?
    var list:[String]?
    
    init(key: String? = nil, min: Int? = nil, max: Int? = nil, list: [String]? = nil) {
        self.key = key
        self.min = min
        self.max = max
        self.list = list
    }
}

struct selectedFilterName{
    var key:String?
    var name:[String]?
}

struct dataModel{
    
    var title:String?
    var key:String?
    var fieldType:String?
    var min:Int?
    var max:Int?
    
    var listOfValues:[modelList]?
    
    var filterName:String?
    var count:Int?
    
    var orignalMin:Int?
    var orignalMax:Int?
    
    var sort:[SortBy]?
    var sortApplied:String?
    
    init(title: String? = nil, key: String? = nil, fieldType: String? = nil, min: Int? = nil, max: Int? = nil, listOfValues: [modelList]? = nil, filterName: String? = nil, count: Int? = nil, orignalMin: Int? = nil ,orignalMax: Int? = nil,sort: [SortBy]? = nil,sortApplied:String? = nil) {
        self.title = title
        self.key = key
        self.fieldType = fieldType
        self.min = min
        self.max = max
        self.listOfValues = listOfValues
        self.filterName = filterName
        self.count = count
        self.orignalMin = orignalMin
        self.orignalMax = orignalMax
        self.sort = sort
        self.sortApplied = sortApplied
    }
    
    
    
}

struct modelList{
    var name:String
    var count:Int
    var imgae:String
    var isSelected:Bool
}

struct rangeStruct{
    var key:String
    var min:Int
    var max:Int
    
}



