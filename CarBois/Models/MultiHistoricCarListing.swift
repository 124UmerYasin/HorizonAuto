//
//  MultiHistoricCarListing.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 05/12/2022.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let carDetailsGraphFiltersList = try? newJSONDecoder().decode(CarDetailsGraphFiltersList.self, from: jsonData)

import Foundation

// MARK: - CarDetailsGraphFiltersList
struct MultiHistoricCarListing: Codable {
    let status: String?
    let statusCode: Int?
    let message: String?
    let data: MultiHistoricCarListingDataClass?
}

// MARK: - DataClass
struct MultiHistoricCarListingDataClass: Codable {
    let cars: [MultiHistoricCarListingCar]?
    let appliedSort: String?
//    let sortBy: [String]?
    let filtersApplied: [MultiHistoricCarListingFiltersApplied]?
    let matchingHistoricListings: MultiHistoricCarListingMatchingHistoricListings?
}

// MARK: - Car
struct MultiHistoricCarListingCar: Codable {
    let subGenerationID: Int?
}

// MARK: - FiltersApplied
struct MultiHistoricCarListingFiltersApplied: Codable {
    let title, key, fieldType: String?
    let min, max: Int?
    let listOfValues: [String]?
}

// MARK: - MatchingHistoricListings
struct MultiHistoricCarListingMatchingHistoricListings: Codable {
    let paginatedArr: [MultiHistoricCarListingPaginatedArr]?
    let paginatedArrLength, actualArrLength: Int?
}

// MARK: - PaginatedArr
struct MultiHistoricCarListingPaginatedArr: Codable {
    let id: Int?
    let uuid, listing_title, listing_subtitle: String?
    let year: Int?
    let mileage, auction_result_price: String?
    let auction_has_reserve: String?
    let auction_result_status: String?
    let auction_result_date, seller, location, vin: String?
    let car_type: String?
    let listing_type: String?
    let sale_price, sale_date: String?
    let car_make: MultiHistoricCarListingCarMake?
    let carMakeId: Int?
    let car_model: MultiHistoricCarListingCarModel?
    let carModelId: Int?
    let car_generation: MultiHistoricCarListingCarGeneration?
    let carGenerationId: Int?
    let car_sub_generation: MultiHistoricCarListingCarSubGeneration?
    let carSubGenerationId, trimDefinitionId: Int?
    let drive_type: String?
    let transmission_type: String?
    let carfax_info: String?
    let title_info: String?
    let engine_layout: String?
    let bid_array: [MultiHistoricCarListingBidArray]?
    let is_live: Bool?
    let max_bid: String?
    let url: String?
    let live_auction_scheduled_completion_time: String?
    let auction_actual_completion_time: String?
    let images: [MultiHistoricCarListingImage]?
    let trim_definition: MultiHistoricCarListingTrimDefinition?
    let price: Int?
    let date: String?

}

// MARK: - BidArray
struct MultiHistoricCarListingBidArray: Codable {
    let bid_time, bid_amount: String?
}

// MARK: - CarGeneration
struct MultiHistoricCarListingCarGeneration: Codable {
    let id: Int?
    let generation: String?
}

// MARK: - CarMake
struct MultiHistoricCarListingCarMake: Codable {
    let id: Int?
    let make: String?
}

// MARK: - CarModel
struct MultiHistoricCarListingCarModel: Codable {
    let id: Int?
    let model: String?
}

// MARK: - CarSubGeneration
struct MultiHistoricCarListingCarSubGeneration: Codable {
    let engine_layout: String?
    let id: Int?
    let sub_generation: String?
}

// MARK: - Image
struct MultiHistoricCarListingImage: Codable {
    let id: Int?
    let image_url: String?
}

// MARK: - TrimDefinition
struct MultiHistoricCarListingTrimDefinition: Codable {
    let body_style: String?
    let car_trim: String?
    let drive_type: String?
    let id: Int?

    
}
