//
//  AverageGraphCarListModel.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 05/10/2022.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let averageGraphCarListModel = try? newJSONDecoder().decode(AverageGraphCarListModel.self, from: jsonData)

import Foundation

// MARK: - AverageGraphCarListModel
struct AverageGraphCarListModel: Codable {
    let status: String?
    let statusCode: Int?
    let message: String?
    var data: AverageGraphCarListModelDataClass?
}

// MARK: - DataClass
struct AverageGraphCarListModelDataClass: Codable {
    let filtersApplied: [AverageGraphCarListModelFiltersApplied]?
    let averageGraphCarsList: AverageGraphCarListModelAverageGraphCarsList?
}

// MARK: - AverageGraphCarsList
struct AverageGraphCarListModelAverageGraphCarsList: Codable {
    let currentTenureCarsList: [AverageGraphCarListModelCurrentTenureCarsList]?
    let totalRecords: Int?
}

// MARK: - CurrentTenureCarsList
struct AverageGraphCarListModelCurrentTenureCarsList: Codable {
    let id: Int?
    let listing_title, listing_sub_title: String?
    let year: Int?
    let mileage, auction_result_price: String?
    let auction_has_reserve: String?
    let auction_result_status: String?
    let auction_result_date: String?
    let carType: String?
    let listingType: String?
    let transmission_type: String?
    let drive_type: String?
    let carfax_info:String?
    let title_info:String?
    let engine_layout:String?
    let createdAt: String?
    let trimDefinition: AverageGraphCarListModelTrimDefinition?
    let images: [Image]?
    let date: String?
    let price: Int?
    let max_bid : String?

}

// MARK: - Image
struct Image: Codable {
    let id: Int?
    let image_url: String?
    let createdAt, updatedAt: String?
}

// MARK: - TrimDefinition
struct AverageGraphCarListModelTrimDefinition: Codable {
    let id: Int?
    let carTrim: String?
    let bodyStyle: String?
    let driveType: String?
    let createdAt, updatedAt: String?
}

// MARK: - FiltersApplied
struct AverageGraphCarListModelFiltersApplied: Codable {
    let yearRange, priceRange, mileageRange: AverageGraphCarListModelRange?
    let bodyStyles, driveTypes: String?
}

// MARK: - Range
struct AverageGraphCarListModelRange: Codable {
    let min, max: String?
}
