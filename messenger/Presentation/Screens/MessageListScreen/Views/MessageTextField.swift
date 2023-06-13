import SwiftUI
import SFSafeSymbols

struct MessageTextField: View {
    
    @Binding var text: String
    let onLeadingAction: () -> Void
    let isTrailingActionEnabled: Bool
    let onTrailingAction: () -> Void
    
    var body: some View {
        HStack {
            Button(action: onLeadingAction) {
                Image(systemSymbol: .cubeFill)
                    .font(.title2)
                    .foregroundColor(LKColors.xFEFEFE)
            }
            ExpandableTextEditor(
                text: $text,
                placeholderText: "Message"
            )
            .cornerRadius(10.0)
            
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
        .frame(minHeight: 41, alignment: .leading)
    }
}

struct MessageTextField_Previews: PreviewProvider {
    
    static var previews: some View {
        MessageTextField(
            text: .constant(""),
            onLeadingAction: { },
            isTrailingActionEnabled: false,
            onTrailingAction: { }
        )
    }
}
