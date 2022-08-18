import TagKit
import XCTest

private struct TestItem: Taggable {

    var tags: [String]
}

final class TaggableItemTests: XCTestCase {

    func test_hasTags_returnsTrueIfItemHasTags() {
        let item1 = TestItem(tags: [])
        let item2 = TestItem(tags: ["foo"])

        XCTAssertFalse(item1.hasTags)
        XCTAssertTrue(item2.hasTags)
    }

    func test_slugifiedTags_canReturnSlugifiedTagsUsingStandardConfiguration() {
        let item = TestItem(tags: ["first tag", "Second tag"])
        let result = item.slugifiedTags

        XCTAssertEqual(result, ["first-tag", "second-tag"])
    }

    func test_slugifiedTags_canReturnSlugifiedTagsUsingCustomConfiguration() {
        let item = TestItem(tags: ["first tag", "Second tag"])
        let config = SlugConfiguration(separator: "+")
        let result = item.slugifiedTags(configuration: config)

        XCTAssertEqual(result, ["first+tag", "second+tag"])
    }

    func test_addTag_addsNonExistingTags() {
        var item = TestItem(tags: ["tag1", "tag2"])
        item.addTag("tag2")
        item.addTag("tag3")

        XCTAssertEqual(item.tags, ["tag1", "tag2", "tag3"])
    }

    func test_hasTag_returnsSlugifiedMatch() {
        let item = TestItem(tags: ["first tag ", " Second tag"])

        XCTAssertTrue(item.hasTag("First Tag"))
        XCTAssertTrue(item.hasTag("first-tag"))
        XCTAssertTrue(item.hasTag("Second Tag"))
        XCTAssertTrue(item.hasTag("second-tag"))
        XCTAssertFalse(item.hasTag("Third Tag"))
        XCTAssertFalse(item.hasTag("third-tag"))
    }

    func test_removeTag_removesExistingTags() {
        var item = TestItem(tags: ["tag1", "tag2"])
        item.removeTag("tag2")
        item.removeTag("tag3")

        XCTAssertEqual(item.tags, ["tag1"])
    }

    func test_toggleTag_addsOrRemovesTags() {
        var item = TestItem(tags: ["tag1", "tag2"])
        item.toggleTag("tag2")
        XCTAssertEqual(item.tags, ["tag1"])
        item.toggleTag("tag2")
        XCTAssertEqual(item.tags, ["tag1", "tag2"])
    }
}
