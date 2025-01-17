import Foundation

/// A struct that implements the Levenshtein distance algorithm for calculating the minimum number of
/// single-character edits required to change one string into another.
///
/// Time Complexity: O(mn) where m and n are the lengths of the two strings
/// Space Complexity: O(min(m,n)) as we only need to store two rows of the matrix
public struct Levenshtein {
    /// Calculate the Levenshtein distance between two strings.
    /// - Parameters:
    ///   - source: The source string
    ///   - target: The target string
    /// - Returns: The minimum number of single-character edits needed to transform source into target
    public static func distance(source: String, target: String) -> Int {
        let sourceCount = source.count
        let targetCount = target.count
        
        // Handle empty string cases
        if sourceCount == 0 { return targetCount }
        if targetCount == 0 { return sourceCount }
        
        // Convert strings to arrays for faster access
        let sourceArray = Array(source)
        let targetArray = Array(target)
        
        // Create two rows for dynamic programming
        var previousRow = Array(0...targetCount)
        var currentRow = Array(repeating: 0, count: targetCount + 1)
        
        // Fill the matrix
        for i in 0..<sourceCount {
            currentRow[0] = i + 1
            
            for j in 0..<targetCount {
                let cost = sourceArray[i] == targetArray[j] ? 0 : 1
                currentRow[j + 1] = min(
                    currentRow[j] + 1,              // deletion
                    previousRow[j + 1] + 1,         // insertion
                    previousRow[j] + cost           // substitution
                )
            }
            
            // Swap rows
            (previousRow, currentRow) = (currentRow, previousRow)
        }
        
        return previousRow[targetCount]
    }
    
    /// Calculate if two strings are within a specified edit distance.
    /// This is an optimization when you only need to know if strings are within
    /// a certain threshold, not the exact distance.
    /// - Parameters:
    ///   - source: The source string
    ///   - target: The target string
    ///   - threshold: Maximum allowed edit distance
    /// - Returns: true if the edit distance is less than or equal to the threshold
    public static func isWithinDistance(source: String, target: String, threshold: Int) -> Bool {
        let sourceCount = source.count
        let targetCount = target.count
        
        // Quick check based on string length difference
        if abs(sourceCount - targetCount) > threshold { return false }
        if threshold == 0 { return source == target }
        
        // Handle empty string cases
        if sourceCount == 0 { return targetCount <= threshold }
        if targetCount == 0 { return sourceCount <= threshold }
        
        let sourceArray = Array(source)
        let targetArray = Array(target)
        
        // Create two rows for dynamic programming
        var previousRow = Array(0...targetCount)
        var currentRow = Array(repeating: 0, count: targetCount + 1)
        
        // Fill the matrix
        for i in 0..<sourceCount {
            currentRow[0] = i + 1
            var minDistance = currentRow[0]
            
            for j in 0..<targetCount {
                let cost = sourceArray[i] == targetArray[j] ? 0 : 1
                currentRow[j + 1] = min(
                    currentRow[j] + 1,
                    previousRow[j + 1] + 1,
                    previousRow[j] + cost
                )
                minDistance = min(minDistance, currentRow[j + 1])
            }
            
            // Early termination if we can't possibly get below threshold
            if minDistance > threshold {
                return false
            }
            
            // Swap rows
            (previousRow, currentRow) = (currentRow, previousRow)
        }
        
        return previousRow[targetCount] <= threshold
    }
}
