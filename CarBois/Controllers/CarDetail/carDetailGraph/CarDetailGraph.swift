//
//  CarDetailGraph.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 01/11/2022.
//

import UIKit
import Charts
import SDWebImage

class CarDetailGraph: UICollectionViewCell,ChartViewDelegate, AxisValueFormatter {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var onClickAverage: UIButton!
    @IBOutlet weak var graphView: LineChartView!
    @IBOutlet weak var similarCarLabel: UILabel!
    
    @IBOutlet weak var avgButton: UIStackView!
    
    @IBOutlet weak var avgButtonWidth: NSLayoutConstraint!
    //for cardetail graph.
    var carDetailYValues : [ChartDataEntry] = []
    var carDetailYValues2 : [ChartDataEntry] = []

    var months : [String] = []
    var indexVal = 0.0
    
    var maxVal:Double?
    var minVal:Double?
    
    var price = 0
    var milage = 0
    var avragePrice = 0
    
    var is_live:Bool?
    var CarTapAction : ((Any)->())?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        graphView.delegate = self
        imageView.image = UIImage(named: "tick")
        let tap = UITapGestureRecognizer(target: self, action: #selector(stackViewTapped))
        avgButton.addGestureRecognizer(tap)
    }

    override func layoutSubviews() {
        self.configureShadow(cornerRadius: 5)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    
    @objc func stackViewTapped(){
        if imageView.image == UIImage(named: "tick"){
            imageView.image = UIImage(named: "uncheck")
            graphView.highlightValue(nil)
        }else{
            imageView.image = UIImage(named: "tick")
            graphView.highlightValues([Highlight(x: Double(carDetailYValues2[carDetailYValues2.count - 1].x), y: Double(carDetailYValues2[carDetailYValues2.count - 1].y), dataSetIndex: 0)])

        }
    }

    //MARK: - get Home cardetail Graph Data 
    func getHomeCarDetailGraphData(carDetailGraphData:HomeCarDetailGraphDataClass, id:Int,carModelName:String,is_Live:Bool){
        if is_Live{
            avgButtonWidth.constant = 0
        }else{
            avgButtonWidth.constant = 70

        }
        similarCarLabel.text = "Similar \(carModelName)"
        carDetailYValues.removeAll()
        months.removeAll()
        indexVal = 0.0
        is_live = is_Live
        for item in carDetailGraphData.firstDataSet ?? [] {
            if id == item.id{
                let img = resizedImage(at: UIImage(named: "cardetailGraph")!, for: CGSize(width: 15, height: 15))
                if is_Live{
                    carDetailYValues.append(ChartDataEntry(x: Double(item.car_mileage ?? 0), y: Double(Double(item.listing_price ?? 0)),icon: img,data: item.uuid  ))
                    indexVal = indexVal + 1
                }else{
                    carDetailYValues.append(ChartDataEntry(x: Double(item.car_mileage ?? 0), y: Double(item.listing_price ?? 0),icon: img ,data: item.uuid ))
                    indexVal = indexVal + 1
                }
                
            }else{
                if is_Live{
                    carDetailYValues.append(ChartDataEntry(x: Double(item.car_mileage ?? 0), y: Double(Double(item.listing_price ?? 0)),data: item.uuid ))
                    indexVal = indexVal + 1
                }else{
                    carDetailYValues.append(ChartDataEntry(x: Double(item.car_mileage ?? 0), y: Double(item.listing_price ?? 0),data: item.uuid ))
                    indexVal = indexVal + 1
                }
               
            }
            price = price + (item.listing_price ?? 0)
            milage = Int(item.car_mileage ?? 0)
        }
        if !is_Live{
            avragePrice = price/(carDetailGraphData.firstDataSet?.count ?? 1)
            carDetailYValues2.append(ChartDataEntry(x: Double(milage), y: Double(avragePrice)))
        }
        

        
        setCarDetailGraph()
    }
    
    //MARK: - get cardetail Graph Data
    func getCarDetailGraphData(carDetailGraphData:CarDetailGraphModel, id:Int,carModelName:String,is_Live:Bool){
        if is_Live{
            avgButtonWidth.constant = 0
        }else{
            avgButtonWidth.constant = 70

        }
        similarCarLabel.text = "Similar \(carModelName)"
        carDetailYValues.removeAll()
        months.removeAll()
        indexVal = 0.0
        is_live = is_Live
        for item in carDetailGraphData.data?.carDetailsGraphData?.graphData ?? [] {
            if id == item.id{
                let img = resizedImage(at: UIImage(named: "cardetailGraph")!, for: CGSize(width: 15, height: 15))
                if is_Live{
                    carDetailYValues.append(ChartDataEntry(x: Double(item.mileage ?? "0") ?? 0, y: Double(Double(item.max_bid ?? "0") ?? 0),icon: img,data: item.id  ))
                    indexVal = indexVal + 1
                }else{
                    carDetailYValues.append(ChartDataEntry(x: Double(item.mileage ?? "0") ?? 0, y: Double(item.price ?? 0),icon: img ,data: item.id ))
                    indexVal = indexVal + 1
                }
                
            }else{
                if is_Live{
                    carDetailYValues.append(ChartDataEntry(x: Double(item.mileage ?? "0") ?? 0, y: Double(Double(item.max_bid ?? "0") ?? 0),data: item.id ))
                    indexVal = indexVal + 1
                }else{
                    carDetailYValues.append(ChartDataEntry(x: Double(item.mileage ?? "0") ?? 0, y: Double(item.price ?? 0),data: item.id ))
                    indexVal = indexVal + 1
                }
               
            }
            price = price + (item.price ?? 0)
            milage = Int(item.mileage ?? "0") ?? 0
        }
        if !is_Live{
            avragePrice = price/(carDetailGraphData.data?.carDetailsGraphData?.graphData!.count ?? 1)
            carDetailYValues2.append(ChartDataEntry(x: Double(milage), y: Double(avragePrice)))
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
        
        let set22 = LineChartDataSet(entries: carDetailYValues2,label: "Milage")
        set22.drawCirclesEnabled = false
        set22.drawValuesEnabled = false
        set22.drawHorizontalHighlightIndicatorEnabled = true
        set22.drawVerticalHighlightIndicatorEnabled = false
        set22.setColor(UIColor(named: "blueDots")!)
        set22.lineWidth = 0
        set22.circleHoleColor = UIColor(named: "blueDots")!
        set22.setCircleColor(UIColor(named: "blueDots")!)
        set22.circleRadius = 10
        
        set22.highlightLineDashLengths = [8.0, 4.0]
        set22.highlightColor = UIColor(named: "blueDots")!
        set22.highlightLineWidth = 1.0
        
        let data: LineChartData = [set22,set2]

        graphView.data = data
        graphView.rightAxis.enabled = false
        
        graphView.extraRightOffset = 30
        
        graphView.xAxis.labelPosition = .bottom
        graphView.xAxis.drawLabelsEnabled = true
        graphView.xAxis.labelFont = UIFont(name: "RobotoMono-Regular", size: 9)!
        graphView.xAxis.valueFormatter = self
        graphView.xAxis.labelCount = 6
        graphView.xAxis.forceLabelsEnabled = true
        
        graphView.leftAxis.enabled = true
        graphView.leftAxis.drawAxisLineEnabled = true
        graphView.leftAxis.drawGridLinesEnabled = true
        graphView.leftAxis.valueFormatter = YAxisValueFormatter()
        graphView.leftAxis.labelFont = UIFont(name: "RobotoMono-Regular", size: 9)!
        graphView.leftAxis.labelCount = 6
        graphView.leftAxis.forceLabelsEnabled = true
        
        graphView.dragEnabled = false
        graphView.setScaleEnabled(false)
        graphView.pinchZoomEnabled = false
        graphView.isUserInteractionEnabled = true
        graphView.legend.enabled = false
        

        
        if is_live!{
            graphView.drawMarkers = false

        }else{
            let marker:BalloonMarker3 = BalloonMarker3(color: UIColor(named: "blueDots")!, font: UIFont(name: "RobotoMono-Regular", size: 9)!, textColor: UIColor.white, insets: UIEdgeInsets(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0))
            marker.chartView = graphView
            marker.minimumSize = CGSize(width: 40.0, height: 11.0)
            graphView.marker = marker
            graphView.drawMarkers = true
            
            if carDetailYValues.count != 0 && !carDetailYValues2.isEmpty {
                graphView.highlightValues([Highlight(x: Double(carDetailYValues2[carDetailYValues2.count - 1].x), y: Double(carDetailYValues2[carDetailYValues2.count - 1].y), dataSetIndex: 0)])
            }

        }
        
       
        graphView.drawGridBackgroundEnabled = true
        graphView.gridBackgroundColor = .white
        
        if carDetailYValues.count == 0 {
            graphView.clear()
        }
        
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 0
        return numberFormatter.string(from: NSNumber(value: Int(value) )) ?? "0"
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
//        chartView.highlightValue(highlight)
        let marker:BalloonMarker3 = BalloonMarker3(color: UIColor(named: "blueDots")!, font: UIFont(name: "RobotoMono-Regular", size: 9)!, textColor: UIColor.white, insets: UIEdgeInsets(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0))
        marker.chartView = graphView
        marker.minimumSize = CGSize(width: 40.0, height: 11.0)
        graphView.marker = marker
        graphView.drawMarkers = true
        
        if carDetailYValues.count != 0 && !carDetailYValues2.isEmpty {
            graphView.highlightValues([Highlight(x: Double(carDetailYValues2[carDetailYValues2.count - 1].x), y: Double(carDetailYValues2[carDetailYValues2.count - 1].y), dataSetIndex: 0)])
        }
        CarTapAction?(entry.data as Any)
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        let marker:BalloonMarker3 = BalloonMarker3(color: UIColor(named: "blueDots")!, font: UIFont(name: "RobotoMono-Regular", size: 9)!, textColor: UIColor.white, insets: UIEdgeInsets(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0))
        marker.chartView = graphView
        marker.minimumSize = CGSize(width: 40.0, height: 11.0)
        graphView.marker = marker
        graphView.drawMarkers = true
        
        if carDetailYValues.count != 0 && !carDetailYValues2.isEmpty {
            graphView.highlightValues([Highlight(x: Double(carDetailYValues2[carDetailYValues2.count - 1].x), y: Double(carDetailYValues2[carDetailYValues2.count - 1].y), dataSetIndex: 0)])
        }
    }
    
    @IBAction func graphClick(_ sender: Any) {
        if imageView.image == UIImage(named: "tick"){
            imageView.image = UIImage(named: "uncheck")
            graphView.highlightValue(nil)
        }else{
            imageView.image = UIImage(named: "tick")
            graphView.highlightValues([Highlight(x: Double(carDetailYValues2[carDetailYValues2.count - 1].x), y: Double(carDetailYValues2[carDetailYValues2.count - 1].y), dataSetIndex: 0)])

        }
    }
}
