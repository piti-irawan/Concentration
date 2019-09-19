//
//  Concentration.swift
//  Concentration
//
//  Created by Piti Irawan on 2019/09/19.
//  Copyright © 2019 Piti Irawan. All rights reserved.
//

import Foundation

class Concentration {
    var flipCount = 0
    var score = 0
    
    private(set) var cards: [ConcentrationCard]
    private var seenIdentifiers: [Int]
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            let indices = cards.indices.filter({ cards[$0].isFaceUp })
            if indices.count == 1 {
                return indices.first
            } else {
                return nil
            }
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        flipCount = 0
        score = 0
        cards = [ConcentrationCard]()
        for _ in 1...numberOfPairsOfCards {
            let card = ConcentrationCard()
            cards += [card, card]
        }
        cards.shuffle()
        seenIdentifiers = [Int]()
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchedIndex = indexOfOneAndOnlyFaceUpCard {
                if matchedIndex != index {
                    // Two cards are face up; check if they match
                    if cards[matchedIndex].identifier == cards[index].identifier {
                        cards[matchedIndex].isMatched = true
                        cards[index].isMatched = true
                        score += 2
                    } else {
                        if seenIdentifiers.contains(cards[matchedIndex].identifier) {
                            score -= 1
                        } else {
                            seenIdentifiers += [cards[matchedIndex].identifier]
                        }
                        if seenIdentifiers.contains(cards[index].identifier) {
                            score -= 1
                        } else {
                            seenIdentifiers += [cards[index].identifier]
                        }
                    }
                    cards[index].isFaceUp = true
                    flipCount += 1
                } else {
                    // User touched the one card that was face up; do nothing
                }
            } else {
                // One card is face up
                indexOfOneAndOnlyFaceUpCard = index
                flipCount += 1
            }
        }
    }
}
