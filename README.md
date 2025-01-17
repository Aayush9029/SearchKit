# SearchKit

SearchKit is a Swift library for efficient string search operations, combining **Knuth-Morris-Pratt (KMP)**, **Boyer-Moore**, and **Levenshtein Distance** algorithms for robust exact and fuzzy searches.

---

## Features

- **KMP**: Fast substring search ([Wikipedia](https://en.wikipedia.org/wiki/Knuth%E2%80%93Morris%E2%80%93Pratt_algorithm)).
- **Boyer-Moore**: Skips unnecessary comparisons ([Wikipedia](https://en.wikipedia.org/wiki/Boyer%E2%80%93Moore_string-search_algorithm)).
- **Levenshtein Distance**: Measures edit distance ([Wikipedia](https://en.wikipedia.org/wiki/Levenshtein_distance)).
- **Unicode Support**: Handles emojis and special characters.
- **Concurrency**: Async/await for parallel searches.

---

## Installation

Add SearchKit via Swift Package Manager:

```swift
// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "YourProject",
    dependencies: [
        .package(url: "https://github.com/Aayush9029/SearchKit.git", from: "1.0.0")
    ],
    targets: [
        .target(name: "YourTarget", dependencies: ["SearchKit"])
    ]
)
```

---

## Examples

### KMP Example

```swift
let kmp = KMP(text: "Hello, World!")
do {
    let index = try kmp.search(pattern: "World")
    print("Found at index: \(index)")
} catch {
    print("Not found")
}
```

### Boyer-Moore Example

```swift
let bm = BoyerMoore(text: "Searching with Boyer-Moore")
do {
    let index = try bm.search(pattern: "Boyer")
    print("Found at index: \(index)")
} catch {
    print("Not found")
}
```

### Levenshtein Example

```swift
let levenshtein = Levenshtein()
Task {
    let distance = await levenshtein.distance("kitten", "sitting")
    print("Distance: \(distance)")
}
```

---

## Testing

Run tests to verify functionality:

```sh
swift test
```

---

## License

SearchKit is MIT licensed. See [LICENSE](LICENSE) for details.

---

Happy Searching! 🚀
