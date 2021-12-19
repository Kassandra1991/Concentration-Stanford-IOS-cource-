//
//  ViewController.swift
//  Concentration
//
//  Created by MacBook Pro on 14.11.21.
//

import UIKit


class ConcentrationViewController: UIViewController {

    private lazy var game = Concentration(numberOfPairCard: numberOfPairCard)
    
    var numberOfPairCard: Int {
            return (cardButtons.count + 1)/2
    }
    
    private (set) var flipCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 1, green: 0.4594762921, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        
        flipCountLabel.attributedText = attributedString
        
    }
    //private var emojiChoose = ["🐶","🦁","🐭","🐱","🦊", "🐻", "🐷", "🐮", "🐵", "🐝", "🐸","🐯", "🦀","🐌","🐠","🕷"]
    private var emojiChoose = "🐶🦁🐭🐱🦊🐻🐷🐮🐵🐝🐸🐯🦀🐌🐠🕷"
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoose.count > 0 {
            let randomStringIndex = emojiChoose.index(emojiChoose.startIndex, offsetBy: emojiChoose.count.arc4random)
            emoji[card] = String(emojiChoose.remove(at: randomStringIndex))
            
        }
        return emoji[card] ?? "?"
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    @IBAction private func touchCard(_ sender: UIButton) {
        
        flipCount += 1
        
        if let cardNumber = cardButtons.lastIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            
        }
        
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji (for: card), for: .normal)
                button.backgroundColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 0) : #colorLiteral(red: 1, green: 0.4594762921, blue: 0, alpha: 1)
            }
        }
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int( arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int( arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
    }
}
