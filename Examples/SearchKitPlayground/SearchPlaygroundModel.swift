import Combine
import Foundation

@MainActor
final class SearchPlaygroundModel: ObservableObject {
    @Published var text: String {
        didSet { refresh() }
    }

    @Published var pattern: String {
        didSet { refresh() }
    }

    @Published var comparison: String {
        didSet { refresh() }
    }

    @Published private(set) var result: SearchPlaygroundResult

    init(
        text: String = """
        abracadabra abracadabra
        Swift package search tools can make exact matching and fuzzy lookup easier to compare.
        """,
        pattern: String = "abra",
        comparison: String = "abru"
    ) {
        self.text = text
        self.pattern = pattern
        self.comparison = comparison
        result = SearchPlaygroundResult.analyze(
            text: text,
            pattern: pattern,
            comparison: comparison
        )
    }

    private func refresh() {
        result = SearchPlaygroundResult.analyze(
            text: text,
            pattern: pattern,
            comparison: comparison
        )
    }
}
