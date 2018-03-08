import XCTest
@testable import SwiftConcurrent

class SwiftConcurrentTests: XCTestCase {

	
	func testing() {
		let nQueues = 1
		// 1 queue onto the pool
		let pool = GCDPooling(quantity: nQueues)
		// pool size should be 1
		XCTAssertEqual(pool.size, nQueues, "pool size == nQueues")
		// pool isn't empty
		XCTAssertFalse(pool.isEmpty, "pool is not empty")

		var flag = false
		// assuming flag is some computation
		// that needs to be executing inside
		// a queue
		
		pool.runOnto(queueAtIndex: 0) {
			flag = true
		}
		
		pool.notify {
			// all tasks are finished
			// flag should be true not false
			XCTAssertTrue(flag, "flag computation is changed to `true`")
			XCTAssertNotEqual(flag, false, "flag is true not false")
		}
	}

	static var allTests = [
		("basicBehaviorOfPool",testing),
    ]
}
