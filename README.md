# CoreDataStack

This is a quick implementation of a reusable core data stack helper library.

Instead of writing the same code multiple times, this contains some useful operations.

---

```swift
let model = NSManagedObjectModel(...)
let stack1 = try CoreDataStack(launchType: .inMemory, managedObjectModel: model)
let stack2 = try CoreDataStack(launchType: .onDisk(identifier: "com.products"), managedObjectModel: model)
```
