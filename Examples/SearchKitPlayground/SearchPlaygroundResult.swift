import SearchKit

struct SearchPlaygroundResult: Equatable {
    var kmpFirstIndex: Int?
    var kmpMatches: [Int]
    var boyerMooreFirstIndex: Int?
    var boyerMooreMatches: [Int]
    var levenshteinDistance: Int
    var closestWord: String?
    var closestWordDistance: Int?

    static func analyze(text: String, pattern: String, comparison: String) -> SearchPlaygroundResult {
        let kmp = KMP(text: text)
        let boyerMoore = BoyerMoore(text: text)
        let closestMatch = Levenshtein.findClosestMatch(
            query: pattern,
            targets: words(in: text),
            maxDistance: nil
        )

        return SearchPlaygroundResult(
            kmpFirstIndex: try? kmp.search(pattern: pattern),
            kmpMatches: kmp.searchAll(pattern: pattern),
            boyerMooreFirstIndex: try? boyerMoore.search(pattern: pattern),
            boyerMooreMatches: boyerMoore.searchAll(pattern: pattern),
            levenshteinDistance: Levenshtein.distance(source: pattern, target: comparison),
            closestWord: closestMatch?.match,
            closestWordDistance: closestMatch?.distance
        )
    }

    private static func words(in text: String) -> [String] {
        text.split { character in
            !character.isLetter && !character.isNumber
        }
        .map(String.init)
    }
}
