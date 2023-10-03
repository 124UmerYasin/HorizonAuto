//
//  HistoricGraphDataModel.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 30/09/2022.
//
// let historicGraphDataModel = try? newJSONDecoder().decode(HistoricGraphDataModel.self, from: jsonData)

import Foundation

// MARK: - HistoricGraphDataModel
struct HistoricGraphDataModel : Decodable {
    let status: String?
    let statusCode: Int?
    let message: String?
    let data: HistoricGraphDataModelDataClass?
}

// MARK: - DataClass
struct HistoricGraphDataModelDataClass : Decodable {
    let subGenerationID, trimDefinitionID: Int?
    let filtersApplied: [HistoricGraphDataModelFiltersApplied]?
    let historicGraphData: HistoricGraphData?
}

// MARK: - FiltersApplied
struct HistoricGraphDataModelFiltersApplied : Decodable {
    let title, key, fieldType: String?
    let min, max: Int?
    let listOfValues: [String]?
}

// MARK: - Range
struct HistoricGraphDataModelRange : Decodable {
    let min, max: String?
}

// MARK: - HistoricGraphData
struct HistoricGraphData : Decodable {
    let dataPoints: [DataPoint]?
    let dataPointsLength: Int?
    let priceIntervalYAxis: PriceIntervalYAxis?
    let percentageYAxis: HistoricGraphDataModelPercentageYAxis?
}

// MARK: - DataPoint
struct DataPoint : Decodable {
    let id: Int?
    let title, subTitle: String?
    let year: Int?
    let mileage, auctionResultPrice: String?
    let auctionResultStatus: String?
    let auctionResultDate: String?
    let listingType: String?
    let transmissionType: String?
    let driveType: String?
    let createdAt: String?
    let carSubGeneration: HistoricGraphDataModelCarSubGeneration?
    let trimDefinition: HistoricGraphDataModelTrimDefinition?
    let images: [CarSubGeneration]?
    let date: String?
    let price: Int?
    let simpleMovingAverage, percentageChange: Double?
}

// MARK: - CarSubGeneration
struct HistoricGraphDataModelCarSubGeneration : Decodable {
    let id: Int?
    let subGeneration: String?
    let createdAt, updatedAt: String?
    let imageURL: String?
}


// MARK: - TrimDefinition
struct HistoricGraphDataModelTrimDefinition : Decodable {
    let id: Int?
    let carTrim: String?
    let bodyStyle: String?
    let driveType: String?
    let createdAt: String?
    let updatedAt: String?
}


// MARK: - PercentageYAxis
struct HistoricGraphDataModelPercentageYAxis : Decodable {
    let minPercentage: Double?
    let maxPercentage: Double?
}

// MARK: - PriceIntervalYAxis
struct PriceIntervalYAxis : Decodable {
    let minPrice, maxPrice: Int?
}
