//
//  submitBuyListingModel.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 24/02/2023.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let submitBuyListingModel = try? JSONDecoder().decode(SubmitBuyListingModel.self, from: jsonData)

import Foundation

// MARK: - SubmitBuyListingModel
struct SubmitBuyListingModel:Codable {
    let status: String?
    let statusCode: Int?
    let message: String?
    let data: SubmitBuyListingModelDataClass?
}

// MARK: - DataClass
struct SubmitBuyListingModelDataClass:Codable {
    let listing_id: String?
}
