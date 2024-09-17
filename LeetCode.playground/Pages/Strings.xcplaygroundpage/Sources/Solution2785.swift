import Foundation

public class Solution2785 {
    public static func sortVowels(_ s: String) -> String {
        var characters = Array(s)
        let vowels: Set<Character> = [
            Character("a"), Character("e"), Character("i"), Character("o"), Character("u"),
            Character("A"), Character("E"), Character("I"), Character("O"), Character("U")
        ]
        var ASCIIValues: [Pair] = []
        var targetIndexes: [Int] = []

        for (index, character) in characters.enumerated() {
            if vowels.contains(character), let asciiValue = character.asciiValue {
                ASCIIValues.append(
                    Pair(
                        ASCIIValue: asciiValue,
                        vowel: character
                    )
                )

                targetIndexes.append(index)
            }
        }

        let sortedASCIIValuesWithIndexes = ASCIIValues.sorted { $0.ASCIIValue < $1.ASCIIValue }
        let sortedTargetIndexes = targetIndexes.sorted { $0 < $1 }
        
        for (position, sortedIndex) in sortedTargetIndexes.enumerated() {
            characters[sortedIndex] = sortedASCIIValuesWithIndexes[position].vowel
        }

        return String(characters)
    }
}

struct Pair {
    let ASCIIValue: UInt8
    let vowel: Character
}
