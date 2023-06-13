import SwiftUI

struct LKSwitch: View {
    
    let title: String
    let image: Image
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
        .padding()
        .background(LKColors.x14131B)
    }
}

struct LKSwitch_Previews: PreviewProvider {
    
    static var previews: some View {
        LKSwitch(
            title: "Anonymous voting",
            image: Image(systemSymbol: .manatsignCircle),
            isOn: .constant(true)
        )
    }
}
