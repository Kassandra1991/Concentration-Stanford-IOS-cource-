//
//  Concentration.swift
//  Concentration
//
//  Created by MacBook Pro on 16.11.21.
//

import Foundation

//public API
struct Concentration {
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    }
                    else {
                        return nil
                    }
                }
            }
          return foundIndex
        }
        set (newValue) {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.choosesCard (at: \(index)): choosen index not in the card")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //chech if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                
           }
                else {
                //either no cards or 2 cards are fase up

                indexOfOneAndOnlyFaceUpCard = index

            }
            
        }
    }
    init(numberOfPairCard: Int) {
        assert(numberOfPairCard > 0, "Concentartion.init(\(numberOfPairCard)): you must have at least one pair of cards")
       
        for _ in 1...numberOfPairCard {
            
        let card = Card()
            
            cards += [card, card]
        }
        cards.shuffle()
    }
}
