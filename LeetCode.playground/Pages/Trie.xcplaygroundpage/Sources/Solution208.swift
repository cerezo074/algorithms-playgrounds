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
    
    func delete(word: String) -> Bool {
        guard words.contains(word) else {
            return false
        }
        
        var currentNode = rootNode
        
        for character in word {
            if let node = currentNode.children[character] {
                currentNode = node
            } else {
                return false
            }
        }
        
        guard currentNode.isNodeUsedAsEnd else {
            return false
        }
        
        currentNode.isNodeUsedAsEnd = false
        
        while currentNode.isLastNode {
            if let parent = currentNode.parent,
                let currentValue = currentNode.value {
                parent.children.removeValue(forKey: currentValue)
                currentNode = parent
            } else {
                break
            }
        }
        
        words.remove(word)
        
        return true
    }
    
    func printAll() {
        print("Words: \(words)\nTrie:")
        printNodes(node: rootNode, lenght: 0)
    }
    
    private func printNodes(node: TrieNode, lenght: Int)  {
        if let value = node.value {
            var output = "\(String(repeating: "  ", count: lenght))\(lenght).\(value)"
            
            if node.isNodeUsedAsEnd {
                output += "        isNodeUsedAsEnd"
            }
            
            print(output)
        } else {
            print("Root Node")
        }
        
        for child in node.children {
            printNodes(node: child.value, lenght: (lenght + 1))
        }
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
    
    public static func runDelete() {
        let trie = Trie()
        trie.insert("cama")
        trie.insert("camaroncito")
        trie.insert("camarote")
        trie.insert("camabaja")
        print("\n ---- Print initial Trie ----\n")
        trie.printAll()
        print("\n ---- Delete 'camaro', result: \(trie.delete(word: "camaro")) ----\n")
        trie.printAll()
        print("\n ---- Delete 'camaroncito', result: \(trie.delete(word: "camaroncito")) ----\n")
        trie.printAll()
        print("\n ---- Delete 'cama', result: \(trie.delete(word: "cama")) ----")
        trie.printAll()
        print("\n ---- Delete 'camarote', result: \(trie.delete(word: "camarote")) ----\n")
        trie.printAll()
    }
}


