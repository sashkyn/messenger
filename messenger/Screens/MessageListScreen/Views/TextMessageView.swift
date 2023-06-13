import SwiftUI
import URLImage

struct TextMessageView: View {
    
    let message: TextMessage
    
    var body: some View {
        HStack(alignment: .top) {
            AvatarView(user: message.sender)
            
            VStack(alignment: .leading) {
                Text(message.sender.fullName)
                    .font(.poppins(type: .semibold, size: 12.0))
                    .foregroundColor(LKColors.x7E7A9A)
                Text(message.content)
                    .font(.poppins(type: .regular, size: 15.0))
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
        )
        .background(LKColors.x14131B)
    }
}
