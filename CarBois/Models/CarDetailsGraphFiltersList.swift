//
//  CarDetailsGraphFiltersList.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 09/11/2022.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let carDetailsGraphFiltersList = try? newJSONDecoder().decode(CarDetailsGraphFiltersList.self, from: jsonData)

import Foundation

// MARK: - CarDetailsGraphFiltersList
struct CarDetailsGraphFiltersList: Codable {
    let status: String?
    let statusCode: Int?
    let message: String?
    let data: CarDetailsGraphFiltersListDataClass?
}

// MARK: - DataClass
struct CarDetailsGraphFiltersListDataClass: Codable {
    let id: Int?
    let filtersApplied : [FiltersAppliedCarDetailListing]?
    let carDetailsFilters: [CarDetailsGraphFiltersListCarDetailsFilter]?
    let sortBy: [SortBy]?
    let appliedSort: String?
}

// MARK: - CarDetailsFilter
struct CarDetailsGraphFiltersListCarDetailsFilter: Codable {
    let title, key: String?
    let fieldType: String?
    let min, max: Int?
    let listOfValues: [CarDetailsGraphFiltersListListOfValue]?
}
// MARK: - ListOfValue
struct CarDetailsGraphFiltersListListOfValue: Codable {
    let name: String?
    let count: Int?
}
// MARK: - FiltersApplied
struct FiltersAppliedCarDetailListing: Codable {
    let title, key, fieldType: String?
    let min, max: Int?
    let listOfValues: [String]?
}

