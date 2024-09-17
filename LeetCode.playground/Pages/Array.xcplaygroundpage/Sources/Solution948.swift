import Foundation

public class Solution948 {
    public static func bagOfTokensScore(_ tokens: [Int], _ fixedPower: Int) -> Int {
        var score = 0
        let sortedTokens = tokens.sorted()
        var leftIndex = 0
        var rightIndex = tokens.count - 1
        var power = fixedPower

        while (leftIndex < rightIndex) {
            if power >= sortedTokens[leftIndex] {
                power -= sortedTokens[leftIndex]
                score += 1
                leftIndex += 1
//                print("Face up: \(score), \(power), (\(leftIndex), \(rightIndex))")
            } else if score >= 1 {
                score -= 1
                power += sortedTokens[rightIndex]
                rightIndex -= 1
//                print("Face down: \(score), \(power), (\(leftIndex), \(rightIndex))")
            } else {
                leftIndex += 1
                rightIndex -= 1
//                print("Skip")
            }
        }

        if leftIndex >= 0, leftIndex <= tokens.count - 1, power >= sortedTokens[leftIndex] {
            power -= sortedTokens[leftIndex]
            score += 1
            leftIndex += 1
//            print("Face up: \(score), \(power), (\(leftIndex), \(rightIndex))")
        }

        return score
    }
}
