import SwiftUI

struct AvatarView: View {

    let color: Color
    let text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(color)
                .frame(width: 40, height: 40)
            Text(text)
                .font(.poppins(type: .regular, size: 24))
                .foregroundColor(.white)
        }
    }
}

// MARK: Preview

struct AvatarView_Previews: PreviewProvider {
    
    static var previews: some View {
        AvatarView(
            color: LKColors.x14131B,
            text: "Funky Tapir"
        )
    }
}
