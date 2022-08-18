import TagKit
import XCTest

final class SlugifiableTests: XCTestCase {

    func test_slugifiedString_usesStandardConfigurationByDefault() {
        let string = "I'd love a super-great AppleCar!"
        let result = string.slugified()
        let expected = "i-d-love-a-super-great-applecar"

        XCTAssertEqual(result, expected)
    }

    func test_slugifiedString_canUseCustomConfiguration() {
        let string = "I'd love a super-great AppleCar!"
        let config = SlugConfiguration(
            separator: "+",
            allowedCharacters: NSCharacterSet(charactersIn: "abc"))
        let result = string.slugified(configuration: config)
        let expected = "a+a+a+ca"

        XCTAssertEqual(result, expected)
    }
}
