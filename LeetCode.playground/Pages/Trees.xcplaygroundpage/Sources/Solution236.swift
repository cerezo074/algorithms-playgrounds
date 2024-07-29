import Foundation

public class Solution236 {
    public static func example1() -> (root: TreeNode, targetNode1: TreeNode, targetNode2: TreeNode) {
        let four = TreeNode(4)
        let seven = TreeNode(7)
        let two = TreeNode(2)
        two.left = seven
        two.right = four
        
        let five = TreeNode(5)
        let six = TreeNode(6)
        five.left = six
        five.right = two
        
        let zero = TreeNode(0)
        let eight = TreeNode(8)
        let one = TreeNode(1)
        one.left = zero
        one.right = eight
        
        let rootNode = TreeNode(3)
        rootNode.left = five
        rootNode.right = one
        
        return (rootNode, five, one)
    }
    
    public static func example2() -> (root: TreeNode, targetNode1: TreeNode, targetNode2: TreeNode) {
        let four = TreeNode(4)
        let seven = TreeNode(7)
        let two = TreeNode(2)
        two.left = seven
        two.right = four
        
        let five = TreeNode(5)
        let six = TreeNode(6)
        five.left = six
        five.right = two
        
        let zero = TreeNode(0)
        let eight = TreeNode(8)
        let one = TreeNode(1)
        one.left = zero
        one.right = eight
        
        let rootNode = TreeNode(3)
        rootNode.left = five
        rootNode.right = one
        
        return (rootNode, five, four)
    }
    
    public static func example3() -> (root: TreeNode, targetNode1: TreeNode, targetNode2: TreeNode) {
        let two = TreeNode(2)
        let rootNode = TreeNode(1)
        rootNode.left = two
        
        return (rootNode, rootNode, two)
    }
    
    public static func lowestCommonAncestor(_ root: TreeNode?, _ targetNode1: TreeNode?, _ targetNode2: TreeNode?) -> TreeNode? {
        guard let root = root, let targetNode1, let targetNode2 else {
           return nil
        }

        return inOrderTraversal(root, targetNode1, targetNode2)
    }

    static func inOrderTraversal(_ currentNode: TreeNode, _ targetNode1: TreeNode, _ targetNode2: TreeNode) -> TreeNode? {
        let isCurrentNodeATarget = currentNode.value == targetNode1.value || currentNode.value == targetNode2.value
        
        if isCurrentNodeATarget {
            return currentNode
        }

        var leftNodeResult: TreeNode? = nil
        
        if let leftChildNode = currentNode.left {
            leftNodeResult = inOrderTraversal(leftChildNode, targetNode1, targetNode2)
        }
        
        var rightNodeResult: TreeNode? = nil
        
        if let rightChildNode = currentNode.right {
            rightNodeResult = inOrderTraversal(rightChildNode, targetNode1, targetNode2)
        }

        // https://www.youtube.com/watch?v=13m9ZCB8gjw
        if rightNodeResult != nil, leftNodeResult != nil {
            return currentNode
        } else if rightNodeResult != nil {
            return rightNodeResult
        } else if leftNodeResult != nil {
            return leftNodeResult
        }

        return nil
    }
}

public class TreeNode {
    public var value: Int
    public var left: TreeNode?
    public var right: TreeNode?
    
    public init(_ value: Int) {
        self.value = value
        self.left = nil
        self.right = nil
    }
}
