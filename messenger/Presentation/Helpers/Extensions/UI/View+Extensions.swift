import SwiftUI

// MARK: View + Transparent scrolling

extension View {
    
    func transparentScrolling() -> some View {
        if #available(iOS 16.0, *) {
            return scrollContentBackground(.hidden)
        } else {
            return onAppear {
                UITextView.appearance().backgroundColor = .clear
            }
        }
    }
}

// MARK: View + hide keyboard on scrolling

extension View {
    
    func hideKeyboardOnScroll() -> some View {
        modifier(HideKeyboardOnScrollModifier())
    }
}
