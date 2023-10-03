//
//  contactSellerModel.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 27/02/2023.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let contactSellerModel = try? JSONDecoder().decode(ContactSellerModel.self, from: jsonData)

import Foundation

// MARK: - ContactSellerModel
struct ContactSellerModel:Codable {
    let status: String?
    let statusCode: Int?
    let message: String?
    let data: ContactSellerModelDataClass?
}

// MARK: - DataClass
struct ContactSellerModelDataClass:Codable {
    let createdListingResponseId, relatedListingUUID: String?
    let allListingsRelatedToRelatedListing: [String]?
}
