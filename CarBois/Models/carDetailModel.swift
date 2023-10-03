//
//  carDetailModel.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 10/10/2022.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let carDetailModel = try? newJSONDecoder().decode(CarDetailModel.self, from: jsonData)

import Foundation

// MARK: - CarDetailModel
struct CarDetailModel: Codable {
    let status: String?
    let statusCode: Int?
    let message: String?
    let data: CarDetailModelDataClass?
}

// MARK: - DataClass
struct CarDetailModelDataClass: Codable {
    let carDetails: CarDetailModelCarDetails?
    let priceVsMarket: CarDetailModelPriceVsMarket?
}

// MARK: - CarDetails
struct CarDetailModelCarDetails: Codable {
    let id: Int?
    let listing_title, listing_subtitle: String?
    let year: Int?
    let mileage, auction_result_price: String?
    let auction_has_reserve: String?
    let auction_result_status, auction_result_date, seller, location: String?
    let vin, vin_8th_digit, vin_12th_digit, car_type: String?
    let listing_type, sale_price, sale_date: String?
    let  createdAt, updatedAt: String?
    let images: [CarDetailModelCarGeneration]?
    let car_model,car_make, car_generation, car_sub_generation: CarDetailModelCarGeneration?
    let trim_definition: CarDetailModelTrimDefinition?
    let price: Int?
    let date: String?
    
    let transmission_type: String?
    let drive_type: String?
    let carfax_info: String?
    let title_info: String?
    let engine_layout: String?
    let max_bid:String?
    let is_live:Bool?
    let url:String?
}

// MARK: - CarGeneration
struct CarDetailModelCarGeneration: Codable {
    let id: Int?
    let generation, createdAt, updatedAt, make: String?
    let sub_generation: String?
    let model: String?
    let image_url: String?
}

// MARK: - TrimDefinition
struct CarDetailModelTrimDefinition: Codable {
    let id: Int?
    let car_trim, body_style, drive_type, createdAt: String?
    let updatedAt: String?
}

// MARK: - PriceVsMarket
struct CarDetailModelPriceVsMarket: Codable {
    let direction: String?
    let averagePrice, currentCarPrice, actualMileage, mileageCompared: Double?
    let sumOfAlikeCarsPrice, noOfAlikeCars: Int?
}
