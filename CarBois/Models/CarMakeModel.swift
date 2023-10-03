//
//  CarMakeModel.swift
//  CarBois
//
//  Created by Umer Yasin on 20/09/2022.
//

import Foundation

// MARK: - CarMakeModel
struct CarMakeModel: Codable {
    let status: String?
    let statusCode: Int?
    let message: String?
    var data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    var carMake: [CarMake]?
    var carModels: [Model]?
    var carGenerations: [CarGeneration]?

    enum CodingKeys: String, CodingKey {
        case carMake = "car_make"
        case carModels = "car_models"
        case carGenerations = "car_generations"
    }
}

// MARK: - CarMake
struct CarMake: Codable {
    let id: Int?
    let make: String?
    var models: [Model]?
}

// MARK: - Model
struct Model: Codable {
    let id: Int?
    let model: String?
    var carGenerations: [CarGeneration]?

    enum CodingKeys: String, CodingKey {
        case id, model
        case carGenerations = "car_generations"
    }
}

// MARK: - CarGeneration
struct CarGeneration: Codable {
    let id: Int?
    let generation: String?
    let carSubGenerations: [CarSubGeneration]?

    enum CodingKeys: String, CodingKey {
        case id, generation
        case carSubGenerations = "car_sub_generations"
    }
}

// MARK: - CarSubGeneration
struct CarSubGeneration: Codable {
    let id: Int?
    let subGeneration: String?
    let trimDefinition: [TrimDefinition]?

    enum CodingKeys: String, CodingKey {
        case id
        case subGeneration = "sub_generation"
        case trimDefinition = "trim_definition"
    }
}

// MARK: - TrimDefinition
struct TrimDefinition: Codable {
    let id: Int?
    let carTrim: String?

    enum CodingKeys: String, CodingKey {
        case id
        case carTrim = "car_trim"
    }
}
