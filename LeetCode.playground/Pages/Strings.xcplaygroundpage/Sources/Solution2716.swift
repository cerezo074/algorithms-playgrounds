import Foundation

public class Solution2716 {
    public static func minimizedStringLength(_ s: String) -> Int {
        var letters: [Letter] = s.map { Letter(character: $0) }
        var currentIndex: Int? = 0

        while let safeCurrentIndex = currentIndex {
            let targetLetter = letters[safeCurrentIndex]
            targetLetter.hasBeenSelected = true

            let (leftRange, rightRange) = makeRanges(from: safeCurrentIndex, on: letters)

            var closestLeftIndex: Int? = nil
            if let safeLeftRange = leftRange {
                for leftIndex in safeLeftRange.range {
                    if letters[leftIndex].character == targetLetter.character {
                        closestLeftIndex = leftIndex
                        break
                    }
                }
            }

            var closetRightIndex: Int? = nil
            if let safeRightRange = rightRange {
                for rightIndex in safeRightRange.range {
                    if letters[rightIndex].character == targetLetter.character {
                        closetRightIndex = rightIndex
                        break
                    }
                }
            }

            if let closetRightIndex {
                letters.remove(at: closetRightIndex)
            }

            if let closestLeftIndex {
                letters.remove(at: closestLeftIndex)
            }

            currentIndex = letters.firstIndex(where: { !$0.hasBeenSelected })
        }

        return letters.count
    }
}

struct CustomRange {
    let start: Int
    let end: Int
    let increment: Int

    var range: StrideThrough<Int> {
        return stride(from: start, through: end, by: increment)
    }
}

func makeRanges(from pivot: Int, on array: [Letter]) -> (left: CustomRange?, right: CustomRange?) {
    var leftRange: CustomRange? = nil
    
    if pivot > 0 {
        leftRange = CustomRange(start: pivot - 1, end: 0, increment: -1)
    }

    var rightRange: CustomRange? = nil
    let lastValidIndex = array.count - 1
    if pivot < lastValidIndex {
        rightRange = CustomRange(start: (pivot + 1), end: lastValidIndex, increment: 1)
    }

    return (leftRange, rightRange)
}

struct Index: Hashable {
    let value: Int

    init(value: Int) {
        self.value = value
    }
}

class Letter: CustomStringConvertible {
    let character: Character
    var hasBeenSelected: Bool

    init(character: Character) {
        self.character = character
        self.hasBeenSelected = false
    }
    
    var description: String {
        return "Letter(character: \(character), hasBeenSelected: \(hasBeenSelected))"
    }
}
