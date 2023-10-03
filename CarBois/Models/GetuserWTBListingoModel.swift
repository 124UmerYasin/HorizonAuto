//
//  GetuserWTBListingoModel.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 11/05/2023.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let getuserWTBListingoModel = try? JSONDecoder().decode(GetuserWTBListingoModel.self, from: jsonData)

import Foundation

// MARK: - GetuserWTBListingoModel
struct GetuserWTBListingoModel : Codable {
    let status: String?
    let statusCode: Int?
    let message: String?
    let data: GetuserWTBListingoModelDataClass?
}

// MARK: - DataClass
struct GetuserWTBListingoModelDataClass : Codable {
    let listing_id: [GetuserWTBListingoModelListingID]?
}

// MARK: - ListingID
struct GetuserWTBListingoModelListingID : Codable {
    let id: Int?
    let uuid: String?
    let car_year: String?
    let car_min_mileage, car_max_mileage: Int?
    let car_mileage: Int?
    let posterZip: String?
    let vin: String?
    let transmission_type: String?
    let listing_price: Int?
    let auction_result_price, auction_has_reserve, auction_result_status, auction_result_date: String?
    let images: [String]?
    let carfax_accident_info, title_info: String?
    let car_make: GetuserWTBListingoModelCarMake?
    let car_model: GetuserWTBListingoModelCarModel?
    let car_generation: GetuserWTBListingoModelCarGeneration?
    let car_sub_generation: GetuserWTBListingoModelCarSubGeneration?
    let trim_definition: GetuserWTBListingoModelTrimDefinition?
}

// MARK: - CarGeneration
struct GetuserWTBListingoModelCarGeneration : Codable {
    let id: Int?
    let uuid, generation: String?
    let modelId: Int?
    let createdAt, updatedAt: String?
}

// MARK: - CarMake
struct GetuserWTBListingoModelCarMake : Codable {
    let id: Int?
    let uuid, make, createdAt, updatedAt: String?
}

// MARK: - CarModel
struct GetuserWTBListingoModelCarModel : Codable {
    let id: Int?
    let uuid, model: String?
    let makeId: Int?
    let createdAt, updatedAt: String?
}

// MARK: - CarSubGeneration
struct GetuserWTBListingoModelCarSubGeneration : Codable {
    let id: Int?
    let uuid, sub_generation: String?
    let carGenerationId, modelId: Int?
    let engine_layout, createdAt, updatedAt: String?
}

// MARK: - TrimDefinition
struct GetuserWTBListingoModelTrimDefinition : Codable{
    let id: Int?
    let uuid, car_trim, body_style, drive_type: String?
    let createdAt, updatedAt: String?
}
