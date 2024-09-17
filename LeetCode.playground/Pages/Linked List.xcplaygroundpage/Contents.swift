//: [Previous](@previous)

import Foundation

//: ![Problem description](148.Sort_List.png)
// URL: https://leetcode.com/problems/sort-list

//let node4 = ListNode(4)
//let node2 = ListNode(2)
//let node1 = ListNode(1)
//let node3 = ListNode(3)
//
//node4.next = node2
//node2.next = node1
//node1.next = node3
//
//print(Solution148.sortList(node4)) // [1,2,3,4]

let head = ListNode(-1)
let node5 = ListNode(5)
let node3 = ListNode(3)
let node4 = ListNode(4)
let node0 = ListNode(0)

head.next = node5
node5.next = node3
node3.next = node4
node4.next = node0

print(Solution148.sortList(head)) // [-1,0,3,4,5]

//: [Next](@next)
