import Foundation

private class Trie {

    let rootNode: TrieNode
    var words: Set<String> = []

    init(rootNode: TrieNode = TrieNode(value: nil)) {
        self.rootNode = rootNode
    }
    
    func insert(_ word: String) {
        var currentNode = rootNode

        for character in word {
            if let childNode = currentNode.children[character] {
                currentNode = childNode
            } else {
                let childNode = currentNode.createChild(for: character)
                currentNode = childNode
            }
        }

        currentNode.isNodeUsedAsEnd = true

        words.insert(word)
    }
    
    func search(_ word: String) -> Bool {
        var currentNode = rootNode

        for character in word {
            if let childNode = currentNode.children[character] {
                currentNode = childNode
            } else {
                return false
            }
        }

        return currentNode.isNodeUsedAsEnd
    }
    
    func startsWith(_ prefix: String) -> Bool {
        var currentNode = rootNode

        for character in prefix {
            if let childNode = currentNode.children[character] {
                currentNode = childNode
            } else {
                return false
            }
        }

        return true
    }
}

private class TrieNode {
    let value: Character?
    var children: [Character: TrieNode]
    var isNodeUsedAsEnd: Bool
    weak var parent: TrieNode?

    var isLastNode: Bool {
        return children.isEmpty
    }

    init(value: Character?) {
        self.value = value
        self.children = [:]
        self.isNodeUsedAsEnd = false
    }

    func createChild(for value: Character) -> TrieNode {
        let childNode = TrieNode(value: value)
        childNode.parent = self
        children[value] = childNode

        return childNode
    }
}

public class Solution208 {
    public static func run() {
        let trie = Trie()
        trie.insert("apple")
        print(trie.search("apple"))  // return True
        print(trie.search("app"))    // return False
        print(trie.startsWith("app")) // return True
        trie.insert("app")
        print(trie.search("app"))
    }
}


