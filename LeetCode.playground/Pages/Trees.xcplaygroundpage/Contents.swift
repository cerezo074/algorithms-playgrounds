//: [Previous](@previous)

import Foundation

//: ![Problem description](236.Lowest_Common_Ancestor_of_a_Binary_Tree.png)
// URL: //https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-tree/

let (firstExampleRootNode, firstExampleTargetNode1, firstExampleTargetNode2) = Solution236.example1()

print(
    Solution236.lowestCommonAncestor(
        firstExampleRootNode,
        firstExampleTargetNode1,
        firstExampleTargetNode2
    )?.value ?? -1 // Must return 3
)

let (secondExampleRootNode, secondExampleTargetNode1, secondExampleTargetNode2) = Solution236.example2()

print(
    Solution236.lowestCommonAncestor(
        secondExampleRootNode,
        secondExampleTargetNode1,
        secondExampleTargetNode2
    )?.value ?? -1 // Must return 3
)

let (thirdExampleRootNode, thirdExampleTargetNode1, thirdExampleTargetNode2) = Solution236.example3()

print(
    Solution236.lowestCommonAncestor(
        thirdExampleRootNode,
        thirdExampleTargetNode1,
        thirdExampleTargetNode2
    )?.value ?? -1 // Must return 1
)

//: [Next](@next)
