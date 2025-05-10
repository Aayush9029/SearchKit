@testable import SearchKit
import Testing

@Suite("KMP Algorithm Tests")
struct KMPTests {
    @Test("Basic string pattern search")
    func testBasicSearch() throws {
        let text = "Hello, World!"
        let kmp = KMP(text: text)

        #expect(try kmp.search(pattern: "World") == 7)
        #expect(try kmp.search(pattern: "Hello") == 0)
        #expect(try kmp.search(pattern: "!") == 12)
    }

    @Test("Empty pattern returns zero")
    func testEmptyPattern() throws {
        let text = "Some text"
        let kmp = KMP(text: text)

        #expect(try kmp.search(pattern: "") == 0)
    }

    @Test("Pattern not found throws error")
    func testPatternNotFound() throws {
        let text = "Hello, World!"
        let kmp = KMP(text: text)

        do {
            _ = try kmp.search(pattern: "Python")
        } catch {
            #expect(error is KMP.Error)
            #expect((error as? KMP.Error) == .patternNotFound)
        }
    }

    @Test("Repeating patterns", arguments: [
        ("AABAACAADAABAABA", "AABA", 0),
        ("AABAACAADAABAABA", "AA", 0)
    ])
    func testRepeatingPattern(text: String, pattern: String, expectedIndex: Int) throws {
        let kmp = KMP(text: text)
        #expect(try kmp.search(pattern: pattern) == expectedIndex)
    }

    @Test("Unicode character support")
    func testUnicode() throws {
        let text = "Hello 👋 World 🌍!"
        let kmp = KMP(text: text)

        #expect(try kmp.search(pattern: "👋") == 6)
        #expect(try kmp.search(pattern: "🌍") == 14)
        #expect(try kmp.search(pattern: "World 🌍") == 8)
    }

    @Test("Long pattern performance")
    func testLongPattern() throws {
        let text = String(repeating: "A", count: 1000) + "B"
        let kmp = KMP(text: text)

        #expect(try kmp.search(pattern: String(repeating: "A", count: 500)) == 0)
        #expect(try kmp.search(pattern: "B") == 1000)
    }

    @Test("Overlapping pattern finds first occurrence")
    func testOverlappingPattern() throws {
        let text = "AAAAA"
        let kmp = KMP(text: text)

        #expect(try kmp.search(pattern: "AAA") == 0)
    }

    @Test("Multiple pattern matches with searchAll")
    func testSearchAll() {
        let text = "Mississippi"
        let kmp = KMP(text: text)

        #expect(kmp.searchAll(pattern: "iss") == [1, 4])
        #expect(kmp.searchAll(pattern: "i") == [1, 4, 7, 10])
        #expect(kmp.searchAll(pattern: "ssi") == [2, 5])
        #expect(kmp.searchAll(pattern: "xyz").isEmpty)
    }
}
