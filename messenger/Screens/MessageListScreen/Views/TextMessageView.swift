import SwiftUI
import URLImage

// TODO: изменить шрифты и размеры
// TODO: закруглить аватарку

struct TextMessageView: View {
    let message: TextMessage
    
    var body: some View {
        HStack(alignment: .top) {
            AvatarView(user: message.sender)
            
            VStack(alignment: .leading, spacing: 4.0) {
                Text(message.sender.fullName)
                    .font(.system(size: 12.0))
                    .foregroundColor(LKColors.x7E7A9A)
                Text(message.content)
                    .font(.body)
                    .font(.system(size: 15.0))
                    .foregroundColor(LKColors.xFEFEFE)
            }
            Spacer()
        }
        .padding()
    }
}

struct TextMessageView_Previews: PreviewProvider {
    
    static var previews: some View {
        TextMessageView(
            message: TextMessage(
                id: 0,
                sender: MockMessageService.Constants.developer1,
                content: """
                Hello World! asdgsdg asdg asd gjasd;lg hasdlkg hasdlkg hasd;lg
                hasdlg hadslg hadslgk jadslg kjadhsl gkasd
                asdgasdgasdgasdg asd
                asdg asdg asdg asdgasdgasdg
                """
            )
        ).background(LKColors.x14131B)
    }
}

struct AvatarView: View {
    
    let user: User
    
    var body: some View {
        ZStack {
            Circle()
                .fill(LKColors.x03114398)
                .frame(width: 16 * 2, height: 16 * 2)
            Text(user.firstName.prefix(1))
        }
    }
}
