//
//  Concentration.swift
//  concentration
//
//  Created by Alfly on 2020/9/15.
//  Copyright © 2020 Alfly. All rights reserved.
//

import Foundation

struct Card
{
    var indentifier: Int
    var isFaceUp = false
    var isMatched = false
    
    static var identifierFactory = 0
    static func genUniqueIdentifier()->Int{
        identifierFactory += 1
        return identifierFactory
    }
    init(){
        self.indentifier = Card.genUniqueIdentifier()
    }
}

class Concentratioin
{
    var cards: [Card]
    var indexOfOneAndOnlyFaceUpCard: Int?
    init(numberOfPairsOfCards: Int){
        self.cards = [Card]()
        for _ in 0..<numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        //Shuffle the cards
        for _ in cards.indices{
            let index = Int(arc4random_uniform(UInt32(cards.count)))
            let card = cards.remove(at: index)
            cards.append(card)
        }
    }
    //Choose the cards
    func chooseCard(at index : Int){
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                if cards[matchIndex].indentifier == cards[index].indentifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            }else{
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
}
