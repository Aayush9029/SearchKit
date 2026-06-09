import SwiftUI

struct SearchPlaygroundView: View {
    @StateObject private var model = SearchPlaygroundModel()

    var body: some View {
        HStack(spacing: 0) {
            inputPane
            Divider()
            resultPane
        }
        .frame(minWidth: 840, minHeight: 520)
    }

    private var inputPane: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("SearchKit Playground")
                .font(.title2.bold())

            VStack(alignment: .leading, spacing: 8) {
                Text("Text")
                    .font(.headline)
                TextEditor(text: $model.text)
                    .font(.system(.body, design: .monospaced))
                    .frame(minHeight: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.secondary.opacity(0.25), lineWidth: 1)
                    }
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Pattern")
                    .font(.headline)
                TextField("Pattern", text: $model.pattern)
                    .textFieldStyle(.roundedBorder)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Levenshtein comparison")
                    .font(.headline)
                TextField("Comparison", text: $model.comparison)
                    .textFieldStyle(.roundedBorder)
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }

    private var resultPane: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text("Results")
                    .font(.title3.bold())

                ResultMetricView(
                    title: "KMP first match",
                    value: formattedIndex(model.result.kmpFirstIndex),
                    detail: "All matches: \(formattedIndices(model.result.kmpMatches))"
                )

                ResultMetricView(
                    title: "Boyer-Moore first match",
                    value: formattedIndex(model.result.boyerMooreFirstIndex),
                    detail: "All matches: \(formattedIndices(model.result.boyerMooreMatches))"
                )

                ResultMetricView(
                    title: "Levenshtein distance",
                    value: "\(model.result.levenshteinDistance)",
                    detail: "Pattern to comparison"
                )

                ResultMetricView(
                    title: "Closest word",
                    value: model.result.closestWord ?? "No words",
                    detail: closestWordDetail
                )
            }
            .padding(24)
        }
        .frame(width: 300)
    }

    private var closestWordDetail: String {
        guard let distance = model.result.closestWordDistance else {
            return "No tokenized words in the source text"
        }

        return "Distance: \(distance)"
    }

    private func formattedIndex(_ index: Int?) -> String {
        guard let index else { return "Not found" }
        return "\(index)"
    }

    private func formattedIndices(_ indices: [Int]) -> String {
        guard !indices.isEmpty else { return "none" }
        return indices.map(String.init).joined(separator: ", ")
    }
}
