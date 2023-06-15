import SwiftUI

struct ExpandableTextEditor: View {
    
    @Binding var text: String
    let placeholderText: String
    let minHeight: CGFloat
    
    var body: some View {
        ZStack(
            alignment: .leading,
            content: {
                TextEditor(text: $text)
                    .font(.poppins(type: .regular, size: 15.0))
                    .transparentScrolling()
                if $text.wrappedValue.isEmpty {
                    Text(placeholderText)
                        .font(.poppins(type: .regular, size: 15.0))
                        .foregroundColor(LKColors.x7E7A9A)
                        .padding(.horizontal, 8.0)
                        .allowsHitTesting(false)
                }
            })
            .background(LKColors.x2E2C3C)
            .foregroundColor(LKColors.xFEFEFE)
            .frame(minHeight: minHeight, alignment: .leading)
            .fixedSize(horizontal: false, vertical: true)
    }
}

// MARK: Preview

struct LKTextEditor_Previews: PreviewProvider {
    
    static var previews: some View {
        ExpandableTextEditor(
            text: .constant("asdgasdgasdgasdgasdgasdgasdfhsdfhsdfhsdfhsdfh"),
            placeholderText: "Placeholder",
            minHeight: 100.0
        )
    }
}
