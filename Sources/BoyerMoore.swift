/// A BoyerMoore struct for exact substring search within a single text (String).
/// Uses Unicode scalar values for the pattern and text data.
public struct BoyerMoore {
    public enum Error: Swift.Error {
        case patternNotFound
    }
    
    private let textData: [Int]
    private let text: String
    
    /// Initialize with a `text` in which we will search.
    public init(text: String) {
        self.text = text
        self.textData = text.unicodeScalars.map { Int($0.value) }
    }
    
    /// Compute the bad character rule shift table
    /// Returns a dictionary mapping each character to its rightmost position in the pattern
    private func makeBadCharTable(_ pattern: [Int]) -> [Int: Int] {
        var table: [Int: Int] = [:]
        for i in 0..<pattern.count {
            table[pattern[i]] = i
        }
        return table
    }
    
    /// Search for all occurrences of `pattern` in `textData`.
    /// Returns an array of starting indices where the pattern was found.
    public func searchAll(pattern: String) -> [Int] {
        let pat = pattern.unicodeScalars.map { Int($0.value) }
        guard !pat.isEmpty else { return [] }
        
        let patternLength = pat.count
        let textLength = textData.count
        
        // Precompute shift tables
        let badCharTable = makeBadCharTable(pat)
        
        var matches: [Int] = []
        var i = 0  // Position in text
        
        // Naive approach for overlapping patterns
        while i <= textLength - patternLength {
            var j = patternLength - 1  // Start comparing from the end of pattern
            
            // Compare pattern with text from right to left
            while j >= 0 && pat[j] == textData[i + j] {
                j -= 1
            }
            
            if j < 0 {  // Match found
                matches.append(i)
                // Move just one position for overlapping matches
                i += 1
            } else {
                // Using simplified bad character rule
                let badCharShift: Int
                if let lastPos = badCharTable[textData[i + j]] {
                    badCharShift = max(1, j - lastPos)
                } else {
                    badCharShift = j + 1
                }
                
                i += badCharShift
            }
        }
        
        return matches
    }
    
    /// Search for `pattern` in `textData`. Returns the start index if found,
    /// or throws `patternNotFound`.
    public func search(pattern: String) throws -> Int {
        if let firstMatch = searchAll(pattern: pattern).first {
            return firstMatch
        }
        throw Error.patternNotFound
    }
}