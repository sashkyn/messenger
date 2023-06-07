import SwiftUI
import SFSafeSymbols

/// TODO:
/// убрать боттом оффсет для не safe area девайсов
/// multiline
///
/// Design:
///

struct MessageTextField: View {
    
    let text: Binding<String>
    let onLeadingAction: () -> Void
    let onTrailingAction: () -> Void
    
    var body: some View {
        ZStack {
            HStack {
                Button(action: { onLeadingAction() }) {
                    Image(systemSymbol: .squareAndArrowUp)
                        .font(.title2)
                        .foregroundColor(.blue)
                }
                TextField("Message", text: text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(
                    action: {
                        onTrailingAction()
                    }
                ) {
                    Image(systemSymbol: .squareAndArrowUp)
                        .font(.title2)
                        .foregroundColor(.blue)
                }
            }
                .padding(.top, 12.0)
                .padding(.leading, 8.0)
                .padding(.trailing, 8.0)
                .padding(.bottom, 32.0)
        }
        .background(Color.white)
    }
}
