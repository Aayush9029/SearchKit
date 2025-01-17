@testable import SearchKit
import Testing

@Suite("Boyer-Moore Algorithm Tests")
struct BoyerMooreTests {
    @Test("Empty pattern returns zero")
    func testEmptyPattern() throws {
        let bm = BoyerMoore(text: "hello world")
        #expect(try bm.search(pattern: "") == 0)
    }
    
    @Test("Exact pattern match")
    func testExactMatch() throws {
        let bm = BoyerMoore(text: "hello world")
        #expect(try bm.search(pattern: "world") == 6)
    }
    
    @Test("Pattern match at start of text")
    func testMatchAtStart() throws {
        let bm = BoyerMoore(text: "hello world")
        #expect(try bm.search(pattern: "hello") == 0)
    }
    
    @Test("Pattern not found throws error")
    func testPatternNotFound() throws {
        let bm = BoyerMoore(text: "hello world")
        do {
            _ = try bm.search(pattern: "xyz")
        } catch {
            #expect(error is BoyerMoore.Error)
            #expect((error as? BoyerMoore.Error) == .patternNotFound)
        }
    }
    
    @Test("Unicode text handling")
    func testUnicodeText() throws {
        let text = "Hello 👋 World 🌍"
        let bm = BoyerMoore(text: text)
        
        // Get the actual string indices for our emoji
        let waveIndex = text.distance(from: text.startIndex,
                                      to: text.firstIndex(of: "👋")!)
        let globeIndex = text.distance(from: text.startIndex,
                                       to: text.firstIndex(of: "🌍")!)
        
        #expect(try bm.search(pattern: "👋") == waveIndex)
        #expect(try bm.search(pattern: "🌍") == globeIndex)
    }
    
    @Test("Long pattern search")
    func testLongPattern() throws {
        let text = "needle in a haystack"
        let bm = BoyerMoore(text: text)
        #expect(try bm.search(pattern: "needle in a") == 0)
    }
}
