import SwiftUI

struct AvatarView: View {

    let color: Color
    let text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15.0)
                .fill(color)
                .frame(width: 40.0, height: 40.0)
            Text(text)
                .font(.poppins(type: .regular, size: 24.0))
                .foregroundColor(.white)
        }
    }
}

// MARK: Preview

struct AvatarView_Previews: PreviewProvider {
    
    static var previews: some View {
        AvatarView(
            color: LKColors.x14131B,
            text: "F"
        )
    }
}
