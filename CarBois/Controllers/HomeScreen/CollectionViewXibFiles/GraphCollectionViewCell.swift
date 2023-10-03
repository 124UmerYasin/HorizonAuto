//
//  GraphCollectionViewCell.swift
//  CarBois
//
//  Created by Umer Yasin on 23/08/2022.
//

import UIKit
import Charts

class GraphCollectionViewCell: UICollectionViewCell,ChartViewDelegate, AxisValueFormatter {
    
    
    
    @IBOutlet weak var graphView: LineChartView!
    
    //For Historic Graph Data
    var yValuesSet1Line : [ChartDataEntry] = []
    var yValuesSet1Dots : [ChartDataEntry] = []
    
    var yValuesSet2Line : [ChartDataEntry] = []
    var yValuesSet2Dots : [ChartDataEntry] = []
    
    //for average Graph Data
    var yValues : [ChartDataEntry] = []
    
    
    //for cardetail graph.
    var carDetailYValues : [ChartDataEntry] = []
    
    //for dummy data
    var dummyHomePageValues : [ChartDataEntry] = []
    
    
    var months : [String] = []
    var indexVal = 0.0
    
    var maxVal:Double?
    var minVal:Double?
    
    
    var line1Color:String?
    var line2Color:String?
    
    
    var CarTapAction : ((Int)->())?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        graphView.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.configureShadow(cornerRadius: 5)
        
    }
    //MARK: - get dummy Graph on dashboard
    func setupChart() {
        graphView.rightAxis.enabled = false
        graphView.xAxis.labelPosition = .bottom
        graphView.xAxis.labelFont = UIFont(name: "RobotoMono-Regular", size: 8)!
        
        graphView.leftAxis.enabled = true
        graphView.leftAxis.drawAxisLineEnabled = true
        graphView.leftAxis.drawGridLinesEnabled = true
        graphView.leftAxis.valueFormatter = YAxisValueFormatter()
        graphView.leftAxis.labelFont = UIFont(name: "RobotoMono-Regular", size: 9)!
        
        graphView.dragEnabled = true
        graphView.setScaleEnabled(false)
        graphView.pinchZoomEnabled = false
        graphView.isUserInteractionEnabled = true
        graphView.legend.enabled = false
        
        graphView.drawGridBackgroundEnabled = true
        graphView.gridBackgroundColor = .white
        graphView.xAxis.drawLabelsEnabled = true
        
        
    }
    
    func setupChartData() {
        yValues.removeAll()
        for i in 0...7 {
            if i % 2 == 0 {
                let value = arc4random_uniform(10000) + 1
                if value != 0 {
                    let dataEntry = ChartDataEntry(x: Double(i), y: Double(value))
                    yValues.append(dataEntry)
                }
            }
        }
        let img = resizeImage(image: UIImage(named: "graphLine")!, targetSize: CGSize(width: 7, height: 7))
        yValues.last?.icon = img
        
        setData2()
    }
    
    
    //MARK: - get cardetail Graph Data
    func getCarDetailGraphData(carDetailGraphData:CarDetailGraphModel, id:Int){
        carDetailYValues.removeAll()
        months.removeAll()
        indexVal = 0.0
        
        for item in carDetailGraphData.data?.carDetailsGraphData?.graphData ?? [] {
            if id == item.id{
                let img = resizeImage(image: UIImage(named: "graphLinered")!, targetSize: CGSize(width: 20, height: 20))
                carDetailYValues.append(ChartDataEntry(x: Double(item.mileage ?? "0") ?? 0, y: Double(item.price ?? 0),icon: img))
                indexVal = indexVal + 1
            }else{
                carDetailYValues.append(ChartDataEntry(x: Double(item.mileage ?? "0") ?? 0, y: Double(item.price ?? 0)))
                indexVal = indexVal + 1
            }
            
        }
        carDetailYValues[carDetailYValues.count - 1].x = carDetailYValues[carDetailYValues.count - 1].x + 0.1
        setCarDetailGraph()
    }
    
    
    //MARK: - get average graph data from api
    func getgraphData(graphData:AverageGraphDataModelDataClass){
        yValues.removeAll()
        months.removeAll()
        indexVal = 0.0
        
        for item in graphData.averageGraphData?.graphPricingDataWithPercentages ?? [] {
            //adding non null values
            if (item.averagePrice != nil) {
                let dfmatter = DateFormatter()
                dfmatter.dateFormat="yyyy-MM-dd"
                let date = dfmatter.date(from: item.end_date!)
                let dateStamp:TimeInterval = date!.timeIntervalSince1970
                let dateSt:Int = Int(dateStamp)
                let x = item.percentageChange
                let y = Double(round(10 * x!) / 10)
                yValues.append(ChartDataEntry(x: Double(dateSt), y: Double(item.averagePrice ?? 0),data: y))
                months.append(item.startDate ?? "")
                indexVal = indexVal + 1
            }
        }
        
        let img = resizeImage(image: UIImage(named: "graphLine")!, targetSize: CGSize(width: 7, height: 7))
        yValues.last?.icon = img
        
        minVal = graphData.averageGraphData?.percentageYAxis?.minPercentage
        maxVal = graphData.averageGraphData?.percentageYAxis?.maxPercentage
        if !yValues.isEmpty{
            yValues[yValues.count - 1].x = yValues[yValues.count - 1].x + 0.1

        }

        setData()
    }
    
    //MARK: - get average graph data from api for is_live = true
    func getgraphDatail_isLive(graphData:AverageGraphDataModelDataClass){
        yValues.removeAll()
        months.removeAll()
        
        for item in graphData.averageGraphData?.currentTenureCarPrices?.cars ?? [] {
            //adding non null values
            var maxBid = item.max_bid ?? "$0"
            maxBid.removeAll(where: {$0 == "$"})
            maxBid.removeAll(where: {$0 == ","})
            if maxBid.isEmpty{
                maxBid = "0"
            }
            yValues.append(ChartDataEntry(x: Double(item.mileage ?? "0") ?? 0, y:Double(maxBid) ?? 0))
        }
        if !yValues.isEmpty{
            yValues[yValues.count - 1].x = yValues[yValues.count - 1].x + 0.1
        }
        setData_isLive()
    }
    
    //MARK: - get average graph data from api for is_live = true
    func showLiveDataGraph(graphData:HomeCarDetailGraphDataClass){
        yValues.removeAll()
        months.removeAll()
        
        for item in graphData.firstDataSet ?? [] {
            //adding non null values
            if (item.car_mileage != nil) {
                yValues.append(ChartDataEntry(x: Double(item.car_mileage ?? 0), y: Double(item.listing_price ?? 0),data: item.uuid))
            }
        }
        
        let img = resizeImage(image: UIImage(named: "graphLine")!, targetSize: CGSize(width: 7, height: 7))
        yValues.last?.icon = img
        
        minVal = Double(graphData.priceIntervalYAxis?.minPrice ?? 0)
        maxVal = Double(graphData.priceIntervalYAxis?.maxPrice ?? 0)
        setData_isLive()
    }
    
    //MARK: - getgraph data in case of historic live
    func showHistoricLiveDataGraph(graphData:HomeCarDetailGraphDataClass){
        yValuesSet1Line.removeAll()
        yValuesSet1Dots.removeAll()
        yValuesSet2Line.removeAll()
        yValuesSet2Dots.removeAll()
        months.removeAll()        
        
        for point in graphData.firstDataSet ?? [] {
            for im in AppUtility.seletedTableIndex {
                if im.CarSubGenerationId == point.car_sub_generation?.id && im.TrimDefinitionId == point.trim_definition?.id{
                    line1Color = im.Color
                }else if im.CarSubGenerationId == point.car_sub_generation?.id && im.TrimDefinitionId == -1 {
                    line1Color = im.Color
                }
            }
            yValuesSet1Dots.append(ChartDataEntry(x: Double(point.car_mileage ?? 0), y: Double(point.listing_price ?? 0) ,data: line2Color ?? "graphLineColorRed"))
        }
        
        for point in graphData.secondDataSet ?? [] {
            for im in AppUtility.seletedTableIndex {
                if im.CarSubGenerationId == point.car_sub_generation?.id && im.TrimDefinitionId == point.trim_definition?.id{
                    line2Color = im.Color
                }else if im.CarSubGenerationId == point.car_sub_generation?.id && im.TrimDefinitionId == -1 {
                    line2Color = im.Color
                }
            }
            yValuesSet2Dots.append(ChartDataEntry(x: Double(point.car_mileage ?? 0), y: Double(point.listing_price ?? 0),data: line2Color ?? "graphLineColorRed"))
            
        }


        setHistoricGraphLive()
    }
    
    func getHistoricGraphDataLiveListing(graphData:MultiHistoricGraphDataModelHistoricGraphData){
        yValuesSet1Line.removeAll()
        yValuesSet1Dots.removeAll()
        yValuesSet2Line.removeAll()
        yValuesSet2Dots.removeAll()
        months.removeAll()
        indexVal = 0.0
        
        var arrayCount = 2
        for item in graphData.graphData ?? [] {
            //adding non null values
            for graphPoints in item.dataPoints ?? []{
                
                if arrayCount == graphData.graphData?.count {
                    for im in AppUtility.seletedTableIndex {
                        if im.CarSubGenerationId == graphPoints.car_sub_generation?.id && im.TrimDefinitionId == graphPoints.trim_definition?.id{
                            line1Color = im.Color
                        }else if im.CarSubGenerationId == graphPoints.car_sub_generation?.id && im.TrimDefinitionId == -1 {
                            line1Color = im.Color
                        }
                    }
                    yValuesSet1Dots.append(ChartDataEntry(x: Double(graphPoints.mileage ?? "0") ?? 0, y: Double(graphPoints.max_bid ?? "0") ?? 0,data: line2Color ?? "graphLineColorRed"))
                    
                    
                }else{
                    
                    for im in AppUtility.seletedTableIndex {
                        if im.CarSubGenerationId == graphPoints.car_sub_generation?.id && im.TrimDefinitionId == graphPoints.trim_definition?.id{
                            line2Color = im.Color
                        }else if im.CarSubGenerationId == graphPoints.car_sub_generation?.id && im.TrimDefinitionId == -1 {
                            line2Color = im.Color
                        }
                    }
                    yValuesSet2Dots.append(ChartDataEntry(x: Double(graphPoints.mileage ?? "0") ?? 0, y: Double(graphPoints.max_bid ?? "0") ?? 0,data: line2Color ?? "graphLineColorRed"))
                    
                    
                }
                indexVal = indexVal + 1
            }
            
            indexVal = 0.0
            arrayCount -= 1
            
        }
        if !yValuesSet1Dots.isEmpty{
            yValuesSet1Dots[yValuesSet1Dots.count - 1].x = yValuesSet1Dots[yValuesSet1Dots.count - 1].x + 0.1

        }
        if !yValuesSet2Dots.isEmpty{
            yValuesSet2Dots[yValuesSet2Dots.count - 1].x = yValuesSet2Dots[yValuesSet2Dots.count - 1].x + 0.1
        }

        setHistoricGraphLive()
    }
    
    
    //MARK: - get Historic graph data from api
    // if select 1 first set2 is prepared.
    func getHistoricGraphData(graphData:MultiHistoricGraphDataModelHistoricGraphData){
        yValuesSet1Line.removeAll()
        yValuesSet1Dots.removeAll()
        yValuesSet2Line.removeAll()
        yValuesSet2Dots.removeAll()
        months.removeAll()
        indexVal = 0.0
        
        var arrayCount = 0
        for item in graphData.graphData ?? [] {
            //adding non null values
            for graphPoints in item.dataPoints ?? []{
                
                if arrayCount == 0 {
                    if (graphPoints.simpleMovingAverage != nil) {
                        let dfmatter = DateFormatter()
                        dfmatter.dateFormat="yyyy-MM-dd"
                        let date = dfmatter.date(from: graphPoints.date!)
                        let dateStamp:TimeInterval = date!.timeIntervalSince1970
                        let dateSt:Int = Int(dateStamp)

                        if !AppUtility.seletedTableIndex.isEmpty{
                            line1Color = AppUtility.seletedTableIndex[0].Color
                        }
                        let x = graphPoints.percentageChange
                        let y = Double(round(10 * x!) / 10)
                        let mc = linechartData(color: line1Color ?? "graphlineColorBlue", percentage: y )
                        let mcDot = linechartDataDots(color: line1Color ?? "graphlineColorBlue", percentage: y,carId: graphPoints.id ?? -1 )

                        yValuesSet1Line.append(ChartDataEntry(x: Double(dateSt), y: Double(graphPoints.simpleMovingAverage ?? 0),data: mc))
                        yValuesSet1Dots.append(ChartDataEntry(x: Double(dateSt), y: Double(graphPoints.price ?? 0),data:mcDot))
                        
                    }
                }else{
                    if (graphPoints.simpleMovingAverage != nil) {
                        let  dfmatter = DateFormatter()
                        dfmatter.dateFormat="yyyy-MM-dd"
                        let date = dfmatter.date(from: graphPoints.date!)
                        let dateStamp:TimeInterval = date!.timeIntervalSince1970
                        let dateSt:Int = Int(dateStamp)

                        if line1Color == "sliderLabel"{
                            line2Color = "red"
                        }else{
                            line2Color = "sliderLabel"
                        }
                        let x = graphPoints.percentageChange
                        let y = Double(round(10 * x!) / 10)
                        let mc = linechartData(color: line2Color ?? "graphLineColorRed", percentage: y)
                        let mcDot = linechartDataDots(color: line1Color ?? "graphlineColorBlue", percentage: y,carId: graphPoints.id ?? -1 )

                        yValuesSet2Line.append(ChartDataEntry(x: Double(dateSt), y: Double(graphPoints.simpleMovingAverage ?? 0),data: mc))
                        yValuesSet2Dots.append(ChartDataEntry(x: Double(dateSt), y: Double(graphPoints.price ?? 0),data: mcDot))
                        
                    }
                }
                months.append(graphPoints.date ?? "")
                indexVal = indexVal + 1
            }
            
            let img = resizedImage(at: UIImage(named: line2Color ?? "graphLinered")!, for: CGSize(width: 15, height: 15))
            yValuesSet2Line.last?.icon = img
            let img2 = resizedImage(at: UIImage(named: line1Color ?? "graphLineblue")!, for: CGSize(width: 15, height: 15))
            yValuesSet1Line.last?.icon = img2
            
            minVal = item.percentageYAxis?.minPercentage
            maxVal = item.percentageYAxis?.maxPercentage
            indexVal = 0.0
            arrayCount += 1
            
        }
        if !yValuesSet1Line.isEmpty{
            yValuesSet1Line[yValuesSet1Line.count - 1].x = yValuesSet1Line[yValuesSet1Line.count - 1].x + 0.1
        }
        if !yValuesSet1Dots.isEmpty{
            yValuesSet1Dots[yValuesSet1Dots.count - 1].x = yValuesSet1Dots[yValuesSet1Dots.count - 1].x + 0.1
        }
        if !yValuesSet2Line.isEmpty{
            yValuesSet2Line[yValuesSet2Line.count - 1].x = yValuesSet2Line[yValuesSet2Line.count - 1].x + 0.1
        }
        if !yValuesSet2Dots.isEmpty{
            yValuesSet2Dots[yValuesSet2Dots.count - 1].x = yValuesSet2Dots[yValuesSet2Dots.count - 1].x + 0.1
        }
        setHistoricGraph()
    }
    
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        //        return months[Int(value)]
        
        let dateFormatter = DateFormatter()
        if AppUtility.Tenure?.rawValue == tenure.oneMonth.rawValue || AppUtility.Tenure?.rawValue == tenure.sixMonth.rawValue || AppUtility.Tenure?.rawValue == tenure.threeMonth.rawValue {
            dateFormatter.setLocalizedDateFormatFromTemplate("dd MMM")

        }else{
            dateFormatter.setLocalizedDateFormatFromTemplate("MMM,yyyy")

        }
        dateFormatter.locale = .autoupdatingCurrent
        
        
        let date = Date(timeIntervalSince1970: value)
        
        return dateFormatter.string(from: date)
        
    }
    
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        guard let mc = entry.data as? linechartDataDots else{
//            setHistoricGraph()
            return
        }
        if mc.carId != -1 {
            print(mc.carId)
            CarTapAction?(mc.carId)
//            setHistoricGraph()
        }
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        setHistoricGraph()
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
        
        let data = LineChartData(dataSet: set2)
        graphView.data = data
        graphView.rightAxis.enabled = false
        graphView.xAxis.labelPosition = .bottom
        //        graphView.xAxis.valueFormatter = self
        //        graphView.xAxis.labelCount = 5
        graphView.xAxis.labelFont = UIFont(name: "RobotoMono-Regular", size: 8)!
        
        graphView.leftAxis.enabled = true
        graphView.leftAxis.drawAxisLineEnabled = true
        graphView.leftAxis.drawGridLinesEnabled = true
        graphView.leftAxis.valueFormatter = YAxisValueFormatter()
        graphView.leftAxis.labelFont = UIFont(name: "RobotoMono-Regular", size: 9)!
        
        graphView.dragEnabled = true
        graphView.setScaleEnabled(false)
        graphView.pinchZoomEnabled = false
        graphView.isUserInteractionEnabled = true
        graphView.legend.enabled = false
        
        
        let marker:BalloonMarker = BalloonMarker(color: UIColor(named: "grapgGreen")!, font: UIFont(name: "RobotoMono-Regular", size: 6)!, textColor: UIColor.white, insets: UIEdgeInsets(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0))
        marker.chartView = graphView
        marker.minimumSize = CGSize(width: 30.0, height: 11.0)
        graphView.marker = marker
        graphView.drawMarkers = true
        
        if yValues.count != 0 {
            graphView.highlightValues([Highlight(x: Double(carDetailYValues[yValues.count - 1].x), y: Double(carDetailYValues[yValues.count - 1].y), dataSetIndex: 0)])
            graphView.drawGridBackgroundEnabled = true
            graphView.gridBackgroundColor = .white
            graphView.xAxis.drawLabelsEnabled = true
        }
        
    }
    
    
    func setData_isLive(){
        let set1 = LineChartDataSet(entries: yValues,label: "Miles")
        set1.drawCirclesEnabled = true
        set1.drawValuesEnabled = false
        set1.drawHorizontalHighlightIndicatorEnabled = false
        set1.drawVerticalHighlightIndicatorEnabled = false
        set1.setColor(UIColor(named: "grapgGreen")!)
        set1.lineWidth = 0
        set1.circleHoleColor = UIColor(named: "grapgGreen")!
        set1.setCircleColor(UIColor(named: "grapgGreen")!)
        set1.circleRadius = 4
        
        let data = LineChartData(dataSet: set1)
        graphView.data = data
        
        graphView.rightAxis.enabled = false
        
        
        graphView.xAxis.labelPosition = .bottom
        graphView.xAxis.labelFont = UIFont(name: "RobotoMono-Regular", size: 8)!
        graphView.xAxis.valueFormatter = customValue()
        graphView.xAxis.labelCount = 6
        graphView.xAxis.forceLabelsEnabled = true
        graphView.xAxis.avoidFirstLastClippingEnabled = true
        
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
        graphView.isUserInteractionEnabled = false
        graphView.legend.enabled = false
        
        graphView.drawGridBackgroundEnabled = true
        graphView.gridBackgroundColor = .white
        graphView.drawMarkers = false
        if yValues.count == 0 {
            graphView.clear()
        }
    }
    
    
    func setData(){
        let set1 = LineChartDataSet(entries: yValues,label: "")
        
        set1.drawCirclesEnabled = false
        set1.drawValuesEnabled = false
        set1.setColor(UIColor(named: "grapgGreen")!)
        set1.lineWidth = 3
        let gradientColors = [ChartColorTemplates.colorFromString("#ffffff").cgColor,
                              ChartColorTemplates.colorFromString("#e7f4ec").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        set1.fillAlpha = 0.8
        set1.fill = LinearGradientFill(gradient: gradient, angle: 90)
        set1.drawFilledEnabled = true
        set1.mode = .horizontalBezier
        
        
        set1.drawHorizontalHighlightIndicatorEnabled = true
        set1.drawVerticalHighlightIndicatorEnabled = false
        set1.highlightColor = UIColor(named: "grapgGreen")!
        
        set1.highlightLineDashLengths = [8.0, 4.0]
        set1.highlightColor = UIColor(named: "grapgGreen")!
        set1.highlightLineWidth = 1.0
        
        
        let data = LineChartData(dataSet: set1)
        graphView.data = data
        graphView.rightAxis.enabled = true
        graphView.xAxis.labelPosition = .bottom
        graphView.xAxis.valueFormatter = self
        graphView.xAxis.labelCount = 6
        graphView.xAxis.forceLabelsEnabled = true
        graphView.xAxis.labelFont = UIFont(name: "RobotoMono-Regular", size: 9)!
        graphView.xAxis.avoidFirstLastClippingEnabled = false
        
        graphView.leftAxis.enabled = true
        graphView.leftAxis.drawAxisLineEnabled = true
        graphView.leftAxis.drawGridLinesEnabled = true
        graphView.leftAxis.valueFormatter = YAxisValueFormatter()
        graphView.leftAxis.labelFont = UIFont(name: "RobotoMono-Regular", size: 9)!
        graphView.leftAxis.labelCount = 6
        graphView.leftAxis.forceLabelsEnabled = true
        
        let rightAxis = graphView.rightAxis
        rightAxis.labelTextColor = .black
        rightAxis.axisMinimum = minVal ?? 0
        rightAxis.axisMaximum = maxVal ?? 0
        rightAxis.drawAxisLineEnabled = false
        rightAxis.drawGridLinesEnabled = false
        rightAxis.valueFormatter = YAxisValueFormatterRight()
        rightAxis.labelFont = UIFont(name: "RobotoMono-Regular", size: 9)!
        rightAxis.labelCount = 6
        rightAxis.forceLabelsEnabled = true
        
        graphView.dragEnabled = false
        graphView.setScaleEnabled(false)
        graphView.pinchZoomEnabled = false
        graphView.isUserInteractionEnabled = false
        graphView.legend.enabled = false
        
        rightAxis.minWidth = 54
        rightAxis.maxWidth = 54
        
        graphView.leftAxis.minWidth = 50
        graphView.leftAxis.maxWidth = 50
        
        let marker:BalloonMarker = BalloonMarker(color: UIColor(named: "grapgGreen")!, font: UIFont(name: "RobotoMono-Regular", size: 9)!, textColor: UIColor.white, insets: UIEdgeInsets(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0))
        marker.chartView = graphView
        marker.minimumSize = CGSize(width: 40.0, height: 11.0)
        graphView.marker = marker
        graphView.drawMarkers = true
        
        AppUtility.graphLeftRight = true
        
        if yValues.count != 0 {
            graphView.highlightValues([Highlight(x: Double(yValues[yValues.count - 1].x), y: Double(yValues[yValues.count - 1].y), dataSetIndex: 0),Highlight(x: Double(yValues[yValues.count - 1].x), y: Double(yValues[yValues.count - 1].y), dataSetIndex: 0)])
            graphView.drawGridBackgroundEnabled = true
            graphView.gridBackgroundColor = .white
            graphView.xAxis.drawLabelsEnabled = true
        }else{
            graphView.clear()
        }
    }
    func setDataLIVE(){
        let set1 = LineChartDataSet(entries: yValues,label: "")
        
        set1.drawCirclesEnabled = false
        set1.drawValuesEnabled = false
        set1.setColor(UIColor(named: "grapgGreen")!)
        set1.lineWidth = 3
        let gradientColors = [ChartColorTemplates.colorFromString("#ffffff").cgColor,
                              ChartColorTemplates.colorFromString("#e7f4ec").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        set1.fillAlpha = 0.8
        set1.fill = LinearGradientFill(gradient: gradient, angle: 90)
        set1.drawFilledEnabled = true
        set1.mode = .horizontalBezier
        
        
        set1.drawHorizontalHighlightIndicatorEnabled = true
        set1.drawVerticalHighlightIndicatorEnabled = false
        set1.highlightColor = UIColor(named: "grapgGreen")!
        
        set1.highlightLineDashLengths = [8.0, 4.0]
        set1.highlightColor = UIColor(named: "grapgGreen")!
        set1.highlightLineWidth = 1.0
        
        
        let data = LineChartData(dataSet: set1)
        graphView.data = data
        graphView.rightAxis.enabled = true
        graphView.xAxis.labelPosition = .bottom
        graphView.xAxis.valueFormatter = customValue()
        graphView.xAxis.labelCount = 6
        graphView.xAxis.forceLabelsEnabled = true
        graphView.xAxis.labelFont = UIFont(name: "RobotoMono-Regular", size: 9)!
        graphView.xAxis.avoidFirstLastClippingEnabled = false
        
        graphView.leftAxis.enabled = true
        graphView.leftAxis.drawAxisLineEnabled = true
        graphView.leftAxis.drawGridLinesEnabled = true
        graphView.leftAxis.valueFormatter = YAxisValueFormatter()
        graphView.leftAxis.labelFont = UIFont(name: "RobotoMono-Regular", size: 9)!
        graphView.leftAxis.labelCount = 6
        graphView.leftAxis.forceLabelsEnabled = true
        
        let rightAxis = graphView.rightAxis
        rightAxis.labelTextColor = .black
        rightAxis.axisMinimum = minVal ?? 0
        rightAxis.axisMaximum = maxVal ?? 0
        rightAxis.drawAxisLineEnabled = false
        rightAxis.drawGridLinesEnabled = false
        rightAxis.valueFormatter = YAxisValueFormatterRight()
        rightAxis.labelFont = UIFont(name: "RobotoMono-Regular", size: 9)!
        rightAxis.labelCount = 6
        rightAxis.forceLabelsEnabled = true
        
        graphView.dragEnabled = false
        graphView.setScaleEnabled(false)
        graphView.pinchZoomEnabled = false
        graphView.isUserInteractionEnabled = false
        graphView.legend.enabled = false
        
        rightAxis.minWidth = 54
        rightAxis.maxWidth = 54
        
        graphView.leftAxis.minWidth = 50
        graphView.leftAxis.maxWidth = 50
        
        let marker:BalloonMarker = BalloonMarker(color: UIColor(named: "grapgGreen")!, font: UIFont(name: "RobotoMono-Regular", size: 9)!, textColor: UIColor.white, insets: UIEdgeInsets(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0))
        marker.chartView = graphView
        marker.minimumSize = CGSize(width: 40.0, height: 11.0)
        graphView.marker = marker
        graphView.drawMarkers = true
        
        AppUtility.graphLeftRight = true
        
        if yValues.count != 0 {
            graphView.highlightValues([Highlight(x: Double(yValues[yValues.count - 1].x), y: Double(yValues[yValues.count - 1].y), dataSetIndex: 0),Highlight(x: Double(yValues[yValues.count - 1].x), y: Double(yValues[yValues.count - 1].y), dataSetIndex: 0)])
            graphView.drawGridBackgroundEnabled = true
            graphView.gridBackgroundColor = .white
            graphView.xAxis.drawLabelsEnabled = true
        }else{
            graphView.clear()
        }
    }
    
    func setData2(){
        let set1 = LineChartDataSet(entries: yValues,label: "")
        
        set1.drawCirclesEnabled = false
        set1.drawValuesEnabled = false
        set1.setColor(UIColor(named: "grapgGreen")!)
        set1.lineWidth = 3
        let gradientColors = [ChartColorTemplates.colorFromString("#ffffff").cgColor,
                              ChartColorTemplates.colorFromString("#e7f4ec").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        set1.fillAlpha = 0.8
        set1.fill = LinearGradientFill(gradient: gradient, angle: 90)
        set1.drawFilledEnabled = true
        set1.mode = .horizontalBezier
        
        
        set1.drawHorizontalHighlightIndicatorEnabled = true
        set1.drawVerticalHighlightIndicatorEnabled = false
        set1.highlightColor = UIColor(named: "grapgGreen")!
        
        set1.highlightLineDashLengths = [8.0, 4.0]
        set1.highlightColor = UIColor(named: "grapgGreen")!
        set1.highlightLineWidth = 1.0
        
        
        let data = LineChartData(dataSet: set1)
        graphView.data = data
        graphView.rightAxis.enabled = true
        graphView.xAxis.labelPosition = .bottom
        graphView.xAxis.valueFormatter = customValue()
        graphView.xAxis.labelCount = 6
        graphView.xAxis.forceLabelsEnabled = true
        graphView.xAxis.labelFont = UIFont(name: "RobotoMono-Regular", size: 8)!
        
        graphView.leftAxis.enabled = true
        graphView.leftAxis.drawAxisLineEnabled = true
        graphView.leftAxis.drawGridLinesEnabled = true
        graphView.leftAxis.valueFormatter = YAxisValueFormatter()
        graphView.leftAxis.labelFont = UIFont(name: "RobotoMono-Regular", size: 9)!
        
        let rightAxis = graphView.rightAxis
        rightAxis.labelTextColor = .black
        rightAxis.axisMinimum = minVal ?? 0
        rightAxis.axisMaximum = maxVal ?? 0
        rightAxis.drawAxisLineEnabled = false
        rightAxis.drawGridLinesEnabled = false
        rightAxis.valueFormatter = YAxisValueFormatterRight()
        rightAxis.labelFont = UIFont(name: "RobotoMono-Regular", size: 6)!
        
        graphView.dragEnabled = true
        graphView.setScaleEnabled(false)
        graphView.pinchZoomEnabled = false
        graphView.isUserInteractionEnabled = true
        graphView.legend.enabled = false
        
        let marker:BalloonMarker = BalloonMarker(color: UIColor(named: "grapgGreen")!, font: UIFont(name: "RobotoMono-Regular", size: 6)!, textColor: UIColor.white, insets: UIEdgeInsets(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0))
        marker.chartView = graphView
        marker.minimumSize = CGSize(width: 40.0, height: 11.0)
        graphView.marker = marker
        graphView.drawMarkers = true
        
        AppUtility.graphLeftRight = true
        
        if yValues.count != 0 {
            //            graphView.highlightValues([Highlight(x: Double(yValues[yValues.count - 1].x), y: Double(yValues[yValues.count - 1].y), dataSetIndex: 0),Highlight(x: Double(yValues[yValues.count - 1].x), y: Double(yValues[yValues.count - 1].y), dataSetIndex: 0)])
            graphView.drawGridBackgroundEnabled = true
            graphView.gridBackgroundColor = .white
            graphView.xAxis.drawLabelsEnabled = true
        }
        
    }
    
    func setHistoricGraph(){
        //average line
        let set1 = LineChartDataSet(entries: yValuesSet1Line,label: "")
        set1.drawCirclesEnabled = false
        set1.drawValuesEnabled = false
        set1.setColor(UIColor(named: line1Color ?? "graphlineColorBlue")!)
        set1.lineWidth = 3
        set1.mode = .horizontalBezier
        set1.drawHorizontalHighlightIndicatorEnabled = true
        set1.drawVerticalHighlightIndicatorEnabled = false
        set1.highlightColor = UIColor(named: line1Color ?? "graphlineColorBlue")!
        set1.highlightLineDashLengths = [8.0, 4.0]
        set1.highlightColor = UIColor(named: line1Color ?? "graphlineColorBlue")!
        set1.highlightLineWidth = 1.0
        
        //average line
        let set11 = LineChartDataSet(entries: yValuesSet2Line,label: "")
        set11.drawCirclesEnabled = false
        set11.drawValuesEnabled = false
        set11.setColor(UIColor(named: line2Color ?? "graphLineColorRed")!)
        set11.lineWidth = 3
        set11.mode = .horizontalBezier
        set11.drawHorizontalHighlightIndicatorEnabled = true
        set11.drawVerticalHighlightIndicatorEnabled = false
        set11.highlightColor = UIColor(named: line2Color ?? "graphLineColorRed")!
        set11.highlightLineDashLengths = [8.0, 4.0]
        set11.highlightColor = UIColor(named: line2Color ?? "graphLineColorRed")!
        set11.highlightLineWidth = 1.0
        
        //individual listing dots
        let set2 = LineChartDataSet(entries: yValuesSet1Dots,label: "")
        set2.drawCirclesEnabled = true
        set2.drawValuesEnabled = false
        set2.drawHorizontalHighlightIndicatorEnabled = false
        set2.drawVerticalHighlightIndicatorEnabled = false
        set2.setColor(UIColor(named: line1Color ?? "graphlineColorBlue")!)
        set2.lineWidth = 0
        set2.circleHoleColor = UIColor(named: line1Color ?? "graphlineColorBlue")!
        set2.setCircleColor(UIColor(named: line1Color ?? "graphlineColorBlue")!)
        set2.circleRadius = 4
        
        //individual listing dots
        let set22 = LineChartDataSet(entries: yValuesSet2Dots,label: "")
        set22.drawCirclesEnabled = true
        set22.drawValuesEnabled = false
        set22.drawHorizontalHighlightIndicatorEnabled = false
        set22.drawVerticalHighlightIndicatorEnabled = false
        set22.setColor(UIColor(named: line2Color ?? "graphLineColorRed")!)
        set22.lineWidth = 0
        set22.circleHoleColor = UIColor(named: line2Color ?? "graphLineColorRed")!
        set22.setCircleColor(UIColor(named: line2Color ?? "graphLineColorRed")!)
        set22.circleRadius = 4
        
        let marker:BalloonMarker2 = BalloonMarker2(color: UIColor(named: "grapgGreen")!, font: UIFont(name: "RobotoMono-Regular", size: 9)!, textColor: UIColor.white, insets: UIEdgeInsets(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0))
        marker.chartView = graphView
        marker.minimumSize = CGSize(width: 30.0, height: 11.0)
        graphView.marker = marker
        
        if AppUtility.showAverage! && AppUtility.showIndividualListing! {
            let data: LineChartData = [set1,set11, set2,set22]
            graphView.data = data
            graphView.drawMarkers = true
        }
        if !AppUtility.showAverage! && AppUtility.showIndividualListing! {
            let data: LineChartData = [set2,set22]
            graphView.data = data
            graphView.drawMarkers = false
        }
        if AppUtility.showAverage! && !AppUtility.showIndividualListing! {
            let data: LineChartData = [set1,set11]
            graphView.data = data
            graphView.drawMarkers = true
        }
        
        graphView.xAxis.labelPosition = .bottom
        graphView.xAxis.valueFormatter = self
        graphView.xAxis.labelCount = 6
        graphView.xAxis.forceLabelsEnabled = true
        graphView.xAxis.labelFont = UIFont(name: "RobotoMono-Regular", size: 9)!
        
        graphView.leftAxis.enabled = true
        graphView.leftAxis.drawAxisLineEnabled = true
        graphView.leftAxis.drawGridLinesEnabled = true
        graphView.leftAxis.valueFormatter = YAxisValueFormatter()
        graphView.leftAxis.labelFont = UIFont(name: "RobotoMono-Regular", size: 9)!
        graphView.leftAxis.labelCount = 6
        graphView.leftAxis.forceLabelsEnabled = true
        
        
        
        
        let rightAxis = graphView.rightAxis
        rightAxis.labelTextColor = .black
        rightAxis.axisMinimum = minVal ?? 0
        rightAxis.axisMaximum = maxVal ?? 0
        rightAxis.drawAxisLineEnabled = false
        rightAxis.drawGridLinesEnabled = false
        rightAxis.valueFormatter = YAxisValueFormatterRight()
        rightAxis.labelFont = UIFont(name: "RobotoMono-Regular", size: 9)!
        rightAxis.labelCount = 6
        rightAxis.forceLabelsEnabled = true
        
        rightAxis.minWidth = 52
        rightAxis.maxWidth = 52
        
        graphView.leftAxis.minWidth = 50
        graphView.leftAxis.maxWidth = 50
        
        graphView.dragEnabled = false
        graphView.setScaleEnabled(false)
        graphView.pinchZoomEnabled = false
        graphView.isUserInteractionEnabled = true
        graphView.legend.enabled = false
        
        
        AppUtility.graphLeftRighthistoric = [true,false,true,false]
        if !yValuesSet1Line.isEmpty{
            if !yValuesSet2Line.isEmpty{
                graphView.rightAxis.labelCount = 0
                rightAxis.axisMinimum = 0
                rightAxis.axisMaximum = 0
                rightAxis.forceLabelsEnabled = true
                
                
                graphView.highlightValues([Highlight(x: Double(yValuesSet1Line[yValuesSet1Line.count - 1].x), y: Double(yValuesSet1Line[yValuesSet1Line.count - 1].y), dataSetIndex: 0),Highlight(x: Double(yValuesSet1Line[yValuesSet1Line.count - 1].x), y: Double(yValuesSet1Line[yValuesSet1Line.count - 1].y), dataSetIndex: 0), Highlight(x: Double(yValuesSet2Line[yValuesSet2Line.count - 1].x), y: Double(yValuesSet2Line[yValuesSet2Line.count - 1].y), dataSetIndex: 1),Highlight(x: Double(yValuesSet2Line[yValuesSet2Line.count - 1].x), y: Double(yValuesSet2Line[yValuesSet2Line.count - 1].y), dataSetIndex: 1)])
            }else{
                graphView.rightAxis.enabled = true
                graphView.highlightValues([Highlight(x: Double(yValuesSet1Line[yValuesSet1Line.count - 1].x), y: Double(yValuesSet1Line[yValuesSet1Line.count - 1].y), dataSetIndex: 0),Highlight(x: Double(yValuesSet1Line[yValuesSet1Line.count - 1].x), y: Double(yValuesSet1Line[yValuesSet1Line.count - 1].y), dataSetIndex: 0)])
            }
        }
        graphView.drawGridBackgroundEnabled = true
        graphView.gridBackgroundColor = .white
        
        if yValuesSet1Line.isEmpty && yValuesSet2Line.isEmpty{
            graphView.clear()
        }
    }
    
    
    
    func setHistoricGraphLive(){
        
        //individual listing dots
        let set2 = LineChartDataSet(entries: yValuesSet1Dots,label: "Mileage")
        set2.drawCirclesEnabled = true
        set2.drawValuesEnabled = false
        set2.drawHorizontalHighlightIndicatorEnabled = false
        set2.drawVerticalHighlightIndicatorEnabled = false
        set2.setColor(UIColor(named: line1Color ?? "graphlineColorBlue")!)
        set2.lineWidth = 0
        set2.circleHoleColor = UIColor(named: line1Color ?? "graphlineColorBlue")!
        set2.setCircleColor(UIColor(named: line1Color ?? "graphlineColorBlue")!)
        set2.circleRadius = 4
        
        //individual listing dots
        let set22 = LineChartDataSet(entries: yValuesSet2Dots,label: "")
        set22.drawCirclesEnabled = true
        set22.drawValuesEnabled = false
        set22.drawHorizontalHighlightIndicatorEnabled = false
        set22.drawVerticalHighlightIndicatorEnabled = false
        set22.setColor(UIColor(named: line2Color ?? "graphLineColorRed")!)
        set22.lineWidth = 0
        set22.circleHoleColor = UIColor(named: line2Color ?? "graphLineColorRed")!
        set22.setCircleColor(UIColor(named: line2Color ?? "graphLineColorRed")!)
        set22.circleRadius = 4
        
        let data: LineChartData = [set2,set22]
        graphView.data = data
        graphView.rightAxis.enabled = false
        graphView.xAxis.labelPosition = .bottom
        graphView.xAxis.labelCount = 5
        graphView.xAxis.forceLabelsEnabled = false
        graphView.xAxis.avoidFirstLastClippingEnabled = false
        graphView.xAxis.labelFont = UIFont(name: "RobotoMono-Regular", size: 9)!
        graphView.xAxis.valueFormatter = customValue()
        
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
        
        graphView.drawGridBackgroundEnabled = true
        graphView.gridBackgroundColor = .white
        graphView.drawMarkers = false
        if yValuesSet1Dots.isEmpty && yValuesSet2Dots.isEmpty {
            graphView.clear()
        }
    }
}

class YAxisValueFormatter : AxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        formatter.currencySymbol = ""
        guard let formattedTipAmount = formatter.string(from: value as NSNumber) else {
            return ""
        }
        
        return String(formattedTipAmount)
    }
}

class customValue : AxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 0
        return numberFormatter.string(from: NSNumber(value: Int(value) )) ?? "0"
    }
}

class YAxisValueFormatterRight : AxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return String(Int(value)) + " %"
    }
}





struct linechartData{
    var color:String
    var percentage:Double
}

struct linechartDataDots{
    var color:String
    var percentage:Double
    var carId:Int
}

