//
//  ViewController.swift
//  concentration
//
//  Created by Apple50 on 2020/9/14.
//  Copyright © 2020 Alfly. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var flipCountLabel: UILabel!
    var flipCount = 0 {          //variable monitor
        didSet{
            flipCountLabel.text = "Flips Count: \(flipCount)"
        }
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    var emojiChoices = ["❤️","🚫","⚠️","🔔","🎵","▶️"]
    lazy var game = Concentratioin(numberOfPairsOfCards: (cardButtons.count + 1) / 2)

    @IBAction func touchCard(_ sender: UIButton){
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender){
            //flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("chosed card is not in cardButtons")
        }
    }
    
    func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for:card), for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.4323849684, green: 0.6503807107, blue: 0.3569661856, alpha: 1): #colorLiteral(red: 0.462877559, green: 0.6220414207, blue: 0.8837841053, alpha: 1)
                if card.isMatched{
                    button.setTitle("", for: .normal)
                }
            }else{
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.4323849684, green: 0.6503807107, blue: 0.3569661856, alpha: 1) :#colorLiteral(red: 0.9701360175, green: 1, blue: 0.9846823924, alpha: 1)
            }
        }
    }
    
    var emoji = [Int: String]()
    func emoji(for card: Card)->String{
        if emoji[card.indentifier] == nil && emojiChoices.count > 0{
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.indentifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.indentifier] ?? "?"
    }
    
//    func flipCard(withEmoji emoji : String, on button : UIButton){
//        if(button.currentTitle == emoji){
//            button.setTitle("", for: .normal)
//            button.backgroundColor = UIColor.orange
//        }else{
//            button.setTitle(emoji, for: .normal)
//            button.backgroundColor = UIColor.white
//        }
//    }
}

