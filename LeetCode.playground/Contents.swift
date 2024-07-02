import UIKit

/**
 Problem
 
 #imageLiteral(resourceName: "3110.Score of a String")
 
 */

class Solution {
    func scoreOfString(_ s: String) -> Int {
        if s.count == 1 {
            return Int(s[s.startIndex].asciiValue ?? 0)
        }

        var previousCharacter: Character? = nil
        var total: Int = 0

        for currentCharacter in s {
            if let previousCharacter {
                total += Pair(left: previousCharacter, right: currentCharacter).sum
            }
            
            previousCharacter = currentCharacter
        }
        
        return total
    }
}

struct Pair {
    let left: Character
    let right: Character?

    var sum: Int {
        guard let leftValue = left.asciiValue else {
            return 0
        }

        guard let rightValue = right?.asciiValue else {
            return Int(leftValue)
        }

        return abs(Int(leftValue) - Int(rightValue))
    }
}

let test = Solution()
print(test.scoreOfString("zaz"))
