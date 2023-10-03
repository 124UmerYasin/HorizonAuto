//
//  getuserSaleListingoMdel.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 11/05/2023.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let getuserSaleListingoMdel = try? JSONDecoder().decode(GetuserSaleListingoMdel.self, from: jsonData)

import Foundation

// MARK: - GetuserSaleListingoMdel
struct GetuserSaleListingoMdel : Codable {
    let status: String?
    let statusCode: Int?
    let message: String?
    let data: GetuserSaleListingoMdelDataClass?
}

// MARK: - DataClass
struct GetuserSaleListingoMdelDataClass : Codable {
    let listing_id: [GetuserSaleListingoMdelListingID]?
}

// MARK: - ListingID
struct GetuserSaleListingoMdelListingID : Codable {
    let id: Int?
    let uuid: String?
    let car_year: Int?
    let car_min_mileage, car_max_mileage: Int?
    let car_mileage: Int?
    let posterZip, vin, transmission_type: String?
    let listing_price: Int?
    let auction_result_price, auction_has_reserve, auction_result_status, auction_result_date: String?
    let images: [String]?
    let carfax_accident_info, title_info: String?
    let car_make: GetuserSaleListingoMdelCarMake?
    let car_model: GetuserSaleListingoMdelCarModel?
    let car_generation: GetuserSaleListingoMdelCarGeneration?
    let car_sub_generation: GetuserSaleListingoMdelCarSubGeneration?
    let trim_definition: GetuserSaleListingoMdelTrimDefinition?
}

// MARK: - CarGeneration
struct GetuserSaleListingoMdelCarGeneration : Codable {
    let id: Int?
    let uuid, generation: String?
    let modelId: Int?
    let createdAt, updatedAt: String?
}

// MARK: - CarMake
struct GetuserSaleListingoMdelCarMake : Codable {
    let id: Int?
    let uuid, make, createdAt, updatedAt: String?
}

// MARK: - CarModel
struct GetuserSaleListingoMdelCarModel : Codable {
    let id: Int?
    let uuid, model: String?
    let makeId: Int?
    let createdAt, updatedAt: String?
}

// MARK: - CarSubGeneration
struct GetuserSaleListingoMdelCarSubGeneration : Codable {
    let id: Int?
    let uuid, sub_generation: String?
    let carGenerationId, modelId: Int?
    let engine_layout, createdAt, updatedAt: String?
}

// MARK: - TrimDefinition
struct GetuserSaleListingoMdelTrimDefinition : Codable {
    let id: Int?
    let uuid, car_trim, body_style, drive_type: String?
    let createdAt, updatedAt: String?
}
