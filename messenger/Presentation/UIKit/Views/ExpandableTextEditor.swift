import SwiftUI

struct ExpandableTextEditor: View {
    
    @Binding var text: String
    let placeholderText: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            TextEditor(text: $text)
                .font(.poppins(type: .regular, size: 15.0))
                .transparentScrolling()
                .background(LKColors.x2E2C3C)
                .foregroundColor(LKColors.xFEFEFE)
                .frame(minHeight: 41, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
            if $text.wrappedValue.isEmpty {
                Text(placeholderText)
                    .font(.poppins(type: .regular, size: 15.0))
                    .foregroundColor(LKColors.x7E7A9A)
                    .allowsHitTesting(false)
                    .padding(.horizontal, 8.0)
            }
        }
    }
}

// MARK: Preview

struct LKTextEditor_Previews: PreviewProvider {
    
    static var previews: some View {
        ExpandableTextEditor(text: .constant(""), placeholderText: "Placeholder")
    }
}
