import SwiftUI
import SFSafeSymbols

struct MessageTextField: View {
    
    @Binding var text: String
    let onLeadingAction: () -> Void
    let isTrailingActionEnabled: Bool
    let onTrailingAction: () -> Void
    
    var body: some View {
        HStack(alignment: .bottom) {
            Button(
                action: onLeadingAction,
                label: {
                    Image(systemSymbol: .cubeFill)
                        .font(.title2)
                        .foregroundColor(LKColors.xFEFEFE)
                })
                .padding(.bottom, 5.0)
            
            ExpandableTextEditor(
                text: $text,
                placeholderText: "Message",
                minHeight: 35.0
            )
            .cornerRadius(10.0)
            
            Button(
                action: onTrailingAction,
                label: {
                    Image(systemSymbol: .recordCircle)
                        .font(.title2)
                        .foregroundColor(isTrailingActionEnabled ? LKColors.xFEFEFE : LKColors.x7E7A9A)
                })
                .disabled(!isTrailingActionEnabled)
                .padding(.bottom, 5.0)
        }
        .padding(.vertical, 12.0)
        .padding(.horizontal, 8.0)
        .background(LKColors.x14131B)
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
