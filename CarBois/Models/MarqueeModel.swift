//
//  MarqueeModel.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 02/03/2023.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let marqueeModel = try? JSONDecoder().decode(MarqueeModel.self, from: jsonData)

import Foundation

// MARK: - MarqueeModel
struct MarqueeModel: Codable {
    let status: String?
    let statusCode: Int?
    let message: String?
    let data: [MarqueeModelDatum]?
}

// MARK: - Datum
struct MarqueeModelDatum: Codable {
    let make: MarqueeModelMake?
    let model: MarqueeModelModel?
    let marketPricesAndVector: MarqueeModelMarketPricesAndVector?
}

// MARK: - Make
struct MarqueeModelMake: Codable {
    let id: Int?
    let uuid, make, createdAt, updatedAt: String?
}

// MARK: - MarketPricesAndVector
struct MarqueeModelMarketPricesAndVector: Codable {
    let currentMonthMarketAverage, perviousMonthMarketAverage: MarqueeModelMonthMarketAverage?
    let percentageChange: MarqueeModelPercentageChange?
}

// MARK: - MonthMarketAverage
struct MarqueeModelMonthMarketAverage: Codable {
    let sum, average, numDataPoints: Int?
}

// MARK: - PercentageChange
struct MarqueeModelPercentageChange: Codable {
    let percentage: Double?
    let magnitude: Int?
    let direction: String?
}

// MARK: - Model
struct MarqueeModelModel: Codable {
    let id: Int?
    let uuid, model: String?
    let makeId: Int?
    let createdAt, updatedAt: String?
}
