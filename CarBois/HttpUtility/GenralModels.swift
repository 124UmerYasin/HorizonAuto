//
//  GenralModels.swift
//  CarBois
//
//  Created by Umer Yasin on 20/09/2022.
//

import Foundation

struct CustomError: LocalizedError {
    var description: String?

    init(description: String) {
        self.description = description
    }
}

