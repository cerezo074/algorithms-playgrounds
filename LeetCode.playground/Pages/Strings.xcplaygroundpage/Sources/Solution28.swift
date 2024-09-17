import Foundation

public class Solution28 {
    public static func strStr(_ haystack: String, _ needle: String) -> Int {
        guard haystack.count >= needle.count else {
            return -1
        }

        let haystackLastIndex = haystack.count - 1

        for (outerIndex, _) in haystack.enumerated() {
            if let shortHaystack = haystack.getString(from: outerIndex, to: haystackLastIndex),
                iterateStringsForward(shortHaystack, needle) {
                return outerIndex
            }
        }

        return -1
    }
}

func iterateStringsForward(_ haystack: String, _ needle: String) -> Bool {
    if haystack[haystack.startIndex] == needle[needle.startIndex] {
        if needle.count > 1,
            let shortNeedle = needle.removeFirstCharacter() {
            
            if haystack.count > 1, let shortHaystack = haystack.removeFirstCharacter() {
                return iterateStringsForward(shortHaystack, shortNeedle)
            } else {
                return false
            }

        } else {
            return true
        }
    } else {
        return false
    }
}

extension String {

    func getString(from start: Int, to end: Int) -> String? {
        if start < 0 || start >= count || end < 0 || end >= count || start > end {
            return nil
        }
        return String(self[self.index(self.startIndex, offsetBy: start)..<self.index(self.startIndex, offsetBy: end + 1)])
    }

    func removeFirstCharacter() -> String? {
        return isEmpty ? nil : String(self.dropFirst())
    }

}
