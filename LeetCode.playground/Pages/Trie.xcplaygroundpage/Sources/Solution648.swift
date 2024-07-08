import Foundation

public class Solution648 {
    public static func replaceWords(_ dictionary: [String], _ sentence: String) -> String {
        let prefixDictionary = cleanDuplicatedRoots(on: dictionary)
        var words = sentence.split(separator: " ").map { String($0) }
        let trie = Trie()
        
        for prefix in prefixDictionary {
            trie.insert(prefix)
        }

        for index in 0..<words.count {
            if let foundPrefix = trie.getPrefix(for: words[index]) {
                words[index] = foundPrefix
            }
        }

        return words.joined(separator: " ")
    }
}

private class TrieNode {
    var value: Character
    var children: [Character: TrieNode]
    var isEndOfWord: Bool
    
    init(value: Character) {
        self.value = value
        self.children = [:]
        self.isEndOfWord = false
    }
}

private class Trie {
    private let root: TrieNode
    
    init() {
        // Root node has an empty character and is not the end of any word
        self.root = TrieNode(value: " ")
    }
    
    // Insert a word into the Trie
    func insert(_ word: String) {
        var currentNode = root
        
        for char in word {
            if currentNode.children[char] == nil {
                // Create a new TrieNode if it doesn't exist
                currentNode.children[char] = TrieNode(value: char)
            }
            // Move to the next node
            currentNode = currentNode.children[char]!
        }
        
        // Mark the end of the word
        currentNode.isEndOfWord = true
    }
    
    // Check if the Trie contains a word
    func contains(word: String) -> Bool {
        var currentNode = root
        
        for char in word {
            if let nextNode = currentNode.children[char] {
                currentNode = nextNode
            } else {
                // Character not found
                return false
            }
        }
        
        // Check if the current node is marked as the end of the word
        return currentNode.isEndOfWord
    }
    
    // Check if the Trie contains any word with the given prefix
    func startsWith(prefix: String) -> Bool {
        var currentNode = root
        
        for char in prefix {
            if let nextNode = currentNode.children[char] {
                currentNode = nextNode
            } else {
                // Prefix not found
                return false
            }
        }
        
        // If we successfully navigate through the prefix, return true
        return true
    }

    func getPrefix(for word: String) -> String? {
        var currentNode = root
        var foundPrefix = ""

        for element in word {
            if let nextNode = currentNode.children[element] {
                foundPrefix += String(nextNode.value)

                if nextNode.isEndOfWord  {
                    return foundPrefix
                } else {
                    currentNode = nextNode
                }
            } else {
                return nil
            }
        }

        return nil
    }

    func findWords(for prefix: String) -> [String] {
        var currentNode = root

        for element in prefix {
            if let nextNode = currentNode.children[element] {
                currentNode = nextNode
            } else {
                return []
            }
        }

        let foundWords = getWords(from: currentNode, with: prefix)
        return foundWords
    }

    private func getWords(from node: TrieNode, with concatenatedWord: String) -> [String] {
        if node.isEndOfWord {
            return [concatenatedWord]
        }
            
        var moreConcatenatedWords: [String] = []
        
        for key in node.children.keys {
            if let childNode = node.children[key] {
                let currentWord = concatenatedWord + String(childNode.value)

                moreConcatenatedWords += getWords(from: childNode, with: currentWord)
            }
        }

        return moreConcatenatedWords
    }
}

func cleanDuplicatedRoots(on dictionary: [String]) -> Set<String> {
    var dictionarySet: Set<String> = []
    var wordsToRemove: Set<String> = []
    var outterIndex = 0

        while(outterIndex < dictionary.count) {
            let word = dictionary[outterIndex]
            dictionarySet.insert(word)

            if wordsToRemove.contains(word) {
                outterIndex += 1
                continue
            }

            var innerIndex = outterIndex + 1

            while (innerIndex < dictionary.count) {
                let nextWord = dictionary[innerIndex]

                if wordsToRemove.contains(nextWord) {
                    innerIndex += 1
                    continue
                }

                if word == nextWord {
                    wordsToRemove.insert(nextWord)
                } else if word.count < nextWord.count, isRootValid(word, on: nextWord) {
                    wordsToRemove.insert(nextWord)
                } else if nextWord.count < word.count, isRootValid(nextWord, on: word) {
                    wordsToRemove.insert(word)
                }

                innerIndex += 1
            }

            outterIndex += 1
        }

    return dictionarySet.filter { !wordsToRemove.contains($0) }
}

func isRootValid(_ root: String, on derivative: String) -> Bool {
    for (index, rootCharacter) in root.enumerated() {
        guard let derivativeCharacter = derivative.character(at: index) else {
            return false
        }

        guard derivativeCharacter == rootCharacter else {
            return false
        }
    }

    return true
}

extension String {

    func character(at index: Int) -> Character? {
        // Ensure the string is not nil and the index is within bounds
        guard index >= 0 && index < count else {
            return nil
        }
        
        // Get the String.Index for the specified integer index
        let stringIndex = self.index(startIndex, offsetBy: index)
        
        // Return the character at the specified index
        return self[stringIndex]
    }

}


