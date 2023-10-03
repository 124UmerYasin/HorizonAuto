//
//  AverageGraphDataModel.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 22/09/2022.
//

import Foundation

// MARK: - AverageGraphDataModel
struct AverageGraphDataModel: Codable {
    let status: String?
    let statusCode: Int?
    let message: String?
    let data: AverageGraphDataModelDataClass?
}

// MARK: - DataClass
struct AverageGraphDataModelDataClass: Codable {
    let filtersApplied: [FiltersApplied]?
    let averageGraphData: AverageGraphData?
    
}
//MARK: -
struct CurrentTenureCarPricesLive:Codable {
    let cars: [CurrentAverageCar]?
    let count: Int?
}

// MARK: - Car
struct CurrentAverageCar : Codable{
    let id: Int?
    let listing_title: String?
    let listing_subtitle: String?
    let year: Int?
    let mileage: String?
    let auction_result_price, auction_has_reserve, auction_result_status, auction_result_date: String?
    let seller, location, vin, vin_8th_digit: String?
    let vin_12th_digit: String?
    let car_type: String?
    let listing_type: String?
    let sale_price, sale_date: String?
    let carMakeID, carModelID, carGenerationID, carSubGenerationID: Int?
    let trim_definition: averageGrapgTrimDefinition?
    let trimDefinitionId: Int?
    let transmission_type: String?
    let drive_type: String?
    let carfax_info: String?
    let title_info: String?
    let engine_layout: String?
    let bid_array: [BidArray]?
    let is_live: Bool?
    let max_bid, live_auction_scheduled_completion_time: String?
    let auction_actual_completion_time: String?
    let url: String?
    let createdAt: String?
    let updatedAt: String?
}

// MARK: - TrimDefinition
struct averageGrapgTrimDefinition : Codable{
    let id: Int?
    let car_trim: String?
    let body_style: String?
    let drive_type: String?
    let createdAt: String?
    let updatedAt: String?
}

// MARK: - BidArray
struct BidArray :Codable{
    let bid_time, bid_amount: String?
}

// MARK: - AverageGraphData
struct AverageGraphData: Codable {
    let graphPricingDataWithPercentages: [GraphPricingDataWithPercentage]?
    let graphPricingDataLength: Int?
    let averageIntervalPriceYAxis: AverageIntervalPriceYAxis?
    let percentageYAxis: PercentageYAxis?
    let currentTenureCarPrices: CurrentTenureCarPricesLive?

}

// MARK: - AverageIntervalPriceYAxis
struct AverageIntervalPriceYAxis: Codable {
    let minAveragePrice, maxAveragePrice: Int?
}

// MARK: - GraphPricingDataWithPercentage
struct GraphPricingDataWithPercentage: Codable {
    let totalPrice, totalRecords, averagePrice: Int?
    let startDate, endDate, graphPricingDataWithPercentageStartDate, graphPricingDataWithPercentageEndDate,end_date,start_date: String?
    let percentageChange: Double?
}

// MARK: - PercentageYAxis
struct PercentageYAxis: Codable {
    let minPercentage, maxPercentage: Double?
}

// MARK: - FiltersApplied
struct FiltersApplied: Codable {
    let title, key, fieldType: String?
    let min, max: Int?
    let listOfValues: [String]?
}

// MARK: - Range
struct Range: Codable {
    let min, max: String?
}

