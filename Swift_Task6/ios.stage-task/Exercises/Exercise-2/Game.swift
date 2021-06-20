//
//  Game.swift
//  DurakGame
//
//  Created by Дима Носко on 16.06.21.
//

import Foundation

protocol GameCompatible {
    var players: [Player] { get set }
}

struct Game: GameCompatible {
    var players: [Player]
}

extension Game {

    func defineFirstAttackingPlayer(players: [Player]) -> Player? {
        var result: Player?
        var count: Int?
        for player in players {
            let newCount = player.hand?.reduce(0, { $1.isTrump ? $0 + 1 : $0 + 0 }) ?? 0
            
            if let co = count {
                if newCount < co {
                    count = newCount
                    result = player
                }
            } else {
                result = player
                count = newCount
            }
        }
        return result
    }
}
