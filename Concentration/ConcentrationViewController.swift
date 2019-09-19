//
//  ViewController.swift
//  Concentration
//
//  Created by Piti Irawan on 2019/09/19.
//  Copyright © 2019 Piti Irawan. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    
    private var emojiChoices = "🦇😱🙀😈🎃👻🍭🍬🍎"
    private var emoji = [ConcentrationCard:String]()
    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            updateCardButtons()
        }
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card is not in cardButtons")
        }
    }
    
    @IBAction private func touchNewGameButton(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        updateFlipCountLabel()
        updateScoreLabel()
        updateCardButtons()
    }
    
    private func updateFlipCountLabel() {
        flipCountLabel.text = "Flips: \(game.flipCount)"
    }
    
    private func updateScoreLabel() {
        scoreLabel.text = "Score: \(game.score)"
    }
    
    private func updateCardButtons() {
        if cardButtons != nil {
            for index in cardButtons.indices {
                let card = game.cards[index]
                let button = cardButtons[index]
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: UIControl.State.normal)
                    button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                } else {
                    button.setTitle("", for: UIControl.State.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
                }
            }
        }
    }
    
    private func emoji(for card: ConcentrationCard) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: Int(arc4random_uniform(UInt32(emojiChoices.count))))
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
}
