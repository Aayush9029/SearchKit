@testable import SearchKit
import Testing

@Suite("Levenshtein Distance Tests")
struct LevenshteinTests {
    let levenshtein = Levenshtein()
    
    @Test("Identical strings have zero distance")
    func testIdenticalStrings() async {
        let distance = await levenshtein.distance("hello", "hello")
        #expect(distance == 0)
    }
    
    @Test("Empty string comparisons", arguments: [
        ("", "", 0),
        ("", "a", 1),
        ("a", "", 1)
    ])
    func testEmptyStrings(str1: String, str2: String, expectedDistance: Int) async {
        let distance = await levenshtein.distance(str1, str2)
        #expect(distance == expectedDistance)
    }
    
    @Test("Single character differences", arguments: [
        ("cat", "bat", 1, "substitution"),
        ("cat", "cats", 1, "insertion"),
        ("cats", "cat", 1, "deletion")
    ])
    func testSingleCharacterDifference(str1: String, str2: String, expectedDistance: Int, operation: String) async {
        let distance = await levenshtein.distance(str1, str2)
        #expect(distance == expectedDistance)
    }
    
    @Test("Multiple operations", arguments: [
        ("kitten", "sitting", 3),
        ("sunday", "saturday", 3)
    ])
    func testMultipleOperations(str1: String, str2: String, expectedDistance: Int) async {
        let distance = await levenshtein.distance(str1, str2)
        #expect(distance == expectedDistance)
    }
    
    @Test("Unicode string handling")
    func testUnicodeStrings() async {
        #expect(await levenshtein.distance("👋🌍", "👋🌎") == 1)
        #expect(await levenshtein.distance("café", "cafe") == 1)
    }
    
    @Test("Case sensitivity", arguments: [
        ("Hello", "hello", 1),
        ("WORLD", "world", 5)
    ])
    func testCaseSensitivity(str1: String, str2: String, expectedDistance: Int) async {
        let distance = await levenshtein.distance(str1, str2)
        #expect(distance == expectedDistance)
    }
}
