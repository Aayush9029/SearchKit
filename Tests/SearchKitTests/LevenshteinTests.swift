@testable import SearchKit
import Testing

@Suite("Levenshtein Algorithm Tests")
struct LevenshteinTests {
    @Test("Empty strings")
    func testEmptyStrings() {
        #expect(Levenshtein.distance(source: "", target: "") == 0)
        #expect(Levenshtein.distance(source: "", target: "abc") == 3)
        #expect(Levenshtein.distance(source: "abc", target: "") == 3)
    }

    @Test("Same strings")
    func testSameStrings() {
        #expect(Levenshtein.distance(source: "hello", target: "hello") == 0)
        #expect(Levenshtein.distance(source: "world", target: "world") == 0)
    }

    @Test("Simple edits")
    func testSimpleEdits() {
        // Single character operations
        #expect(Levenshtein.distance(source: "cat", target: "cut") == 1)  // substitution
        #expect(Levenshtein.distance(source: "cat", target: "cats") == 1) // insertion
        #expect(Levenshtein.distance(source: "cats", target: "cat") == 1) // deletion
    }

    @Test("Complex edits")
    func testComplexEdits() {
        #expect(Levenshtein.distance(source: "kitten", target: "sitting") == 3)
        #expect(Levenshtein.distance(source: "saturday", target: "sunday") == 3)
    }

    @Test("Unicode character support")
    func testUnicode() {
        #expect(Levenshtein.distance(source: "café", target: "cafe") == 1)
        #expect(Levenshtein.distance(source: "👋🌍", target: "👋") == 1)
    }

    @Test("Within distance checks")
    func testWithinDistance() {
        // Test exact matches
        #expect(Levenshtein.isWithinDistance(source: "hello", target: "hello", threshold: 0))

        // Test within threshold
        #expect(Levenshtein.isWithinDistance(source: "kitten", target: "sitting", threshold: 3))
        #expect(!Levenshtein.isWithinDistance(source: "kitten", target: "sitting", threshold: 2))

        // Test length difference optimization
        #expect(!Levenshtein.isWithinDistance(source: "hi", target: "hello", threshold: 2))

        // Test early termination
        #expect(!Levenshtein.isWithinDistance(source: "completely", target: "different", threshold: 3))
    }

    @Test("Performance of distance calculation")
    func testPerformance() {
        let longString1 = String(repeating: "a", count: 1000)
        let longString2 = String(repeating: "a", count: 990) + String(repeating: "b", count: 10)

        _ = Levenshtein.distance(source: longString1, target: longString2)
    }

    @Test("Performance of within distance check")
    func testPerformanceWithinDistance() {
        let longString1 = String(repeating: "a", count: 1000)
        let longString2 = String(repeating: "a", count: 990) + String(repeating: "b", count: 10)

        _ = Levenshtein.isWithinDistance(source: longString1, target: longString2, threshold: 5)
    }

    @Test("Find closest match functionality")
    func testFindClosestMatch() {
        let targets = ["apple", "banana", "orange", "pear", "grape", "apricot"]

        // Exact match
        let exactMatch = Levenshtein.findClosestMatch(query: "apple", targets: targets)
        #expect(exactMatch?.match == "apple")
        #expect(exactMatch?.distance == 0)

        // Close match
        let closeMatch = Levenshtein.findClosestMatch(query: "aple", targets: targets)
        #expect(closeMatch?.match == "apple")
        #expect(closeMatch?.distance == 1)

        // Test with maxDistance - length difference already excludes it
        let limitedMatch = Levenshtein.findClosestMatch(query: "grap", targets: targets, maxDistance: 2)
        #expect(limitedMatch?.match == "grape")
        #expect(limitedMatch?.distance == 1)

        // No match within distance
        let noMatch = Levenshtein.findClosestMatch(query: "kiwi", targets: targets, maxDistance: 2)
        #expect(noMatch == nil)

        // Empty targets
        let emptyTargets = Levenshtein.findClosestMatch(query: "apple", targets: [])
        #expect(emptyTargets == nil)
    }
}
