//
//  AppUtility.swift
//  CarBois
//
//  Created by Umer Yasin on 20/09/2022.
//

import Foundation

class AppUtility: NSObject {
    
    static var dashboardFilterData : CarMakeModel?
    static var graphData:AverageGraphDataModelDataClass? // for analysis screen.
    static var multiHistoricGraphData:MultiHistoricGraphDataModelHistoricGraphData? // for analysis screen.
    static var ModelPricingDataModel:ModelPricingDataModelDataClass? // for analysis screen.
    static var generation:String? // for analysis screen.
    static var subGen:String? // for analysis screen.
    static var subTrims:String? // for analysis screen.
    static var showAverage:Bool? = true // for analysis screen.
    static var showIndividualListing:Bool? = true // for analysis screen.
    static var canNavigateFromDashboardFilter:Bool? = false // for stopping filter dismiss to go on next screen.
    static var filterRequestBody:averageGraphRequestModel? // for analysis screen to help
    static var averageGraphCarList = [AverageGraphCarListModelCurrentTenureCarsList]() // for analysis screen to help
    static var Tenure:tenure? // for analysis screen to help
    static var selectedCoditionValue:String? // for analysis screen to help
    static var selectedMakeValue:Int? // for analysis screen to help
    static var selectedModelValue:Int? // for analysis screen to help
    static var fromContactBuyer:Bool = false // for stopping filter dismiss to go on next screen.

    static var isColor = true // true blue false red


    static var selectedCodition = 0 //index not id
    static var selectedMake = 0 //index not id
    static var selectedModel = 0 //index not id
    static var selectedGeneration = 0 //index not id
    static var seletedTableIndex = [dashboardfilteratabledataModel]()
    
    static var historicGraphRequestBody:multiHistoricGraphRequestModel?
    static var multiHistoricGraphCarList = [MultiHistoricGraphDataModelDataPoint]()
    static var historiccarListModelreq : multiHistoriccarRequestModel?
    static var multiHistoricCarList = [MultiHistoricCarListingPaginatedArr]()

    
    static var averageGraphCarListRequest : AverageGraphCarListRequest?

    
    static var hotPicks : HotPicksDataModelDataClass?// hot picks api for dashboard.

    static var SelectedIndex:Int = 3
    
    static var AverageGraphFilter:AverageGraphFiltersList?
    static var HistoricGraphFilter:MultiHistoricGraphFiltersList?
    static var CarDetailFilter:CarDetailsGraphFiltersList?

    
    static var FilterAppliedFromList:Bool?
    static var FilterApplied:[filtersRequest]?
    static var FilterAppliedCarDetail:[filtersRequest]?

    static var SortApplied:String?

    
    static var moveTopop:Bool = false
    
    
    static var graphLeftRight:Bool = false
    static var graphLeftRighthistoric:[Bool] = [true,false,true,false]

    
    static var navigateToNextWhenAppOpen = false
    
    static var filterAppliedFromCarDetailScreen = false
    
    static var ToggleState:Bool? = false //needed to show 
    static var showCurrentHistoric:Bool = false // need to show live listing in historic graph.
    static var is_filter_Applied:Bool = false
    
    
    
    static var totalCarsAverage:Int?
    static var toatalCarsHistoric:Int?
    static var totalCarsCarDetail:Int?

    static var selectedGenerations = [Int]()
    
    
    static var carDetailFilterBody : CarDetailFilterListingRequest?

    static var Gender:String = "Male"
    
    
    static var isUUidPresent:Bool = false
    static var uuid:String = ""
    
    
    static var selectedBuyFilter:searchSelection?
    static var selectedSellFilter:searchSelection?
    
    static var isfromBuy : Bool = false // true->buy && false->sell //check search from home
    static var isfromHome : Bool = false // true->home && false->form // check from form or not.

    static var selectedBuyFilterHome:searchSelection?
    static var selectedSellFilterHome:searchSelection?
    static var isFromNavigationProg:Bool? = false

    
    
    static var showFIrstTimeLoader:Bool = false // true->buy && false->sell

    static var moveToCarDetailFormModelAnalysis:Bool = false // true->buy && false->sell


    static var featuredListing:[FeaturedListingModelDatum]? // home page featuredListing
    static var WTBListing:[GetuserWTBListingoModelListingID]? // home page WTBListing
    static var SaleListing:[GetuserSaleListingoMdelListingID]? // home page SaleListing

    static var graphDataInLiveCase:HomeCarDetailGraphDataClass? // model analysis page in case of live
    static var carListInModelAnalysisInLiveCase:[WantToSaleListingModelListing]? // model analysis page in case of live
    static var carListInModelAnalysisInLiveCaseCount: Int? // model analysis page in case of live
    static var showOrHideLiveButton:Bool = false // true->buy && false->sell
    static var messageToShowAfterForm:String = ""
}


struct searchSelection{
    var make:Int?
    var model:Int?
    var gen:Int?
    var subgen:Int?
    var trim:Int?
}
