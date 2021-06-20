import Foundation

protocol DeckBaseCompatible: Codable {
    var cards: [Card] {get set}
    var type: DeckType {get}
    var total: Int {get}
    var trump: Suit? {get}
}

enum DeckType:Int, CaseIterable, Codable {
    case deck36 = 36
}

struct Deck: DeckBaseCompatible {

    //MARK: - Properties

    var cards = [Card]()
    var type: DeckType
    var trump: Suit?

    var total:Int {
        return type.rawValue
    }
}

extension Deck {

    init(with type: DeckType) {
        self.type = type
        self.cards = self.createDeck(suits: Suit.allCases, values: Value.allCases)
    }

    public mutating func createDeck(suits:[Suit], values:[Value]) -> [Card] {
        for suit in suits {
            for value in values {
                self.cards.append(Card(suit: suit, value: value, isTrump: false))
            }
        }
        return self.cards
    }

    public mutating func shuffle() {
        self.cards.shuffle()
    }

    public mutating func defineTrump() {
        trump = cards[0].suit
        cards = cards.map { card in
            guard card.suit == trump else {
                return card
            }
            var newCard = card
            newCard.isTrump = true
            return newCard
        }
    }

    public mutating func initialCardsDealForPlayers(players: [Player]) {
        for player in players {
            let six = cards.dropFirst(6)
            cards.removeFirst(6)
            player.hand = Array(six)
        }
    }

    public func setTrumpCards(for suit:Suit) {

    }
}

