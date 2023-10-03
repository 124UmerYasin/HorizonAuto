//
//  HomeCarDetailGraph.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 15/05/2023.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let homeCarDetailGraph = try? JSONDecoder().decode(HomeCarDetailGraph.self, from: jsonData)

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let homeCarDetailGraph = try? JSONDecoder().decode(HomeCarDetailGraph.self, from: jsonData)

import Foundation

// MARK: - HomeCarDetailGraph
struct HomeCarDetailGraph : Codable{
    let status: String?
    let statusCode: Int?
    let message: String?
    let data: HomeCarDetailGraphDataClass?
}

// MARK: - DataClass
struct HomeCarDetailGraphDataClass : Codable {
    let firstDataSet: [HomeCarDetailGraphDataSet]?
    let firstDataSetLength: Int?
    let secondDataSet: [HomeCarDetailGraphDataSet]?
    let secondDataSetLength: Int?
    let priceIntervalYAxis: HomeCarDetailGraphPriceIntervalYAxis?
    //let mileageIntervalXAxis: HomeCarDetailGraphMileageIntervalXAxis?
}

// MARK: - DataSet
struct HomeCarDetailGraphDataSet : Codable {
    let id: Int?
    let car_mileage : Int?
    let car_year : Int?
    let uuid : String?
    let specialOptions: [String]?
    let dealerOrPrivate, posterZip, vin, transmission_type: String?
    let car_type: String?
    let listing_price: Int?
    let auction_result_price, auction_has_reserve, auction_result_status, auction_result_date: String?
    let exterior_color, interior_color, carfax_accident_info, title_info: String?
    let is_live: Bool?
    let car_make: HomeCarDetailGraphCarMake?
    let car_model: HomeCarDetailGraphCarModel?
    let car_generation: HomeCarDetailGraphCarGeneration?
    let car_sub_generation: HomeCarDetailGraphCarSubGeneration?
    let trim_definition: HomeCarDetailGraphTrimDefinition?
}

// MARK: - CarGeneration
struct HomeCarDetailGraphCarGeneration : Codable {
    let id: Int?
    let uuid, generation: String?
    let modelId: Int?
    let createdAt, updatedAt: String?
}

// MARK: - CarMake
struct HomeCarDetailGraphCarMake : Codable {
    let id: Int?
    let uuid, make, createdAt, updatedAt: String?
}

// MARK: - CarModel
struct HomeCarDetailGraphCarModel : Codable {
    let id: Int?
    let uuid, model: String?
    let makeId: Int?
    let createdAt, updatedAt: String?
}

// MARK: - CarSubGeneration
struct HomeCarDetailGraphCarSubGeneration : Codable {
    let id: Int?
    let uuid, sub_generation: String?
    let carGenerationId, modelIs: Int?
    let engine_layout, createdAt, updatedAt: String?
}

// MARK: - TrimDefinition
struct HomeCarDetailGraphTrimDefinition : Codable {
    let id: Int?
    let uuid, car_trim, body_style, drive_type: String?
    let createdAt, updatedAt: String?
}

// MARK: - MileageIntervalXAxis
struct HomeCarDetailGraphMileageIntervalXAxis : Codable {
    let minMileage, maxMileage: String?
}

// MARK: - PriceIntervalYAxis
struct HomeCarDetailGraphPriceIntervalYAxis : Codable {
    let minPrice, maxPrice: Int?
}
