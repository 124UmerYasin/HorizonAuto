//
//  TableViewDashBoardFilter.swift
//  CarBois
//
//  Created by Umer Yasin on 14/09/2022.
//

import Foundation
import UIKit


extension DashBoardFilter{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if tableData[indexPath.row].isSubGen{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "FilterScreenTableCells", for: indexPath) as! FilterScreenTableCells
//            cell.cellLabel.text = tableData[indexPath.row].CarSubGenerationName
//            cell.cellLabelPrice.text = "$ "+String(tableData[indexPath.row].CarSubGenerationPrice)
//            switch tableData[indexPath.row].CarSubGenerationdirection {
//            case .decrease:
//                cell.cellLabelPrice.textColor = .red
//            case .increase:
//                cell.cellLabelPrice.textColor = UIColor(named: "grapgGreen")
//            }
//            return cell
//        }else{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "trimsCellTableViewCell", for: indexPath) as! trimsCellTableViewCell
//            cell.cellLabel.text = tableData[indexPath.row].TrimDefinitionName
//            cell.cellLabelPrice.text = "$ "+String(tableData[indexPath.row].TrimDefinitionPrice)
//            switch tableData[indexPath.row].TrimDefinitiondirection {
//            case .decrease:
//                cell.cellLabelPrice.textColor = .red
//            case .increase:
//                cell.cellLabelPrice.textColor = UIColor(named: "grapgGreen")
//            }
//            return cell
//        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("i am deselected")
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let sr = tableView.indexPathsForSelectedRows {
            if sr.count == limit {
                let alertController = UIAlertController(title: "Oops", message:
                                                            "You are limited to \(limit) selections", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                }))
                self.present(alertController, animated: true, completion: nil)
                
                return nil
            }
        }
        
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("i am tapped.")
        
    }
    
}



