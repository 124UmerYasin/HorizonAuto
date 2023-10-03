//
//  MultiHistoricGraphFiltersList.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 08/11/2022.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let multiHistoricGraphFiltersList = try? newJSONDecoder().decode(MultiHistoricGraphFiltersList.self, from: jsonData)

import Foundation

// MARK: - MultiHistoricGraphFiltersList
struct MultiHistoricGraphFiltersList: Codable {
    let status: String?
    let statusCode: Int?
    let message: String?
    let data: MultiHistoricGraphFiltersListDataClass?
}

// MARK: - DataClass
struct MultiHistoricGraphFiltersListDataClass: Codable {
    let cars: [MultiHistoricGraphFiltersListCar]?
    let filtersApplied : [MultiHistoricGraphFiltersListFiltersAppliedlist]?
    let historicGraphFilters: [MultiHistoricGraphFiltersListFiltersApplied]?
    let sortBy: [SortBy]?
    let appliedSort: String?
}

// MARK: - Car
struct MultiHistoricGraphFiltersListCar: Codable {
    let subGenerationId: Int?
    let trimDefinitionId: Int?
}

// MARK: - FiltersApplied
struct MultiHistoricGraphFiltersListFiltersApplied: Codable {
    let title, key: String?
    let fieldType: String?
    let min, max: Int?
    let listOfValues: [MultiHistoricGraphFiltersListListOfValue]?
}

// MARK: - ListOfValue
struct MultiHistoricGraphFiltersListListOfValue: Codable {
    let name: String?
    let count: Int?
}

struct MultiHistoricGraphFiltersListFiltersAppliedlist: Codable {
    let title, key, fieldType: String?
    let min, max: Int?
    let listOfValues: [String]?
}
