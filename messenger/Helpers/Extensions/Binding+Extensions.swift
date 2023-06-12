import SwiftUI

// MARK: Binding + Limited setting value

extension Binding {
    
    func limitedSet(predicate: @escaping (Value) -> Bool) -> Self {
        Binding(
            get: { wrappedValue },
            set: { newValue in
                let oldValue = wrappedValue
                wrappedValue = newValue
                if predicate(newValue) {
                    wrappedValue = oldValue
                }
            }
        )
    }
}
