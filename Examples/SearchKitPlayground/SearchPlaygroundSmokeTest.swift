enum SearchPlaygroundSmokeTest {
    static func run() {
        let result = SearchPlaygroundResult.analyze(
            text: "abracadabra abracadabra",
            pattern: "abra",
            comparison: "abru"
        )

        precondition(result.kmpMatches == [0, 7, 12, 19])
        precondition(result.boyerMooreMatches == result.kmpMatches)
        precondition(result.levenshteinDistance == 1)

        print("SearchKitPlayground smoke test passed: 4 matches, distance 1")
    }
}
