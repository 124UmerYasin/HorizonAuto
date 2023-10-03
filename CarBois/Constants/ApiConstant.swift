//
//  ApiConstant.swift
//  CarBois
//
//  Created by Umer Yasin on 20/09/2022.
//

import Foundation

struct ApiConstant {
    
    static let server = "https://dev-microservices.horizonauto.com/"
    
//    static let getDashboardFilterData = "\(server)makes-model-list" // not using this API anymore
    static let getCarMakes = "\(server)car-make"
    static let getCarModels = "\(server)car-model"
    static let getGenerations = "\(server)generations"
    static let getCarTrimsAndSubGenerations = "\(server)trim-ranges"
    static let averagesGraphData = "\(server)averages-graph-data"
    static let historicGraphData = "\(server)historic-graph-data"
    static let multiHistoricGraphData = "\(server)multi-historic-graph-data"
    static let modelPricing = "\(server)model-pricing-data"
    static let averagePriceCarList = "\(server)average-graph-car-list"
    static let hotPicks = "\(server)hot-picks"
    static let carDetail = "\(server)car-details"
    static let carDetailGraph = "\(server)car-details-graph-data"
    static let averageGraphFilterList = "\(server)average-graph-filters-list"
    static let carDetailSimilarListing = "\(server)car-details-similar-listings"
    static let multiHistoricGraphFilerListing = "\(server)multi-historic-graph-filters-list"
    static let carDetailFilterListing = "\(server)car-details-graph-filters-list"
    static let historiclistingcars = "\(server)multi-matching-historic-listing"
    
    
    static let wantToBuyListing = "\(server)get-all-WTB-listings-for-make-model"
    static let wantToSaleListing = "\(server)get-all-ForSale-Listings-for-make-model"
    
    static let submitForSalelisting = "\(server)submit-ForSale-listing"
    static let submitForBuylisting = "\(server)submit-WTB-listing"
    
    static let contactBuyer = "\(server)contact-buyer-forSale-form"
    static let contactSeller = "\(server)contact-seller-WTB-form"
    
    static let getfileUploadLink = "\(server)get-file-upload-link"
    static let getYearsFromSubGen = "\(server)get-years-from-subgen"
    
    static let getMarqueeData = "\(server)marquee-data"
    static let getFeaturedListings = "\(server)get-Featured-Listings"
    
    
    static let getusersForSalelistings = "\(server)get-users-ForSale-listings"
    static let getusersWTBlistings = "\(server)get-users-WTB-listings"

    static let horizonautolistingcardetails = "\(server)horizon-auto-listing-car-details"
    static let getsimilarhorizonautolistings = "\(server)get-similar-horizon-auto-listings"
    static let gethorizonautoForSalegraphdata = "\(server)get-horizon-auto-ForSale-graph-data"
    
    
    
    static let gethorizonautoForSalegraphdataForModelAnalysis = "\(server)get-horizon-auto-ForSale-graph-data"
    static let getallForSaleListingsformakemodel = "\(server)get-all-ForSale-Listings-for-make-model"

    static let  getlistingresponses = "\(server)get-listing-responses"

    
   
}
