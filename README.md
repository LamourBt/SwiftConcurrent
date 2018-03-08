## SwiftConcurrent

Easy Interface to deal with multiple queues and Synchronization in swift on macOS and linux.

### Example Create a pool of Thread
```Swift
let pool = GCDPooling(quantity: 2)
// as of now you have 2 global queues within your pool

pool.runOnto(queueAtIndex: 0, completion: {
  print("First Queue Working Hard")
})

pool.runOnto(queueAtIndex: 1, completion: {
  print("Second Queue Working Hard")
})

// runOnto method is how we place computation within a queue within our pool

pool.notify {
  print("fini...")
}
// notify would be invoked when all jobs have been completed.
```

### Lock block code
```Swift
let sema = Semaphore(numberOfOps: 1)
// Sempahore is a nice wrapper around DispatchSemaphore

sema.lock {
  print("placed important block of code")
}
// lock places your code in between both wait & signal

```

## Questions & Concerns/Issues
Just Open an issue.

## Contributing
Just send a PR! We don't bite ;)


