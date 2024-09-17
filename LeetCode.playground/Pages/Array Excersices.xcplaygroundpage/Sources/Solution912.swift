import Foundation

public class Solution912 {
 
    public static func sort(list: [Int]) -> [Int] {
        return mergeSort(list: list)
    }

    static func mergeSort(list: [Int]) -> [Int] {
        guard list.count > 1 else {
            return list
        }
        
        let mid = list.count / 2
        let leftHalve = 0..<mid
        let rightHalve = mid..<list.count
        
        let leftArray = mergeSort(list: Array<Int>(list[leftHalve]))
        let rightArray = mergeSort(list: Array<Int>(list[rightHalve]))
        
        return merge(leftArray, rightArray)
    }

    static func merge(_ leftArray: [Int], _ rightArray: [Int]) -> [Int] {
        var leftIndex = 0
        var rightIndex = 0
        var sortedItems: [Int] = []
        sortedItems.reserveCapacity(leftArray.count + rightArray.count)
        
        while leftIndex < leftArray.count && rightIndex < rightArray.count {
            let leftItem = leftArray[leftIndex]
            let rightItem = rightArray[rightIndex]
            
            if leftItem < rightItem {
                sortedItems.append(leftItem)
                leftIndex += 1
            } else if rightItem < leftItem {
                sortedItems.append(rightItem)
                rightIndex += 1
            } else {
                leftIndex += 1
                rightIndex += 1
                sortedItems.append(leftItem)
                sortedItems.append(rightItem)
            }
        }
        
        while leftIndex < leftArray.count {
            let leftItem = leftArray[leftIndex]
            sortedItems.append(leftItem)
            leftIndex += 1
        }
        
        while rightIndex < rightArray.count {
            let rightItem = rightArray[rightIndex]
            sortedItems.append(rightItem)
            rightIndex += 1
        }
        
        return sortedItems
    }
    
}
