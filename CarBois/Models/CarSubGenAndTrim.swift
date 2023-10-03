//
//  CarSubGenAndTrim.swift
//  CarBois
//
//  Created by Umer Yasin on 20/09/2022.
//

import Foundation

// MARK: - CarSubGenAndTrim
struct CarSubGenAndTrim: Codable {
    let status: String?
    let statusCode: Int?
    let message: String?
    let data: CarMakeModelDataClass?
}

// MARK: - DataClass
struct CarMakeModelDataClass: Codable {
    let subGenerations: [CarMakeModelSubGeneration]?

    enum CodingKeys: String, CodingKey {
        case subGenerations = "sub_generations"
    }
}

// MARK: - SubGeneration
struct CarMakeModelSubGeneration: Codable {
    let id: Int?
    let subGeneration, createdAt, updatedAt: String?
    let average: Int?
    let actualAverage: Double?
    let trimDefinition: [CarMakeModelTrimDefinition]?
    let direction: String?

    enum CodingKeys: String, CodingKey {
        case id
        case subGeneration = "sub_generation"
        case createdAt, updatedAt, average
        case actualAverage = "actual_average"
        case trimDefinition = "trim_definition"
        case direction
    }
}

enum Direction: String, Codable {
    case decrease = "decrease"
    case increase = "increase"
}

// MARK: - TrimDefinition
struct CarMakeModelTrimDefinition: Codable {
    let id: Int?
    let carTrim: String?
    let bodyStyle: String?
    let driveType: String?
    let createdAt, updatedAt: String?
    let average: Int?
    let actualAverage: Double?
    let direction: String?

    enum CodingKeys: String, CodingKey {
        case id
        case carTrim = "car_trim"
        case bodyStyle = "body_style"
        case driveType = "drive_type"
        case createdAt, updatedAt, average
        case actualAverage = "actual_average"
        case direction
    }
}

enum BodyStyle: String, Codable {
    case any = "Any"
    case cabriolet = "Cabriolet"
    case coupe = "Coupe"
    case speedster = "Speedster"
    case targa = "Targa"
}

enum DriveType: String, Codable {
    case rearWheelDrive = "Rear Wheel Drive"
    case uncertain = "Uncertain"
}
