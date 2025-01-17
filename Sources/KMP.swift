import Foundation

/// A KMP (Knuth-Morris-Pratt) struct for efficient exact substring search within text.
/// The algorithm uses a prefix function to avoid unnecessary character comparisons,
/// making it especially efficient for patterns with repeating substrings.
/// Time Complexity: O(n + m) where n is text length and m is pattern length
/// Space Complexity: O(m) for the prefix function array
public struct KMP {
    public enum Error: Swift.Error {
        case patternNotFound
    }
    
    private let textData: [Int]
    
    /// Initialize with a `text` in which we will search.
    /// Converts the text to Unicode scalar values for consistent character handling.
    public init(text: String) {
        self.textData = text.unicodeScalars.map { Int($0.value) }
    }
    
    /// Compute the prefix function (also known as failure function) for the pattern.
    /// This function helps skip unnecessary comparisons by utilizing previously matched characters.
    /// - Parameter pattern: Array of Unicode scalar values representing the search pattern
    /// - Returns: Array containing the length of the longest proper prefix that is also a suffix
    private func computePrefixFunction(pattern: [Int]) -> [Int] {
        var prefixFunc = Array(repeating: 0, count: pattern.count)
        var j = 0
        
        // Iterate through the pattern starting from the second character
        for i in 1..<pattern.count {
            // While we have mismatch and j > 0, fall back to the previous prefix
            while j > 0 && pattern[j] != pattern[i] {
                j = prefixFunc[j - 1]
            }
            
            // If we found a match, increment the prefix length
            if pattern[j] == pattern[i] {
                j += 1
            }
            
            prefixFunc[i] = j
        }
        
        return prefixFunc
    }
    
    /// Search for `pattern` in the text using KMP algorithm.
    /// - Parameter pattern: The string pattern to search for
    /// - Returns: The starting index of the first occurrence of the pattern
    /// - Throws: `Error.patternNotFound` if the pattern is not found in the text
    public func search(pattern: String) throws -> Int {
        let pat = pattern.unicodeScalars.map { Int($0.value) }
        guard !pat.isEmpty else { return 0 }
        
        let prefixFunc = computePrefixFunction(pattern: pat)
        var j = 0  // Number of characters matched
        
        // Iterate through the text
        for i in 0..<textData.count {
            // While we have mismatch and j > 0, fall back using the prefix function
            while j > 0 && pat[j] != textData[i] {
                j = prefixFunc[j - 1]
            }
            
            // If current characters match, advance j
            if pat[j] == textData[i] {
                j += 1
            }
            
            // If we've matched the entire pattern
            if j == pat.count {
                return i - pat.count + 1
            }
        }
        
        throw Error.patternNotFound
    }
} 