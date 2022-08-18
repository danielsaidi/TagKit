import TagKit
import XCTest

private struct TestItem: Taggable {

    var tags: [String]
}

final class Taggable_CollectionTests: XCTestCase {

    private let items: [TestItem] = {
        var item1 = TestItem(tags: ["item", "Item 1"])
        var item2 = TestItem(tags: ["iTem", "item 2"])
        var item3 = TestItem(tags: ["iteM", "item 3"])
        return [item1, item2, item3]
    }()

    func test_allTagsRetursSlugifiedItems() {
        let result = items.allTags

        XCTAssertEqual(result, ["item", "item-1", "item-2", "item-3"])
    }
}
