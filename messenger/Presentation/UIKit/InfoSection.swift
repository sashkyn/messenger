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
        Section(
            header: HStack {
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
            },
            content: content
        )
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .listRowBackground(backgroundColor)
    }
}

// MARK: Preview

struct LKSection_Previews: PreviewProvider {
    
    static var previews: some View {
        Form {
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
        .transparentScrolling()
        .background(Color.black)
    }
}
