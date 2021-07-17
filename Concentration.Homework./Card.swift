//
//  Card.swift
//  Concentration.Homework
//
//  Created by Vladimir Oleinikov on 16/5/21.
//

import Foundation

struct Card {
	
	
	var isFaceUp = false
	var isMatched = false
	var identifier: Int
	
	private static var identifierFactory = 0
	
	private static func getUniqueIdentifier() -> Int {
		identifierFactory += 1
		return identifierFactory
	}
	
	init() {
		self.identifier = Card.getUniqueIdentifier()
	}
}
