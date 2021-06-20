import Foundation

class CoronaClass {
 
    let n: Int
    var seats = [Int]()
    var newSeats: [Int?] = []

    init(n: Int) {
        self.n = n

        for _ in 0 ..< n {
            newSeats.append(nil)
        }
    }

    func seat() -> Int {
        if seats.isEmpty {
            seats.append(0)
            newSeats[0] = 0
            return 0
        }
        
        var midles: [(index: Int, max: Int)] = []
        for item in seats.enumerated() {
            if item.offset + 1 <= seats.count - 1,
               seats[item.offset + 1] - item.element == 1 {
                continue
            }
            if item.element != 0, item.offset == 0 {
                let newmidles = calculateMax(arr: midles, value: findMiddle(from: -1, to: item.element))
                midles = newmidles
                continue
            }
            if item.offset + 1 <= seats.count - 1 {
                let newmidles = calculateMax(arr: midles, value: findMiddle(from: item.element, to: seats[item.offset + 1]))
                midles = newmidles
            } else if item.element != n - 1 {
                let newmidles = calculateMax(arr: midles, value: findMiddle(from: item.element, to: n))
                midles = newmidles
            }
        }
        
        seats.append(midles[0].index)
        seats.sort(by: <)
        
        return midles[0].index
    }
    

    func leave(_ p: Int) {
        guard let index = seats.firstIndex(where: {p == $0}) else {
            return
        }
        seats.remove(at: index)
    }
    
    func findMiddle(from: Int, to: Int) -> (index: Int, max: Int) {
        if from < 0 {
            return (0, to)
        }
        if to == n {
            return (n-1, (n - 1) - from)
        }
        let result = (to - from)
        return ((result / 2 + from), result / 2)
    }
    
    func calculateMax(arr: [(index: Int, max: Int)], value: (index: Int, max: Int)) -> [(index: Int, max: Int)] {
        var result: [(index: Int, max: Int)] = []
        if arr.isEmpty {
            result.append(value)
            return result
        }
        
        if let first = arr.first, first.max < value.max {
            result.removeAll()
            result.append(value)
        } else if let first = result.first, first.max == value.max {
            result.append(value)
        } else {
            return arr
        }
        
        return result
    }
}
