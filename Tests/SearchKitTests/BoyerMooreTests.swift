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
    func testSingleMatch() throws {
        let bm = BoyerMoore(text: "Hello, World!")
        let index = try bm.search(pattern: "World")
        #expect(index == 7)
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
    func testPatternNotFound() throws {
        let bm = BoyerMoore(text: "Hello, World!")
        #expect(bm.searchAll(pattern: "Python").isEmpty)

        do {
            _ = try bm.search(pattern: "Python")
            #expect(false, "Expected error to be thrown")
        } catch {
            #expect(error is BoyerMoore.Error)
            #expect((error as? BoyerMoore.Error) == .patternNotFound)
        }
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

    @Test("Pattern with special characters")
    func testSpecialCharacters() throws {
        let text = "Hello! How are you? I'm #1 @special-chars."
        let bm = BoyerMoore(text: text)

        #expect(try bm.search(pattern: "!") == 5)
        #expect(try bm.search(pattern: "?") == 18)
        #expect(try bm.search(pattern: "#1") == 24)
        #expect(try bm.search(pattern: "@special-chars") == 27)
        #expect(bm.searchAll(pattern: ".") == [41])

        // Combined special characters
        #expect(bm.searchAll(pattern: "! How") == [5])
        #expect(bm.searchAll(pattern: "? I'm") == [18])
    }
}
