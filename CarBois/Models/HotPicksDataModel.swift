//
//  HotPicksDataModel.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 07/10/2022.
//

import Foundation

// MARK: - HotPicksDataModel
struct HotPicksDataModel: Codable {
    let status: String?
    let statusCode: Int?
    let message: String?
    let data: HotPicksDataModelDataClass?
}

// MARK: - DataClass
struct HotPicksDataModelDataClass: Codable {
    let hotPicks: [HotPick]?
}

// MARK: - HotPick
struct HotPick: Codable {
    let subGen, trim, make: String?
    let makeId, modelId, generationId, subGenerationId: Int?
    let trimDefinitionId: Int?
    let image: String?
    let percentageChange: HotPickPercentageChange?
}

// MARK: - HotPickPercentageChange
struct HotPickPercentageChange: Codable {
    let currentMonthMarketAverage, perviousMonthMarketAverage: HotPicksDataModelMonthMarketAverage?
    let percentageChange: HotPicksDataModelPercentageChangePercentageChange?
}

// MARK: - MonthMarketAverage
struct HotPicksDataModelMonthMarketAverage: Codable {
    let sum, average, numDataPoints: Int?
}

// MARK: - PercentageChangePercentageChange
struct HotPicksDataModelPercentageChangePercentageChange: Codable {
    let percentage: Double?
    let magnitude: Int?
    let direction: String?
}

