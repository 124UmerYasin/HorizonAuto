//
//  AverageGraphFiltersList.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 02/11/2022.
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let averageGraphFiltersList = try? newJSONDecoder().decode(AverageGraphFiltersList.self, from: jsonData)

import Foundation

// MARK: - AverageGraphFiltersList
struct AverageGraphFiltersList: Codable {
    let status: String?
    let statusCode: Int?
    let message: String?
    let data: AverageGraphFiltersListDataClass?
}

// MARK: - DataClass
struct AverageGraphFiltersListDataClass: Codable {
    let filtersApplied: [AverageGraphFiltersListFiltersApplied]?
    let averageGraphFilters: [AverageGraphFilter]?
    let sortBy: [SortBy]?
    let appliedSort: String?

}

// MARK: - AverageGraphFilter
struct AverageGraphFilter: Codable {
    let title, key, fieldType: String?
    let min, max: Int?
    let listOfValues: [ListOfValue]?
}

// MARK: - ListOfValue
struct ListOfValue: Codable {
    let name: String?
    let count: Int?
}

// MARK: - FiltersApplied
struct AverageGraphFiltersListFiltersApplied: Codable {
    let title, key, fieldType: String?
    let min, max: Int?
    let listOfValues: [String]?
}
// MARK: - SortBy
struct SortBy: Codable {
    let key, value: String?
}
