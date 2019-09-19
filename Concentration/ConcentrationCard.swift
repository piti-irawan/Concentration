//
//  ConcentrationCard.swift
//  Concentration
//
//  Created by Piti Irawan on 2019/09/19.
//  Copyright © 2019 Piti Irawan. All rights reserved.
//

import Foundation

struct ConcentrationCard: Hashable, CustomStringConvertible {
    private static var identifierFactory = 0
    
    var identifier: Int
    var isFaceUp: Bool
    var isMatched: Bool
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    static func == (lhs: ConcentrationCard, rhs: ConcentrationCard) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    var description: String {
        return "\(identifier)"
    }

    init() {
        identifier = ConcentrationCard.getUniqueIdentifier()
        isFaceUp = false
        isMatched = false
    }
}
