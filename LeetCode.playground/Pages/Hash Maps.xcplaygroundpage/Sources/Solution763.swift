import Foundation

public class Solution763 {
    public static func partitionLabels(_ s: String) -> [Int] {
        var endIndex: Int?
        var startIndex: Int?
        var groups: [Int] = []
        var totalItemInGroup = 0
        var lastCharacterPosition: [Character: Int] = [:]
        let array = Array(s)

        for currentIndex in 0..<s.count {
            let character = array[currentIndex]

            totalItemInGroup += 1

            if startIndex == nil {
                startIndex = currentIndex
            }

            if lastCharacterPosition[character] == nil, let lastOcurrenceIndexForCharacter = getLastOcurrenceIndex(for: character, from: currentIndex, on: array) {

                lastCharacterPosition[character] = lastOcurrenceIndexForCharacter

                if let unwrappedEndIndex = endIndex, lastOcurrenceIndexForCharacter > unwrappedEndIndex {
                    endIndex = lastOcurrenceIndexForCharacter
                } else if endIndex == nil {
                    endIndex = lastOcurrenceIndexForCharacter
                }

            } else if currentIndex == endIndex  {

                if startIndex != nil {
                    groups.append(totalItemInGroup)
                }

                startIndex = nil
                endIndex = nil
                totalItemInGroup = 0
            }

            if endIndex == nil, startIndex != nil {
                groups.append(1)
                totalItemInGroup = 0
                startIndex = nil
                endIndex = nil
            }
        }

        return groups
    }
}

func getLastOcurrenceIndex(for targetCharacter: Character, from currentIndex: Int, on array: [Character]) -> Int? {
    let nextIndex = (currentIndex + 1)

    guard nextIndex < array.count else {
        return nil
    }

    var lastOcurrenceIndex: Int? = nil
    
    for index in nextIndex..<array.count {
        if array[index] == targetCharacter {
            lastOcurrenceIndex = index
        }
        /*
        Accessing the string has a time penalty, that makes the time complexity increase so much compared with array.
        if word.character(at: index) == targetCharacter {
            lastOcurrenceIndex = index
        }
        */
    }

    return lastOcurrenceIndex
}

extension String {
    func character(at position: Int) -> Character? {
        guard position >= 0, position < count else { return nil }
        let index = self.index(startIndex, offsetBy: position)
        return self[index]
    }
}
