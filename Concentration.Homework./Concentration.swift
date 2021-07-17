//
//  Concentration.swift
//  Concentration.Homework
//
//  Created by Vladimir Oleinikov on 16/5/21.
//

import Foundation

class Concentration {
	
	private(set) var deckOfCards = [Card]()
   
    private(set) var countOfFlips = 0
    private(set) var score = 0
    private var viewedCards: Set<Int> = []
    
    private struct GamePoints {
        static let bonusForMatch = 2
        static let penaltyForMissmatch = 1
    }
    
	private var indexOfOneAndOnlyFaceUpCard: Int? {
		get {
			var foundedIndex: Int?
			for index in deckOfCards.indices {
				if deckOfCards[index].isFaceUp  {
					guard foundedIndex == nil else { return nil }
					foundedIndex = index
				}
			}
			return foundedIndex
		}
		set {
			for index in deckOfCards.indices {
				deckOfCards[index].isFaceUp = (index == newValue)
			}
		}
				
	}
	
    func restartTheGame (){
        countOfFlips = 0
        score = 0
        viewedCards = []
        for index in deckOfCards.indices  {
            deckOfCards[index].isFaceUp = false
            deckOfCards[index].isMatched = false
        }
        deckOfCards.shuffle()
    }
    
	func pickACard(at index: Int) {
		assert(deckOfCards.indices.contains(index), "Concentration.chooseCard(at: \(index)) : Choosen index out of range")
		if !deckOfCards[index].isMatched {
            countOfFlips += 1
			if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {

				if deckOfCards[matchIndex].identifier == deckOfCards[index].identifier {
         //cards match
					deckOfCards[matchIndex].isMatched = true
					deckOfCards[index].isMatched = true
                    
                    // Increase the score
                    score += GamePoints.bonusForMatch
                } else {
         //cards didn't match
                    if viewedCards.contains(index) {
                        score -= GamePoints.penaltyForMissmatch
                    }
                    if viewedCards.contains(matchIndex) {
                        score -= GamePoints.penaltyForMissmatch
                    }
                    viewedCards.insert(index)
                    viewedCards.insert(matchIndex)
                }
				deckOfCards[index].isFaceUp = true
                
			} else {
				indexOfOneAndOnlyFaceUpCard = index
			}
		}
	}
	

    
	init(numberOfPairsOfCards: Int) {
		assert(numberOfPairsOfCards > 0,
               "Concentration.init(\(numberOfPairsOfCards)) : You have less then one pair of cards.")
		for _ in 1...numberOfPairsOfCards {
			let card = Card()
			deckOfCards += [card, card]
		}
        deckOfCards.shuffle()
	}
}

extension Array {
    mutating func shuffle() {
        if count < 2 { return }
        
        for i in indices.dropLast() {
            let diff = distance(from: i, to: endIndex)
            let j = index(i, offsetBy: diff.arc4random)
            swapAt(i, j)
        }
    }
}
 

