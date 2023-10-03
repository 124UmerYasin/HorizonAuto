//
//  ModelPricingDataModel.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 04/10/2022.
//

import Foundation

// MARK: - ModelPricingDataModel
struct ModelPricingDataModel: Codable {
    let status: String?
    let statusCode: Int?
    let message: String?
    let data: ModelPricingDataModelDataClass?
}

// MARK: - DataClass
struct ModelPricingDataModelDataClass: Codable {
    let make, model: String?
    let marketPricesAndVector: MarketPricesAndVector?
    let dateObj: DateObj?
}

// MARK: - DateObj
struct DateObj: Codable {
    let current: Current?
    let previous: Previous?
}

// MARK: - Current
struct Current: Codable {
    let start, end, formattedCurrentDate: String?
}

// MARK: - Previous
struct Previous: Codable {
    let start, end, formattedPreviousDate: String?
}

// MARK: - MarketPricesAndVector
struct MarketPricesAndVector: Codable {
    let currentMonthMarketAverage, perviousMonthMarketAverage: MonthMarketAverage?
    let percentageChange: PercentageChange?
}

// MARK: - MonthMarketAverage
struct MonthMarketAverage: Codable {
    let sum, average, numDataPoints: Int?
}

// MARK: - PercentageChange
struct PercentageChange: Codable {
    let percentage: Double?
    let magnitude: Int?
    let direction: String?
}
