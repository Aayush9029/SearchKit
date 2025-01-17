import Foundation

/// An actor that calculates the Levenshtein distance (edit distance) between strings.
/// The distance is the minimum number of single-character edits
/// (insertions, deletions, or substitutions) required to change one word to the other.
public actor Levenshtein {
    public init() {}
    
    /// Calculates the Levenshtein distance between two strings.
    /// - Parameters:
    ///   - s1: The first string to compare
    ///   - s2: The second string to compare
    /// - Returns: The minimum number of single-character edits needed to transform s1 into s2
    public func distance(_ s1: String, _ s2: String) -> Int {
        let s1Array = Array(s1)
        let s2Array = Array(s2)
        
        let emptyRow = [Int](repeating: 0, count: s2Array.count + 1)
        var previousRow = Array(0 ... s2Array.count)
        
        for (i, char1) in s1Array.enumerated() {
            var currentRow = emptyRow
            currentRow[0] = i + 1
            
            for (j, char2) in s2Array.enumerated() {
                let substitutionCost = (char1 == char2) ? 0 : 1
                currentRow[j + 1] = min(
                    currentRow[j] + 1, // insertion
                    previousRow[j + 1] + 1, // deletion
                    previousRow[j] + substitutionCost // substitution
                )
            }
            previousRow = currentRow
        }
        
        return previousRow[s2Array.count]
    }
}
