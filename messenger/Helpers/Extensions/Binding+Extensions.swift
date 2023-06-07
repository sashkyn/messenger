import SwiftUI

extension Binding {
    
    func allowing(predicate: @escaping (Value) -> Bool) -> Self {
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
