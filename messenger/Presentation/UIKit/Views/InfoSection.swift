import SwiftUI

struct InfoSection<Content: View>: View {
    
    let leadingTitle: String?
    let trailingTitle: String?
    let backgroundColor: Color
    let content: () -> Content
    
    init(
        leadingTitle: String? = nil,
        trailingTitle: String? = nil,
        backgroundColor: Color,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.leadingTitle = leadingTitle
        self.trailingTitle = trailingTitle
        self.backgroundColor = backgroundColor
        self.content = content
    }
    
    var body: some View {
        VStack {
            HStack {
                if let leadingTitle {
                    Text(leadingTitle)
                        .foregroundColor(LKColors.x7E7A9A)
                        .font(.poppins(type: .medium, size: 12))
                }
                if let trailingTitle {
                    Spacer()
                    Text(trailingTitle)
                        .foregroundColor(LKColors.x7E7A9A)
                        .font(.poppins(type: .medium, size: 12))
                }
            }
            content()
        }
    }
}

// MARK: Preview

struct LKSection_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            InfoSection(
                leadingTitle: "1",
                trailingTitle: "2",
                backgroundColor: Color.red,
                content: {
                    Text("hehehehehehe")
                        .foregroundColor(Color.white)
                    Text("hehehehehehe")
                        .foregroundColor(Color.white)
                    Text("hehehehehehe")
                        .foregroundColor(Color.white)
                    Text("hehehehehehe")
                        .foregroundColor(Color.white)
                    Text("hehehehehehe")
                        .foregroundColor(Color.white)
                }
            )
        }
        .background(Color.black)
    }
}
