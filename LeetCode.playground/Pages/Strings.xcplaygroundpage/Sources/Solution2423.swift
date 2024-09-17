import Foundation

public class Solution2423 {
    
    public static func equalFrequency(_ word: String) -> Bool {
        // 1. Group ocurrencies into a map per each character
        
        var ocurrencesWithCharacter: [Character: Int] = [:]
        
        for letter in word {
            if var counter = ocurrencesWithCharacter[letter] {
                counter += 1
                ocurrencesWithCharacter[letter] = counter
                
            } else {
                ocurrencesWithCharacter[letter] = 1
            }
        }
        
        let aa = ocurrencesWithCharacter.sorted { left, right in
            left.value > right.value
        }
        
        print(aa)
        
        // 2. Find the highest ocurrence character
        
        var lastHighOcurrenceCharacter: Character?
        var lastHighOcurrenceValue: Int?
                
        for (character, value) in ocurrencesWithCharacter {
            
            if let tempLastHighOcurrenceValue = lastHighOcurrenceValue,
               tempLastHighOcurrenceValue < value {
                lastHighOcurrenceCharacter = character
                lastHighOcurrenceValue = value
            }
            
            if lastHighOcurrenceValue == nil {
                lastHighOcurrenceValue = value
                lastHighOcurrenceCharacter = character
            }
        }
        
        // 3. Reduce the highest ocurrence character by one
                
        if let lastHighOcurrenceCharacter, var counter = ocurrencesWithCharacter[lastHighOcurrenceCharacter] {
            counter -= 1
            if counter > 0 {
                ocurrencesWithCharacter[lastHighOcurrenceCharacter] = counter
            } else {
                ocurrencesWithCharacter.removeValue(forKey: lastHighOcurrenceCharacter)
            }
        }
        
        // 4. Check if there is a difference frecuency
        
        var ocurrencesFrecuency: Int? = nil
        
        for (_, value) in ocurrencesWithCharacter {
            
            if let ocurrencesFrecuency {
                if ocurrencesFrecuency != value {
                    return false
                }
            }
            
            ocurrencesFrecuency = value
        }
        
        return true
    }
}
