//
//  submitsaleListingModel.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 24/02/2023.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let submitsaleListingModel = try? JSONDecoder().decode(SubmitsaleListingModel.self, from: jsonData)

import Foundation

// MARK: - SubmitsaleListingModel
struct SubmitsaleListingModel:Codable {
    let status: String?
    let statusCode: Int?
    let message: String?
    let data: SubmitsaleListingModelDataClass?
}

// MARK: - DataClass
struct SubmitsaleListingModelDataClass:Codable {
    let listing_id: String?
}



