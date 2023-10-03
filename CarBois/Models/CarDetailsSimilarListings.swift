//
//  CarDetailsSimilarListings.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 07/11/2022.
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let carDetailsSimilarListings = try? newJSONDecoder().decode(CarDetailsSimilarListings.self, from: jsonData)

import Foundation

// MARK: - CarDetailsSimilarListings
struct CarDetailsSimilarListings:Codable {
    let status: String?
    let statusCode: Int?
    let message: String?
    let data: CarDetailsSimilarListingsDataClass?
}

// MARK: - DataClass
struct CarDetailsSimilarListingsDataClass:Codable {
    let id: Int?
    let filtersApplied: [CarDetailsSimilarListingsFiltersApplied]?
    let similarLiveListings: CarDetailsSimilarListingsSimilarLiveListings?
}

// MARK: - FiltersApplied
struct CarDetailsSimilarListingsFiltersApplied:Codable {
    let title, key, fieldType: String?
    let min, max: Int?
    let listOfValues: [String]?
}

// MARK: - SimilarLiveListings
struct CarDetailsSimilarListingsSimilarLiveListings:Codable {
    let similarListings: [CarDetailsSimilarListingsSimilarListing]?
    let totalRecords: Int?
}

// MARK: - SimilarListing
struct CarDetailsSimilarListingsSimilarListing:Codable {
    let id: Int?
    let listing_title, listing_subtitle: String?
    let year: Int?
    let mileage, auction_result_price: String?
    let auction_has_reserve: String?
    let auction_result_status: String?
    let auction_result_date, seller, location, vin: String?
    let vin_8th_digit, vin_12th_digit: String?
    let car_type: String?
    let listing_type: String?
    let sale_price, sale_date: String?
    let carMakeId:Int?
    let carModelId:Int?
    let carGenerationId:Int?
    let carSubGenerationId:Int?
    let trimDefinitionId:Int?

    let transmission_type: String?
    let drive_type: String?
    let carfax_info:String?
    let title_info:String?
    let engine_layout:String?
    let createdAt: String?
    let updatedAt: String?
    let bid_array:[HistoricBidArray]??
    let carMake, carGeneration: CarDetailsSimilarListingsCarSubGeneration?
    let carSubGeneration: CarDetailsSimilarListingsCarSubGeneration?
    let trimDefinition: CarDetailsSimilarListingsTrimDefinition?
    let images: [CarDetailsSimilarListingsCarGeneration]?
    let price: Int?
    let date: String?
    let is_live:Bool?
    let max_bid:String?
    let live_auction_scheduled_completion_time: String?
    let auction_actual_completion_time: String?
    let url: String?
}
// MARK: - CarGeneration
struct CarDetailsSimilarListingsCarGeneration:Codable {
    let id: Int?
    let generation: String?
    let createdAt, updatedAt: String?
    let make: String?
    let image_url: String?
}
// MARK: - CarSubGeneration
struct CarDetailsSimilarListingsCarSubGeneration:Codable {
    let id: Int?
    let subGeneration: String?
    let engineLayout: String?
    let createdAt: String?
    let updatedAt: String?
}
// MARK: - TrimDefinition
struct CarDetailsSimilarListingsTrimDefinition:Codable {
    let id: Int?
    let carTrim: String?
    let bodyStyle: String?
    let driveType: String?
    let createdAt: String?
    let updatedAt: String?
}
