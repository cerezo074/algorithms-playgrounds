//
//  Solution257.swift
//  
//
//  Created by Eli Pacheco Hoyos on 20/10/24.
//

public class Solution257 {
    func binaryTreePaths(_ root: TreeNode?) -> [String] {
        guard let root else {
            return []
        }

        let result = Result()
        insertPaths(for: root, with: [], on: result)

        return result.paths
    }

    func insertPaths(for node: TreeNode, with path: [String], on result: Result) {
        let newPath = path + [String(node.val)]

        if node.left != nil || node.right != nil {
            if let leftChild = node.left {
                insertPaths(for: leftChild, with: newPath, on: result)
            }

            if let rightChild = node.right {
                insertPaths(for: rightChild, with: newPath, on: result)
            }
        } else {
            let newStringPath = newPath.joined(separator: "->")
            result.paths.append(newStringPath)
        }
    }
    
    public static func run() {
        let solution = Solution257()
        
        let root1 = TreeNode(
            1,
            TreeNode(2, nil, TreeNode(5)),
            TreeNode(3)
        )
        print(solution.binaryTreePaths(root1))// ["1->2->5", "1->3"]
        
        let root2 = TreeNode(1)
        print(solution.binaryTreePaths(root2))// ["1"]
    }
}

class Result {
    var paths: [String]

    init(paths: [String] = []) {
        self.paths = paths
    }
}

class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    init() { self.val = 0; self.left = nil; self.right = nil; }
    init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}
