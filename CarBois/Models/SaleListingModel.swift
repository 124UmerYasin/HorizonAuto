//
//  SaleListingModel.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 23/02/2023.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let wantToSaleListingModel = try? JSONDecoder().decode(WantToSaleListingModel.self, from: jsonData)

import Foundation

// MARK: - WantToSaleListingModel
struct WantToSaleListingModel:Codable {
    let status: String?
    let statusCode: Int?
    let message: String?
    let data: WantToSaleListingModelDataClass?
}

// MARK: - DataClass
struct WantToSaleListingModelDataClass:Codable {
    let NumOfListings: Int?
    let listings: [WantToSaleListingModelListing]?
}

// MARK: - Listing
struct WantToSaleListingModelListing:Codable {
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
    let VIN: String?
    let car_year, car_mileage: Int?
    let exterior_color, interior_color: String?
    let transmission_type: String?
    let specialOptions: [String]?
    let dealerOrPrivate: String?
    let carfax_info: String?
    let TitleInfo: String?
    let posterEmail: String?
    let listingTimeline: String?
    let posterZip: String?
    let listing_description: String?
    let car_type: String?
    let for_sale_type: String?
    let posting_type: String?
    let drive_type: String?
    let engine_layout: String?
    let image: [String]?
    let listing_price : Int?
}

