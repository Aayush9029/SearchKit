import SwiftUI

@main
enum SearchKitPlaygroundMain {
    static func main() {
        if CommandLine.arguments.contains("--smoke-test") {
            SearchPlaygroundSmokeTest.run()
            return
        }

        SearchKitPlaygroundApp.main()
    }
}
