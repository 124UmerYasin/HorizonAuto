//
//  FeaturedListingModel.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 08/05/2023.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let featuredListingModel = try? JSONDecoder().decode(FeaturedListingModel.self, from: jsonData)

import Foundation

// MARK: - FeaturedListingModel
struct FeaturedListingModel: Codable {
    let status: String?
    let statusCode: Int?
    let message: String?
    let data: [FeaturedListingModelDatum]?
}

// MARK: - Datum
struct FeaturedListingModelDatum: Codable{
    let uuid: String?
    let carMakeId, carModelId, carGenerationId, carSubGenerationId: Int?
    let trimDefinitionId: Int?
    let car_year: String?
    let car_min_mileage, car_max_mileage: Int?
    let car_mileage : Int?
    let transmission_type: String?
    let images: [String]?
    let carfax_accident_info, title_info: String?
    let car_make: FeaturedListingModelCarMake?
    let car_model: FeaturedListingModelCarModel?
    let car_generation: FeaturedListingModelCarGeneration?
    let car_sub_generation: FeaturedListingModelCarSubGeneration?
    let trim_definition: FeaturedListingModelTrimDefinition?
}

// MARK: - CarGeneration
struct FeaturedListingModelCarGeneration: Codable {
    let id: Int?
    let uuid, generation: String?
    let modelId: Int?
    let createdAt, updatedAt: String?
}

// MARK: - CarMake
struct FeaturedListingModelCarMake: Codable {
    let id: Int?
    let uuid, make, createdAt, updatedAt: String?
}

// MARK: - CarModel
struct FeaturedListingModelCarModel: Codable {
    let id: Int?
    let uuid, model: String?
    let makeId: Int?
    let createdAt, updatedAt: String?
}

// MARK: - CarSubGeneration
struct FeaturedListingModelCarSubGeneration: Codable {
    let id: Int?
    let uuid, sub_generation: String?
    let carGenerationId, modelId: Int?
    let engineLayout, createdAt, updatedAt: String?
}

// MARK: - TrimDefinition
struct FeaturedListingModelTrimDefinition: Codable {
    let id: Int?
    let uuid, car_trim, body_style, drive_type: String?
    let createdAt, updatedAt: String?
}
