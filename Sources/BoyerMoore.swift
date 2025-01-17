import Foundation

/// A BoyerMoore struct for exact substring search within a single text (String).
/// Uses Unicode scalar values for the pattern and text data.
public struct BoyerMoore {
    public enum Error: Swift.Error {
        case patternNotFound
    }
    
    private let textData: [Int]
    
    /// Initialize with a `text` in which we will search.
    public init(text: String) {
        self.textData = text.unicodeScalars.map { Int($0.value) }
    }
    
    /// Compute the shift distance for a `char` in the pattern.
    /// If the char doesn't exist in the pattern, return `pattern.count`.
    /// Otherwise return `pattern.count - 1 - j`, where `j` is the last
    /// position of `char` within the pattern.
    private func delta1(pattern: [Int], char: Int) -> Int {
        for i in (0 ..< pattern.count).reversed() {
            if pattern[i] == char {
                let shift = pattern.count - 1 - i
                return shift
            }
        }
        return pattern.count
    }
    
    /// Search for `pattern` in `textData`. Returns the start index if found,
    /// or throws `patternNotFound`.
    public func search(pattern: String) throws -> Int {
        let pat = pattern.unicodeScalars.map { Int($0.value) }
        guard !pat.isEmpty else {
            return 0
        }
        
        var i = pat.count - 1
        let lastIndex = textData.count
        
        while i < lastIndex {
            var j = pat.count - 1
            var k = i
            
            while j >= 0 && textData[k] == pat[j] {
                k -= 1
                j -= 1
            }
            
            if j < 0 {
                return k + 1
            }
            
            // Shift by the delta1 distance
            let shift = delta1(pattern: pat, char: textData[i])
            i += shift
        }
        
        throw Error.patternNotFound
    }
}
