//
//  HomeCardetailModel.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 12/05/2023.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let homecardetailModel = try? JSONDecoder().decode(HomecardetailModel.self, from: jsonData)

import Foundation

// MARK: - HomecardetailModel
struct HomecardetailModel : Codable {
    let status: String?
    let statusCode: Int?
    let message: String?
    let data: HomecardetailModelDataClass?
}

// MARK: - DataClass
struct HomecardetailModelDataClass : Codable {
    let carDetails: HomecardetailModelCarDetails?
}

// MARK: - CarDetails
struct HomecardetailModelCarDetails : Codable {
    let id, trimDefinitionId: Int?
    let car_year: Int?
    let car_min_mileage, car_max_mileage: Int?
    let car_mileage: Int?
    let specialOptions: [String]?
    let dealerOrPrivate, listingTimeline, posterEmail, posterZip: String?
    let vin: String?
    let transmission_type, car_type, for_sale_type: String?
    let listing_price: Int?
    let auction_result_price, auction_has_reserve, auction_result_status, auction_result_date: String?
    let sale_date: String?
    let exterior_color, interior_color,listing_description: String?
    let images: [String]?
    let carfax_accident_info, title_info: String?
    let car_make: HomecardetailModelCarMake?
    let car_model: HomecardetailModelCarModel?
    let car_generation: HomecardetailModelCarGeneration?
    let car_sub_generation: HomecardetailModelCarSubGeneration?
    let trim_definition: HomecardetailModelTrimDefinition?
}

// MARK: - CarGeneration
struct HomecardetailModelCarGeneration : Codable {
    let id: Int?
    let uuid, generation: String?
    let modelID: Int?
    let createdAt, updatedAt: String?
}

// MARK: - CarMake
struct HomecardetailModelCarMake : Codable {
    let id: Int?
    let uuid, make, createdAt, updatedAt: String?
}

// MARK: - CarModel
struct HomecardetailModelCarModel : Codable {
    let id: Int?
    let uuid, model: String?
    let makeId: Int?
    let createdAt, updatedAt: String?
}

// MARK: - CarSubGeneration
struct HomecardetailModelCarSubGeneration : Codable {
    let id: Int?
    let uuid, sub_generation: String?
    let carGenerationId, modelId: Int?
    let engine_layout, createdAt, updatedAt: String?
}

// MARK: - TrimDefinition
struct HomecardetailModelTrimDefinition : Codable {
    let id: Int?
    let uuid, car_trim, body_style, drive_type: String?
    let createdAt, updatedAt: String?
}
