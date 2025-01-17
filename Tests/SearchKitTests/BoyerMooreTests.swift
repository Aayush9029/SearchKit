@testable import SearchKit
import Testing

@Suite("Boyer-Moore Algorithm Tests")
struct BoyerMooreTests {
    @Test("Empty pattern")
    func testEmptyPattern() {
        let bm = BoyerMoore(text: "Hello, World!")
        let matches = bm.searchAll(pattern: "")
        #expect(matches.isEmpty)
    }
    
    @Test("Single match")
    func testSingleMatch() {
        let bm = BoyerMoore(text: "Hello, World!")
        #expect(try bm.search(pattern: "World") == 7)
        #expect(bm.searchAll(pattern: "World") == [7])
    }
    
    @Test("Multiple matches")
    func testMultipleMatches() {
        let bm = BoyerMoore(text: "banana")
        #expect(bm.searchAll(pattern: "ana") == [1, 3])
        
        let bm2 = BoyerMoore(text: "aaaaa")
        #expect(bm2.searchAll(pattern: "aa") == [0, 1, 2, 3])
    }
    
    @Test("Overlapping patterns")
    func testOverlappingPatterns() {
        let bm = BoyerMoore(text: "aaa")
        #expect(bm.searchAll(pattern: "aa") == [0, 1])
    }
    
    @Test("Pattern not found")
    func testPatternNotFound() {
        let bm = BoyerMoore(text: "Hello, World!")
        #expect(bm.searchAll(pattern: "Python").isEmpty)
        #expect(try? bm.search(pattern: "Python") == nil)
    }
    
    @Test("Unicode support")
    func testUnicode() {
        let bm = BoyerMoore(text: "Hello 👋 Hello 👋 World!")
        #expect(bm.searchAll(pattern: "👋") == [6, 13])
        #expect(bm.searchAll(pattern: "Hello") == [0, 8])
    }
    
    @Test("Pattern at start and end")
    func testPatternAtBoundaries() {
        let bm = BoyerMoore(text: "test test test")
        #expect(bm.searchAll(pattern: "test") == [0, 5, 10])
    }
    
    @Test("Long text with multiple matches")
    func testLongText() {
        let text = String(repeating: "abc", count: 100) + "xyz"
        let bm = BoyerMoore(text: text)
        let matches = bm.searchAll(pattern: "abc")
        #expect(matches.count == 100)
        #expect(matches.first == 0)
        #expect(matches.last == 297)  // 99 * 3 = 297 (last "abc" starts at index 297)
    }
    
    @Test("Case sensitivity")
    func testCaseSensitivity() {
        let bm = BoyerMoore(text: "Test TEST test")
        #expect(bm.searchAll(pattern: "Test") == [0])
        #expect(bm.searchAll(pattern: "TEST") == [5])
        #expect(bm.searchAll(pattern: "test") == [10])
    }
    
    @Test("Single character pattern")
    func testSingleCharPattern() {
        let bm = BoyerMoore(text: "abcabc")
        #expect(bm.searchAll(pattern: "a") == [0, 3])
        #expect(bm.searchAll(pattern: "b") == [1, 4])
        #expect(bm.searchAll(pattern: "c") == [2, 5])
    }
}
