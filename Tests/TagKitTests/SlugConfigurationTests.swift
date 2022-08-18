import TagKit
import XCTest

final class SlugConfigurationTests: XCTestCase {

    func test_canCreateCustomConfigurations() {
        let config = SlugConfiguration(
            separator: "+",
            allowedCharacters: NSCharacterSet(charactersIn: "abc123"))

        XCTAssertEqual(config.separator, "+")
        XCTAssertEqual(config.allowedCharacters, NSCharacterSet(charactersIn: "abc123"))
    }

    func test_standardConfigurationHasExpectedParameters() {
        let config = SlugConfiguration.standard

        XCTAssertEqual(config.separator, "-")
        XCTAssertEqual(config.allowedCharacters, NSCharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"))
    }
}
