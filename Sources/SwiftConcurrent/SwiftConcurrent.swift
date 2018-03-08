import Foundation
import Dispatch

public struct Semaphore {
	private let semaphore: DispatchSemaphore
	
	public init(numberOfOps n : Int) {
		self.semaphore = DispatchSemaphore(value: n)
	}
	
	public func lock(completion:() -> ()) {
		semaphore.wait()
		completion()
		semaphore.signal()
	}
}

/**
GCDPooling isn't the same as GCD Thread Pool but a pool but of queues.
*/
final class GCDPooling {
	private let quantity: Int
	private let queues: [DispatchQueue]
	private let group: DispatchGroup
	
	///-Parameter quantity: the number of DispatchQueue that needs to be within the pool
	required public init(quantity: Int) {
		self.quantity = quantity
		self.queues = [DispatchQueue](repeatElement(DispatchQueue.global(), count: quantity))
		self.group = DispatchGroup()
	}
	///return number of queues in the pool
	public var size: Int { return quantity }
	public var isEmpty: Bool { return queues.isEmpty }
	
	public func runOnto(queueAtIndex index: Int, completion: @escaping ()->()) {
		if index > 0 && index < self.quantity {
			self.queues[index].async(group: self.group) {
				completion()
			}
		}
	}
	
	///-Parameter queue: has a default queue of global()
	public func notify(queue: DispatchQueue = .global(), completion: @escaping ()->()) {
		self.group.notify(queue:queue) {
			completion()
		}
	}
}



