//
//  bidGraph.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 02/12/2022.
//

import UIKit
import Charts

class bidGraph: UICollectionViewCell,ChartViewDelegate, AxisValueFormatter {
    

    @IBOutlet weak var graphView: LineChartView!
    var is_live:Bool?

    var carDetailYValues : [ChartDataEntry] = []

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        graphView.delegate = self
    }

    override func layoutSubviews() {
        self.configureShadow(cornerRadius: 5)
        
    }
    
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 0
        return numberFormatter.string(from: NSNumber(value: Int(value) )) ?? "0"
    }
    
    
    //MARK: - get cardetail Graph Data
    func getCarDetailGraphData(carDetailGraphData:CarDetailGraphModel, id:Int,carModelName:String,is_Live:Bool){
       
        carDetailYValues.removeAll()
        is_live = is_Live
        for item in carDetailGraphData.data?.carDetailsGraphData?.graphData ?? [] {
            
            for temp in item.bid_array ?? []{
                
                if is_Live{
                    carDetailYValues.append(ChartDataEntry(x: Double(item.mileage ?? "0") ?? 0, y: Double(Double(item.max_bid ?? "0") ?? 0)))
                }else{
                    carDetailYValues.append(ChartDataEntry(x: Double(item.mileage ?? "0") ?? 0, y: Double(item.price ?? 0)))
                }
            }
            
            
        }
        
        setCarDetailGraph()
    }
    
    func setCarDetailGraph(){
        let set2 = LineChartDataSet(entries: carDetailYValues,label: "Milage")
        set2.drawCirclesEnabled = true
        set2.drawValuesEnabled = false
        set2.drawHorizontalHighlightIndicatorEnabled = false
        set2.drawVerticalHighlightIndicatorEnabled = false
        set2.setColor(UIColor(named: "blueDots")!)
        set2.lineWidth = 0
        set2.circleHoleColor = UIColor(named: "blueDots")!
        set2.setCircleColor(UIColor(named: "blueDots")!)
        set2.circleRadius = 4
        
        
        let data: LineChartData = [set2]

        graphView.data = data
        graphView.rightAxis.enabled = false
        graphView.xAxis.labelPosition = .bottom

        graphView.xAxis.labelFont = UIFont(name: "RobotoMono-Regular", size: 9)!
        graphView.xAxis.valueFormatter = self

        
        graphView.leftAxis.enabled = true
        graphView.leftAxis.drawAxisLineEnabled = true
        graphView.leftAxis.drawGridLinesEnabled = true
        graphView.leftAxis.valueFormatter = YAxisValueFormatter()
        graphView.leftAxis.labelFont = UIFont(name: "RobotoMono-Regular", size: 9)!

        graphView.dragEnabled = false
        graphView.setScaleEnabled(false)
        graphView.pinchZoomEnabled = false
        graphView.isUserInteractionEnabled = false
        graphView.legend.enabled = false
        graphView.drawMarkers = false
       
        graphView.drawGridBackgroundEnabled = true
        graphView.gridBackgroundColor = .white
        
        if carDetailYValues.count == 0 {
            graphView.clear()
        }
        
    }
}
