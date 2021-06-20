//
//  Player.swift
//  DurakGame
//
//  Created by Дима Носко on 15.06.21.
//

import Foundation

protocol PlayerBaseCompatible {
    var hand: [Card]? { get set }
}

final class Player: PlayerBaseCompatible {
    var hand: [Card]?

    func checkIfCanTossWhenAttacking(card: Card) -> Bool {
        hand?.contains { $0.value == card.value } ?? false
    }

    func checkIfCanTossWhenTossing(table: [Card: Card]) -> Bool {
        let filterdKeys = table.keys.filter { card in
            hand?.contains { $0.value == card.value } ?? false
        }
        let filterdValues = table.values.filter { card in
            hand?.contains { $0.value == card.value } ?? false
        }
        return !filterdKeys.isEmpty || !filterdValues.isEmpty
        
    }
}
