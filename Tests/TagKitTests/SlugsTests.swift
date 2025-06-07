import TagKit
import XCTest

final class SlugConfigurationTests: XCTestCase {
    
    func testStringUsesStandardSlugConfigurationByDefault() {
        let string = "I'd love a super-great AppleCar!"
        let result = string.slugified()
        let expected = "i-d-love-a-super-great-applecar"

        XCTAssertEqual(result, expected)
    }

    func testStringCanUseCustomSlugConfiguration() {
        let string = "I'd love a super-great AppleCar!"
        let config = SlugConfiguration(
            separator: "+",
            allowedCharacters: "abc")
        let result = string.slugified(with: config)
        let expected = "a+a+a+ca"

        XCTAssertEqual(result, expected)
    }
    
    func testHasValidStandardSlugConfiguration() {
        let config = SlugConfiguration.standard
        let expected = "abcdefghijklmnopqrstuvwxyz0123456789-"

        XCTAssertEqual(config.separator, "-")
        XCTAssertEqual(config.allowedCharacters, expected)
        XCTAssertEqual(config.allowedCharacterSet, NSCharacterSet(charactersIn: expected))
    }

    func testCanCreateCustomSlugConfiguration() {
        let config = SlugConfiguration(
            separator: "+",
            allowedCharacters: "abc123")
        let expected = "abc123+"

        XCTAssertEqual(config.separator, "+")
        XCTAssertEqual(config.allowedCharacters, expected)
        XCTAssertEqual(config.allowedCharacterSet, NSCharacterSet(charactersIn: expected))
    }
}
