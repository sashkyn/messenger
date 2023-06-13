import SwiftUI

struct HideKeyboardOnScrollModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content.gesture(
            DragGesture(minimumDistance: 5.0)
                .onChanged { _ in hideKeyboard() }
        )
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for:nil
        )
    }
}
