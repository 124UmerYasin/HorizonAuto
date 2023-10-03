//
//  getlistingresponsesModel.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 31/05/2023.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let getlistingresponses = try? JSONDecoder().decode(Getlistingresponses.self, from: jsonData)

import Foundation

// MARK: - Getlistingresponses
struct Getlistingresponses : Codable {
    let status: String?
    let statusCode: Int?
    let message: String?
    let data: GetlistingresponsesDataClass?
}

// MARK: - DataClass
struct GetlistingresponsesDataClass : Codable {
    let listing_id: [GetlistingresponsesListingID]?
}

// MARK: - ListingID
struct GetlistingresponsesListingID : Codable {
    let id: Int?
    let uuid: String?
    let car_year: String?
    let car_min_mileage, car_max_mileage: String?
    let car_mileage: String?
    let posterZip: String?
    let vin: String?
    let transmission_type: String?
    let listing_price: Int?
    let auction_result_price, auction_has_reserve, auction_result_status, auction_result_date: String?
    let images: [String]
    let carfax_accident_info, title_info: String?
    let car_make: GetlistingresponsesCarMake?
    let car_model: GetlistingresponsesCarModel?
    let car_generation: GetlistingresponsesCarGeneration?
    let car_sub_generation: GetlistingresponsesCarSubGeneration?
    let trim_definition: GetlistingresponsesTrimDefinition?
}

// MARK: - CarGeneration
struct GetlistingresponsesCarGeneration : Codable {
    let id: Int?
    let uuid, generation: String?
    let modelId: Int?
    let createdAt, updatedAt: String?
}

// MARK: - CarMake
struct GetlistingresponsesCarMake : Codable {
    let id: Int?
    let uuid, make, createdAt, updatedAt: String?
}

// MARK: - CarModel
struct GetlistingresponsesCarModel : Codable {
    let id: Int?
    let uuid, model: String?
    let modelId: Int?
    let createdAt, updatedAt: String?
}

// MARK: - CarSubGeneration
struct GetlistingresponsesCarSubGeneration : Codable {
    let id: Int?
    let uuid, sub_generation: String?
    let carGenerationId, modelId: Int?
    let engine_layout, createdAt, updatedAt: String?
}

// MARK: - TrimDefinition
struct GetlistingresponsesTrimDefinition : Codable {
    let id: Int?
    let uuid, car_trim, body_style, drive_type: String?
    let createdAt, updatedAt: String?
}
