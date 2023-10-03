//
//  wantToBuyListingModel.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 23/02/2023.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let wantToBuyListingModel = try? JSONDecoder().decode(WantToBuyListingModel.self, from: jsonData)

import Foundation

// MARK: - WantToBuyListingModel
struct WantToBuyListingModel: Codable {
    let status: String?
    let statusCode: Int?
    let message: String?
    let data: WantToBuyListingModelDataClass?
}

// MARK: - DataClass
struct WantToBuyListingModelDataClass: Codable {
    let numOfListings: Int?
    let listings: [WantToBuyListingModelListing]?

    enum CodingKeys: String, CodingKey {
        case numOfListings
        case listings
    }
}

// MARK: - Listing
struct WantToBuyListingModelListing: Codable {
    let uuid: String?
    let carMake: String?
    let carMakeId: Int?
    let carModel: String?
    let carModelId: Int?
    let carGeneration: String?
    let carGenerationId: Int?
    let carSubGeneration: String?
    let carSubGenerationId: Int?
    let trimDefinition: String?
    let trimDefinitionId: Int?
    let posting_type: String?
    let car_year: Int?
    let car_min_mileage, car_max_mileage: Int?
    let specialOptions: [String]?
    let dealerOrPrivate: String?
    let listingTimeline: String?
    let posterEmail: String?
    let posterZip: String?
    let transmission_type: String?
    let car_type: String?
    let for_sale_type: String?
    let exterior_color, interior_color: String?
    let driveType: String?
    let engine_layout: String?
    let image: [String]?
}
