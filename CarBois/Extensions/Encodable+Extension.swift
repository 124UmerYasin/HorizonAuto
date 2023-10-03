//
//  Encodable+Extension.swift
//  CarBois
//
//  Created by Umer Yasin on 20/09/2022.
//

import Foundation
import UIKit

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}


extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension Int{
    func formateCurrency(f: Int) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.minimumFractionDigits = 0
        let currentAveragePrice = numberFormatter.string(from: NSNumber(value: f))
        return currentAveragePrice ?? "Format Exception"
    }
}
