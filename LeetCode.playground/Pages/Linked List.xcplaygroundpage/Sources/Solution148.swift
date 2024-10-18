import Foundation

public class ListNode: CustomStringConvertible {
    public var description: String {
        var text = "\(val)"
        var tempNode = self
        
        while let nextNode = tempNode.next {
            text += ", \(nextNode.val)"
            tempNode = nextNode
        }
        
        return text
    }
    
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

public class Solution148 {
    public static func sortList(_ head: ListNode?) -> ListNode? {
        guard let head else {
            return head
        }
        
        return splitList(head)
    }
    
    static func splitList(_ head: ListNode) -> ListNode {
        guard let (leftList, rightList) = splitNode(head) else {
            return head
        }
        
        let newLeftList = splitList(leftList)
        let newRightList = splitList(rightList)
        
        return mergeLists(newLeftList, newRightList)
    }
    
    static func mergeLists(_ leftList: ListNode, _ rightList: ListNode) -> ListNode {
        var initialNode = ListNode()
        var newNode = initialNode
        var lastLeftNode: ListNode? = leftList
        var lastRightNode: ListNode? = rightList
        
        while (lastLeftNode != nil && lastRightNode != nil) {
            let resultVal: Int
            var needsToDuplicate: Bool = false
            if lastLeftNode!.val < lastRightNode!.val {
                resultVal = lastLeftNode!.val
                lastLeftNode = lastLeftNode?.next
            } else if lastRightNode!.val < lastLeftNode!.val {
                resultVal = lastRightNode!.val
                lastRightNode = lastRightNode?.next
            } else {
                needsToDuplicate = true
                resultVal = lastLeftNode!.val
                lastLeftNode = lastLeftNode?.next
                lastRightNode = lastRightNode?.next
            }
            
            let resultNode = ListNode(resultVal)
            newNode.next = resultNode
            
            if needsToDuplicate {
                let clonedNode = ListNode(resultVal)
                resultNode.next = clonedNode
                newNode = clonedNode
            } else {
                newNode = resultNode
            }
        }
        
        if let lastLeftNode {
            let resultNode = ListNode(lastLeftNode.val)
            resultNode.next = lastLeftNode.next
            newNode.next = resultNode
        }
        
        if let lastRightNode {
            let resultNode = ListNode(lastRightNode.val)
            resultNode.next = lastRightNode.next
            newNode.next = resultNode
        }
        
        return initialNode.next!
    }
    
    static func printNode(_ node: ListNode) {
        var currentHead: ListNode? = node
        var size: Int = 0
        
        while currentHead != nil {
            print(currentHead?.val ?? "Invalid value")
            currentHead = currentHead?.next
            size += 1
        }
        
        print("On print, node size: \(size)")
    }
    
    static func splitNode(_ originalNode: ListNode?) -> (leftList: ListNode, rightList: ListNode)? {
        var slowHead: ListNode? = originalNode
        var fastHead: ListNode? = originalNode
        
        while fastHead != nil, fastHead?.next != nil {
            fastHead = fastHead?.next?.next
            
            if fastHead != nil {
                slowHead = slowHead?.next
            }
        }
        
        let rightList = slowHead?.next
        slowHead?.next = nil
        
        guard let leftList = originalNode, let rightList else {
            return nil
        }
        
        return (leftList, rightList)
    }
//    public static func sortList(_ head: ListNode?) -> ListNode? {
//        if let head {
//            let array = makeArray(from: head)
//            let sortedArray = sort(array)
//            let finalListNode = makeListNode(from: sortedArray)
//
//            return finalListNode
//        }
//
//        return head
//    }
//
//    static func makeListNode(from array: [Int]) -> ListNode {
//        var lastNode: ListNode?
//        var head: ListNode!
//
//        for value in array {
//            let nodeValue = ListNode(value)
//            
//            if let tempLastNode = lastNode {
//                tempLastNode.next = nodeValue
//            } else {
//                head = nodeValue
//            }
//
//            lastNode = nodeValue
//        }
//
//        return head
//    }
//
//    static func makeArray(from node: ListNode) -> [Int] {
//        var array = Array<Int>()
//        var tempNode: ListNode? = node
//
//        while tempNode != nil {
//            if let val = tempNode?.val {
//                array.append(val)
//            }
//            
//            tempNode = tempNode?.next
//        }
//
//        return array
//    }
//    
//    static func sort(_ list: [Int]) -> [Int] {
//        return mergeSort(list: list)
//    }
//
//    static func mergeSort(list: [Int]) -> [Int] {
//        guard list.count > 1 else {
//            return list
//        }
//        
//        let mid = list.count / 2
//        let leftHalve = 0..<mid
//        let rightHalve = mid..<list.count
//        
//        let leftArray = mergeSort(list: Array<Int>(list[leftHalve]))
//        let rightArray = mergeSort(list: Array<Int>(list[rightHalve]))
//        
//        return merge(leftArray, rightArray)
//    }
//
//    static func merge(_ leftArray: [Int], _ rightArray: [Int]) -> [Int] {
//        var leftIndex = 0
//        var rightIndex = 0
//        var sortedItems: [Int] = []
//        sortedItems.reserveCapacity(leftArray.count + rightArray.count)
//        
//        while leftIndex < leftArray.count && rightIndex < rightArray.count {
//            let leftItem = leftArray[leftIndex]
//            let rightItem = rightArray[rightIndex]
//            
//            if leftItem < rightItem {
//                sortedItems.append(leftItem)
//                leftIndex += 1
//            } else if rightItem < leftItem {
//                sortedItems.append(rightItem)
//                rightIndex += 1
//            } else {
//                leftIndex += 1
//                rightIndex += 1
//                sortedItems.append(leftItem)
//                sortedItems.append(rightItem)
//            }
//        }
//        
//        while leftIndex < leftArray.count {
//            let leftItem = leftArray[leftIndex]
//            sortedItems.append(leftItem)
//            leftIndex += 1
//        }
//        
//        while rightIndex < rightArray.count {
//            let rightItem = rightArray[rightIndex]
//            sortedItems.append(rightItem)
//            rightIndex += 1
//        }
//        
//        return sortedItems
//    }
}
