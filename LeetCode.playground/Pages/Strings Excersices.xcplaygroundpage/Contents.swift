//: [Previous](@previous)
import Foundation


//: ![Problem description](3110.Score_of_a_String.png)
// URL: https://leetcode.com/problems/score-of-a-string/

//print(Solution3310.scoreOfString("hello"))

//: ![Problem description](2423.equalFrequency.png)
// URL: https://leetcode.com/problems/remove-letter-to-equalize-frequency/

// This is still incompleted :(
//print(Solution2423.equalFrequency("aaazz")) // true
//print(Solution2423.equalFrequency("aazz")) // false
//print(Solution2423.equalFrequency("hello")) // true
//print(Solution2423.equalFrequency("abc")) // true
//print(Solution2423.equalFrequency("abc")) // true
//print(Solution2423.equalFrequency("abbcc")) // true

//: ![Problem description](28.Find_the_Index_of_the_First_Occurrence_in_a_String.png)
// URL: https://leetcode.com/problems/find-the-index-of-the-first-occurrence-in-a-string/

//print(Solution28.strStr("aabaaabaaac", "aabaaac")) //4
//print(Solution28.strStr("aaa", "aaaa")) //-1
//print(Solution28.strStr("mississippi", "issipi")) //4

//: ![Problem description](647.Palindromic_Substrings.png)
// URL: https://leetcode.com/problems/palindromic-substrings/

//Solution647.countSubstrings("aaaytttt") //6 + 10, 1
//Solution647.countSubstrings("aaa") //6
//Solution647.countSubstrings("tttt") //10
//
//let array = ["a", "b", "c", "d"]
//
//for (index, _) in array.enumerated() {
//    var currentIndex = index + 1
//    
//    while (currentIndex < array.count) {
//        print("\(array[index]), \(array[currentIndex])")
//        currentIndex += 1
//    }
//}


//: ![Problem description](1689.Partitioning_Into_Minimum_Number_Of_Deci-Binary_Numbers.png)
// URL: https://leetcode.com/problems/partitioning-into-minimum-number-of-deci-binary-numbers/description/

//Solution1689.minPartitions("32") //3
//Solution1689.minPartitions("82734") //8
//Solution1689.minPartitions("27346209830709182346") //9

//: ![Problem description](2785.Sort_Vowels_in_a_String.png)
// URL: https://leetcode.com/problems/partitioning-into-minimum-number-of-deci-binary-numbers/description/

//Solution2785.sortVowels("lEetcOde") //lEOtcede
//Solution2785.sortVowels("lYmpH") //lYmpH

//: ![Problem description](2716.Minimize_String_Length.png)
// URL: https://leetcode.com/problems/minimize-string-length/description/

//Solution2716.minimizedStringLength("aaabc") //3
//Solution2716.minimizedStringLength("cbbd") //3
//Solution2716.minimizedStringLength("dddaaa") //2


/**
 
 
 We receive a raw log per user ip Address
 input:

 """
 2014-12-24 04:00:13 192.0.0.1 home/user GET 200
 2014-12-24 05:00:13 192.0.0.2 home/user POST 400
 2014-12-24 06:00:13 192.0.0.1 home/user DELETE 200
 2014-12-24 07:00:13 192.0.0.3 home/deals PATCH 200
 2014-12-24 09:00:13 192.0.0.1 home/user HEAD 200
 """
 
 We have to return it as you see below.
 
 output:

 """
 Resource: home/deals
     192.0.0.3 - (PATCH, 200) - 2014-12-24 07:00:13
 Resource: home/user
     192.0.0.2 - (POST, 400) - 2014-12-24 05:00:13
     192.0.0.1 - (GET, 200) (DELETE, 200) (HEAD, 200) - 2014-12-24 04:00:13 - 2014-12-24 09:00:13
 """
 
 */

let input = """
2014-12-24 04:00:13 192.0.0.1 home/user GET 200
2014-12-24 05:00:13 192.0.0.2 home/user POST 400
2014-12-24 06:00:13 192.0.0.1 home/user DELETE 200
2014-12-24 07:00:13 192.0.0.3 home/deals PATCH 200
2014-12-24 09:00:13 192.0.0.1 home/user HEAD 200
"""

print(parse(rawLogs: input))
//: [Next](@next)
