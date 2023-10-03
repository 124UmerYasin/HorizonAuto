//
//  contactbuyerModel.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 27/02/2023.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let contactbuyerModel = try? JSONDecoder().decode(ContactbuyerModel.self, from: jsonData)

import Foundation

// MARK: - ContactbuyerModel
struct ContactbuyerModel:Codable {
    let status: String?
    let statusCode: Int?
    let message: String?
    let data: ContactbuyerModelDataClass?
}

// MARK: - DataClass
struct ContactbuyerModelDataClass:Codable {
    let createdListingResponseId, relatedListingUUID: String?
    let allListingsRelatedToRelatedListing: [String]?
}
