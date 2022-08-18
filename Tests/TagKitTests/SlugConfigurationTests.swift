import TagKit
import XCTest

final class SlugConfigurationTests: XCTestCase {

    func test_canCreateCustomConfigurations() {
        let config = SlugConfiguration(
            separator: "+",
            allowedCharacters: "abc123")
        let expected = "abc123+"

        XCTAssertEqual(config.separator, "+")
        XCTAssertEqual(config.allowedCharacters, expected)
        XCTAssertEqual(config.allowedCharacterSet, NSCharacterSet(charactersIn: expected))
    }

    func test_standardConfigurationHasExpectedParameters() {
        let config = SlugConfiguration.standard
        let expected = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-"

        XCTAssertEqual(config.separator, "-")
        XCTAssertEqual(config.allowedCharacters, expected)
        XCTAssertEqual(config.allowedCharacterSet, NSCharacterSet(charactersIn: expected))
    }
}
