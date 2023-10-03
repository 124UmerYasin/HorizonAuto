//
//  DetailSearchVC.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 09/02/2023.
//

import UIKit

class DetailSearchVC: UIViewController,UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var label: UILabel!
    var selectedValue:String?
    var selectedIndex:Int?
    var indexSelectedOfArr:Int?

    var data = [dataForDetailSearch]()
    var filteredData = [dataForDetailSearch]()

    var isSelected = false
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let detailSearchCell = UINib(nibName: "detailSearchCell", bundle: nil)
        self.searchTableView.register(detailSearchCell, forCellReuseIdentifier: "detailSearchCell")
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchBar.delegate = self
        selectedValue = nil
        isSelected = false
    }
    
    func addDataMake(carMake:[dataForDetailSearch],title:String){
        data = carMake
        filteredData = carMake
        label.text = title
        searchTableView.reloadData()
    }
    
    func addDataModel(carMake:[dataForDetailSearch],title:String){
        data = carMake
        filteredData = carMake
        label.text = title
        searchTableView.reloadData()
    }
    
    func addDataGeneration(carMake:[dataForDetailSearch],title:String){
        data = carMake
        filteredData = carMake
        label.text = title
        searchTableView.reloadData()
    }
    
    func addyears(carMake:[dataForDetailSearch],title:String){
        data = carMake
        filteredData = carMake
        label.text = title
        searchTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            filteredData  = data
            searchTableView.reloadData()
        }else{
            filteredData  = data.filter { $0.name.contains(searchText) }
            searchTableView.reloadData()
        }
       

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "detailSearchCell", for: indexPath) as? detailSearchCell {
                cell.nameLabel.text = filteredData[indexPath.row].name
                return cell
            }else{
                return UITableViewCell()
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedValue = filteredData[indexPath.row].name
        selectedIndex = filteredData[indexPath.row].id
        isSelected = true
        indexSelectedOfArr = indexPath.row
        
        self.dismiss(animated: true)
    }
    
}


struct dataForDetailSearch{
    var name:String
    var id:Int
    var index:Int
}
