import SwiftUI
import SFSafeSymbols

/// TODO:
/// убрать боттом оффсет для не safe area девайсов
/// multiline
///

struct MessageTextField: View {
    
    let text: Binding<String>
    let onLeadingAction: () -> Void
    let onTrailingAction: () -> Void
    
    var body: some View {
        ZStack {
            HStack {
                Button(action: { onLeadingAction() }) {
                    Image(systemSymbol: .cubeFill)
                        .font(.title2)
                        .foregroundColor(LKColors.xFEFEFE)
                }
                ZStack(alignment: .leading) {
                    TextEditor(text: text)
                        .font(.poppins(type: .regular, size: 15.0))
                        .transparentScrolling()
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                        .background(LKColors.x2E2C3C)
                        .cornerRadius(10.0)
                        .foregroundColor(LKColors.xFEFEFE)
                        .frame(height: 40, alignment: .leading)
                    if text.wrappedValue.isEmpty {
                        Text("Message")
                            .font(.poppins(type: .regular, size: 15.0))
                            .background(LKColors.x2E2C3C)
                            .foregroundColor(LKColors.x7E7A9A)
                            .padding(.leading, 8)
                            .padding(.trailing, 8)
                            .allowsHitTesting(false)
                    }
                }
                
                Button(
                    action: {
                        onTrailingAction()
                    }
                ) {
                    Image(systemSymbol: .recordCircle)
                        .font(.title2)
                        .foregroundColor(LKColors.xFEFEFE)
                }
            }
                .padding(.top, 12.0)
                .padding(.leading, 8.0)
                .padding(.trailing, 8.0)
                .padding(.bottom, 12.0)
                .background(LKColors.x14131B)
        }
    }
}

struct MessageTextField_Previews: PreviewProvider {
    
    static var previews: some View {
        MessageTextField(
            text: .constant("Text with message"),
            onLeadingAction: { },
            onTrailingAction: { }
        )
    }
}
