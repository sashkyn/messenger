import SwiftUI

struct HideKeyboardOnScrollModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content.gesture(
            DragGesture().onChanged { _ in
                UIApplication.shared.sendAction(
                    #selector(UIResponder.resignFirstResponder),
                    to: nil,
                    from: nil,
                    for:nil
                )
            }
        )
    }
}
