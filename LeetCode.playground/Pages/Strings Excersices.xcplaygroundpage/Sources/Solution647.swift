import Foundation

public class Solution647 {
    public static func countSubstrings(_ s: String) -> Int {
            let s = Array(s)
    var count = 0
    for i in 0..<s.count {
        count += countPalindromicSubstring(s, i, i)
        count += countPalindromicSubstring(s, i, i + 1)
    }
    return count
    }
}

func countPalindromicSubstring(_ s: [Character], _ left: Int, _ right: Int) -> Int {
    var count = 0
    var left = left
    var right = right
    while left >= 0 && right < s.count && s[left] == s[right] {
        count += 1
        left -= 1
        right += 1
    }
    return count
}
