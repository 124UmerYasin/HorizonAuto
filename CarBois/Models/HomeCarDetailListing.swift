//
//  HomeCarDetailListing.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 15/05/2023.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let homeCarDetailListing = try? JSONDecoder().decode(HomeCarDetailListing.self, from: jsonData)

import Foundation

// MARK: - HomeCarDetailListing
struct HomeCarDetailListing : Codable {
    let status: String?
    let statusCode: Int?
    let message: String?
    let data: HomeCarDetailListingDataClass?
}

// MARK: - DataClass
struct HomeCarDetailListingDataClass : Codable {
    let listing_id: [HomeCarDetailListingListingID]?
}

// MARK: - ListingID
struct HomeCarDetailListingListingID : Codable {
    let id: Int?
    let uuid: String?
    let car_year : Int?
    let car_min_mileage, car_max_mileage, car_mileage: Int?
    let posterZip: String?
    let vin: String?
    let transmission_type: String?
    let listing_price: Int?
    let auction_result_price, auction_has_reserve, auction_result_status, auction_result_date: String?
    let images: [String]?
    let carfax_accident_info: String?
    let title_info: String?
    let car_make: HomeCarDetailListingCarMake?
    let car_model: HomeCarDetailListingCarModel?
    let car_generation: HomeCarDetailListingCarGeneration?
    let car_sub_generation: HomeCarDetailListingCarSubGeneration?
    let trim_definition: HomeCarDetailListingTrimDefinition?
}

// MARK: - CarGeneration
struct HomeCarDetailListingCarGeneration : Codable {
    let id: Int?
    let uuid, generation: String?
    let modelId: Int?
    let createdAt: String?
    let updatedAt: String?
}

// MARK: - CarMake
struct HomeCarDetailListingCarMake : Codable {
    let id: Int?
    let uuid: String?
    let make: String?
    let createdAt: String?
    let updatedAt: String?
}

// MARK: - CarModel
struct HomeCarDetailListingCarModel : Codable {
    let id: Int?
    let uuid, model: String?
    let makeId: Int?
    let createdAt: String?
    let updatedAt: String?
}
// MARK: - CarSubGeneration
struct HomeCarDetailListingCarSubGeneration : Codable {
    let id: Int?
    let uuid, sub_generation: String?
    let carGenerationId, modelId: Int?
    let engine_layout: String?
    let createdAt: String?
    let updatedAt: String?
}

// MARK: - TrimDefinition
struct HomeCarDetailListingTrimDefinition : Codable {
    let id: Int?
    let uuid: String?
    let car_trim: String?
    let body_style: String?
    let drive_type: String?
    let createdAt: String?
    let updatedAt: String?
}
