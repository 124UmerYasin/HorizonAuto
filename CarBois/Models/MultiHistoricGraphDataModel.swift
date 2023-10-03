//
//  MultiHistoricGraphDataModel.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 03/10/2022.
//

import Foundation

// MARK: - MultiHistoricGraphDataModel
struct MultiHistoricGraphDataModel : Codable {
    let status: String?
    let statusCode: Int?
    let message: String?
    let data: MultiHistoricGraphDataModelDataClass?
}

// MARK: - DataClass
struct MultiHistoricGraphDataModelDataClass: Codable  {
    let cars: [Car]?
    let filtersApplied: [MultiHistoricGraphDataModelFiltersApplied]?
    let historicGraphData: MultiHistoricGraphDataModelHistoricGraphData?
}

// MARK: - Car
struct Car: Codable  {
    let subGenerationId, trimDefinitionId: Int?
}

// MARK: - FiltersApplied
struct MultiHistoricGraphDataModelFiltersApplied: Codable  {
    let yearRange, priceRange, mileageRange: MultiHistoricGraphDataModelRange?
    let bodyStyles: [String]?
    let driveTypes: String?
}

// MARK: - Range
struct MultiHistoricGraphDataModelRange: Codable  {
    let min, max: String?
}

// MARK: - HistoricGraphData
struct MultiHistoricGraphDataModelHistoricGraphData: Codable  {
    let graphData: [GraphDatum]?
}

// MARK: - GraphDatum
struct GraphDatum: Codable  {
    let car: Car?
    let dataPoints: [MultiHistoricGraphDataModelDataPoint]?
    let dataPointsLength: Int?
    let priceIntervalYAxis: MultiHistoricGraphDataModelPriceIntervalYAxis?
    let percentageYAxis: MultiHistoricGraphDataModelPercentageYAxis?
}

// MARK: - DataPoint
struct MultiHistoricGraphDataModelDataPoint: Codable  {
    let id: Int?
    let listing_title, listing_subtitle: String?
    let year: Int?
    let mileage, auction_result_price: String?
    let auction_result_status: String?
    let auction_result_date: String?
    let seller, location, vin, vin_8th_digit: String?
    let vin_12th_digit, car_type, listing_type: String?
    let sale_price, sale_date: String?
    let car_make: CarGenerationClass?
    let carMakeId: Int?
    let car_model: CarGenerationClass?
    let carModelId: Int?
    let car_generation: CarGenerationClass?
    let carGenerationId: Int?
    let car_sub_generation: HistoricCarSubGeneration?
    let carSubGenerationId: Int?
    let trimDefinitionId: Int?
    let trimDefinitionID: Int?
    let transmission_type, drive_type, carfax_info, title_info: String?
    let engine_layout: String?
    let images: [MultiHistoricGraphDataModelCarSubGeneration]?
    let bid_array: [HistoricBidArray]?
    let is_live: Bool?
    let max_bid, live_auction_scheduled_completion_time: String?
    let auction_actual_completion_time: String?
    let url: String?
    let createdAt, updatedAt: String?
    let trim_definition: MultiHistoricGraphDataModelTrimDefinition?
    let date: String?
    let price: Int?
    let simpleMovingAverage, percentageChange: Double?
}

// MARK: - BidArray
struct HistoricBidArray: Codable {
    let bid_time, bid_amount: String?
}
// MARK: - CarGenerationClass
struct CarGenerationClass: Codable {
    let id: Int?
    let generation, createdAt, updatedAt, make: String?
    let model: String?
}

// MARK: - CarSubGeneration
struct HistoricCarSubGeneration: Codable {
    let id: Int?
    let subGeneration, engineLayout, createdAt, updatedAt: String?
}

// MARK: - CarSubGeneration
struct MultiHistoricGraphDataModelCarSubGeneration: Codable  {
    let id: Int?
    let sub_generation: String?
    let createdAt, updatedAt: String?
    let image_url: String?
}

// MARK: - TrimDefinition
struct MultiHistoricGraphDataModelTrimDefinition: Codable  {
    let id: Int?
    let car_trim: String?
    let body_style: String?
    let drive_type: String?
    let createdAt: String?
    let updatedAt: String?
}

// MARK: - PercentageYAxis
struct MultiHistoricGraphDataModelPercentageYAxis: Codable  {
    let minPercentage, maxPercentage: Double?
}

// MARK: - PriceIntervalYAxis
struct MultiHistoricGraphDataModelPriceIntervalYAxis: Codable  {
    let minPrice, maxPrice: Int?
}
