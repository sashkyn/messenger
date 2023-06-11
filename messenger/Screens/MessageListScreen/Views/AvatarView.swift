import SwiftUI

struct AvatarView: View {
    
    let user: User
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(user.avatarColor)
                .frame(width: 40, height: 40)
            Text(user.firstName.prefix(1))
                .font(.poppins(type: .regular, size: 24))
                .foregroundColor(.white)
        }
    }
}
