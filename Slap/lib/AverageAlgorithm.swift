//
//  AverageAlgorithm.swift
//  Slap
//
//  Created by Gilles Wittenberg on 24/09/2023.
//

import Foundation

enum AverageAlgorithm: String, CaseIterable {
    
    case instant = "INSTANT"
    case average = "AVERAGE"
    case weighted = "WEIGHTED"
    
    static let `default` = Self.weighted
    
    static func fromKey (_ key: String) -> Self? {
        return self.allCases.first{ $0.rawValue == key }
    }
    
    func display () -> String {
        return self.rawValue.lowercased().capitalized
    }
}

func getUserSelectedAlgorithm () -> AverageAlgorithm {
    guard let key = UserDefaults.standard.string(forKey: "AVERAGING_ALGORITHM") else { return AverageAlgorithm.default }
    guard let algorithm = AverageAlgorithm.fromKey(key) else { return AverageAlgorithm.default }
    return algorithm
}

