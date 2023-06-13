import SwiftUI
import SFSafeSymbols

struct MessageTextField: View {
    
    let text: Binding<String>
    let onLeadingAction: () -> Void
    let isTrailingActionEnabled: Bool
    let onTrailingAction: () -> Void
    
    var body: some View {
        ZStack {
            HStack {
                Button(action: onLeadingAction) {
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
                
                Button(action: onTrailingAction) {
                    Image(systemSymbol: .recordCircle)
                        .font(.title2)
                        .foregroundColor(isTrailingActionEnabled ? LKColors.xFEFEFE : LKColors.x7E7A9A)
                }
                .disabled(!isTrailingActionEnabled)
            }
            .padding(.vertical, 12.0)
            .padding(.horizontal, 8.0)
            .background(LKColors.x14131B)
        }
    }
}

struct MessageTextField_Previews: PreviewProvider {
    
    static var previews: some View {
        MessageTextField(
            text: .constant("Text with message"),
            onLeadingAction: { },
            isTrailingActionEnabled: false,
            onTrailingAction: { }
        )
    }
}
