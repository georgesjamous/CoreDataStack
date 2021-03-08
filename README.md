# CoreDataStack 
[![Maintenance](https://img.shields.io/maintenance/yes/2021)](https://github.com/georgesjamous/CoreDataStack)
[![GitHub issues](https://img.shields.io/github/issues-raw/georgesjamous/CoreDataStack)](https://github.com/georgesjamous/CoreDataStack/issues/)

This is a quick implementation of a reusable core data stack helper library.

Instead of writing the same redundant code, this contains some useful basic operations.

CoreDataStack is wrapped with a protocol so you can replace the implementation later on at will.

---

#### Installation

Swift Package Manager:

    URL: https://github.com/georgesjamous/CoreDataStack.git


### Usage Example


```swift
let model = NSManagedObjectModel(...)
let stack = try CoreDataStack(launchType: .inMemory, managedObjectModel: model)
let stack = try CoreDataStack(launchType: .onDisk(identifier: "com.products"), managedObjectModel: model)
let context = stack.mainContext // access the main context
let context = stack.backgroundContext // access the background context
context.commit() // commits changes up the chain of contexts
```

<br>

---

Feel free to open a PR
