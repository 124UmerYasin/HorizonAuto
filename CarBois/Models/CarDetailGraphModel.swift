//
//  CarDetailGraphModel.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 12/10/2022.
//
import Foundation

// MARK: - CarDetailGraphModel
struct CarDetailGraphModel: Codable {
    let status: String?
    let statusCode: Int?
    let message: String?
    let data: CarDetailGraphModelDataClass?
}

// MARK: - DataClass
struct CarDetailGraphModelDataClass: Codable {
    let id: Int?
    let filtersApplied: [CarDetailGraphModelFiltersApplied]?
    let carDetailsGraphData: CarDetailGraphModelCarDetailsGraphData?
}

// MARK: - CarDetailsGraphData
struct CarDetailGraphModelCarDetailsGraphData: Codable {
    let graphData: [CarDetailGraphModelGraphDatum]?
}

// MARK: - GraphDatum
struct CarDetailGraphModelGraphDatum: Codable {
    let id: Int?
    let listing_title, listing_subtitle: String?
    let year: Int?
    let mileage, auction_result_price: String?
    let auction_has_reserve: String?
    let auction_result_status: String?
    let auction_result_date, seller, location, vin: String?
    let vin_8th_digit, vin_12th_digit: String?
    let listing_type: String?
    let sale_price: String?
    let sale_date: String?
    let carMakeId: Int?
    let carModelId: Int?
    let carGenerationId: Int?
    let carSubGenerationId: Int?
    let trimDefinitionId: Int?

    
    let carType: String?
    let listingType: String?
    let salePrice, saleDate: String?
    let transmission_type: String?
    let drive_type: String?
    let carfax_info: String?
    let title_info:String?
    let engine_layout:String?
    let createdAt: String?
    let updatedAt: String?
    let trim_definition: CarDetailGraphModelTrimDefinition?
    let price: Int?
    let date: String?
    let is_live:Bool?
    let max_bid:String?
    let live_auction_scheduled_completion_time:String?
    let auction_actual_completion_time:String?
    let url:String?
    let bid_array:[HistoricBidArray]?
}

// MARK: - TrimDefinition
struct CarDetailGraphModelTrimDefinition: Codable {
    let id: Int?
    let car_trim: String?
    let body_style: String?
    let drive_type: String?
    let createdAt: String?
    let updatedAt: String?

}


// MARK: - FiltersApplied
struct CarDetailGraphModelFiltersApplied: Codable {
    let title, key, fieldType: String?
    let min, max: Int?
    let listOfValues: [String]?
}
