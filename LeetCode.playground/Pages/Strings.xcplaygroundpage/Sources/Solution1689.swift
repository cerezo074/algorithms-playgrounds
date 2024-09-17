import Foundation

public class Solution1689 {
    static public func minPartitions(_ n: String) -> Int {
        var maxDigitNumber = 0

        for char in n {
            guard let integer = Int(String(char)) else {
                continue
            }

            guard integer > maxDigitNumber else {
                continue
            }

            maxDigitNumber = integer
        }

        return maxDigitNumber
    }
}
