import SwiftUI

struct ImageTitleToggle: View {
    
    let image: Image
    let title: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack {
            Toggle(
                isOn: $isOn) {
                    HStack {
                        image.foregroundColor(Color.white).font(.largeTitle)
                        Text(title)
                            .font(.poppins(type: .medium, size: 14.0))
                            .foregroundColor(LKColors.xFEFEFE)
                    }
                }
                .toggleStyle(SwitchToggleStyle(tint: LKColors.x1C6EF2))
        }
        .padding(.vertical, 8.0)
        .padding(.horizontal, 4.0)
        .background(LKColors.x14131B)
    }
}

struct LKSwitch_Previews: PreviewProvider {
    
    static var previews: some View {
        ImageTitleToggle(
            image: Image(systemSymbol: .manatsignCircle),
            title: "Anonymous voting",
            isOn: .constant(true)
        )
    }
}
