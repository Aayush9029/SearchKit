<div align="center">
<img src="https://github.com/user-attachments/assets/b87ca842-14b7-4e33-9fdc-d564b7bb7220" width="128">
    

<h1> SearchKit </h1>

SearchKit is a Swift library for efficient string search operations, combining **Knuth-Morris-Pratt (KMP)**, **Boyer-Moore**, and **Levenshtein Distance** algorithms for robust exact and fuzzy searches.


</div>

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
        .package(url: "https://github.com/Aayush9029/SearchKit.git", branch: "main")
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

// Find first occurrence
do {
    let index = try bm.search(pattern: "Boyer")
    print("Found at index: \(index)")
} catch {
    print("Not found")
}

// Find all occurrences
let matches = bm.searchAll(pattern: "e")
print("Found at indices: \(matches)") // [1, 16]
```

The Boyer-Moore implementation provides both single-match (`search`) and multi-match (`searchAll`) capabilities, making it versatile for different search requirements. The algorithm maintains its efficiency by using the bad character rule for pattern shifting.

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

---

### Levenshtein Distance

The `Levenshtein` struct provides efficient string similarity measurement using the Levenshtein distance algorithm. It includes two main functionalities:

1. Calculate exact edit distance:
```swift
let distance = Levenshtein.distance(source: "kitten", target: "sitting")
// Returns: 3
```

2. Check if strings are within a specific edit distance (optimized):
```swift
let isClose = Levenshtein.isWithinDistance(source: "hello", target: "helo", threshold: 1)
// Returns: true
```

The implementation uses space-optimized dynamic programming, requiring only O(min(m,n)) space where m and n are the lengths of the input strings. The time complexity is O(mn) for exact distance calculation, but the `isWithinDistance` method includes early termination optimizations for better performance when you only need to check if strings are within a certain edit distance.

