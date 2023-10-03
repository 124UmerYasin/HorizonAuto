//
//  fileuploadlinkModel.swift
//  Horizon Auto
//
//  Created by Umer Yasin on 27/02/2023.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let fileuploadlinkModel = try? JSONDecoder().decode(FileuploadlinkModel.self, from: jsonData)

import Foundation

// MARK: - FileuploadlinkModel
struct FileuploadlinkModel:Codable {
    let status: String?
    let statusCode: Int?
    let message: String?
    let data: FileuploadlinkModelDataClass?
}

// MARK: - DataClass
struct FileuploadlinkModelDataClass:Codable {
    let url: String?
}
