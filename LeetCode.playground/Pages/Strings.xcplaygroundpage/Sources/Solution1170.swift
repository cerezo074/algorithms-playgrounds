import Foundation

public class Solution1170 {
    public static func numSmallerByFrequency(_ queries: [String], _ words: [String]) -> [Int] {
        let processedQueries = queries.map { smallestLexicographicallyFrecuency(word: $0) }
        let processedWords = words.map { smallestLexicographicallyFrecuency(word: $0) }.sorted()
        var answers: [Int] = []

        for processedQuery in processedQueries {
            if let foundIndex = getIndexWithBinarySearch(processedWords, processedQuery) {
                var startIndex = foundIndex
                let lastIndex = processedWords.count
                var realFoundIndex: Int? = nil
                
                while startIndex < lastIndex {
                    if processedWords[startIndex] > processedQuery {
                        realFoundIndex = startIndex
                        break
                    }

                    startIndex += 1
                }

                if let realFoundIndex {
                    answers.append(lastIndex - realFoundIndex)
                } else {
                   answers.append(0)
                }
            } else {
                let answer = processedWords.filter { processedQuery < $0 }.count
                answers.append(answer)
            }
        }

        return answers
    }

    private static func getIndexWithBinarySearch(_ sortedList: [Int], _ target: Int) -> Int? {
        var leftIndex = 0
        var rightIndex = sortedList.count - 1
        
        if rightIndex == 0 {
            return sortedList[0] == target ? 0 : nil
        }

        while leftIndex <= rightIndex {
            let midIndex = leftIndex + ((rightIndex - leftIndex) / 2)

            if sortedList[midIndex] == target  {
                return midIndex
            } else if sortedList[midIndex] > target {
                rightIndex = midIndex - 1
            } else {
                leftIndex = midIndex + 1
            }
        }

        return nil
    }

    private static func smallestLexicographicallyFrecuency(word: String) -> Int {
        var lowerCharacter: Character?
        var characterFrecuencies: [Character: Int] = [:]

        for character in word {
            if let tempLowerCharacter = lowerCharacter {
                if character <= tempLowerCharacter {
                    lowerCharacter = character
                }
            } else {
                lowerCharacter = character
            }

            if let frecuency = characterFrecuencies[character] {
                characterFrecuencies[character] = frecuency + 1
            } else {
                characterFrecuencies[character] = 1
            }
        }

        guard let lowerCharacter else {
            return 0
        }

        return characterFrecuencies[lowerCharacter] ?? 0
    }
}
