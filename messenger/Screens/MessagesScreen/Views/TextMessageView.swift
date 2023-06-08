import SwiftUI
import URLImage

// TODO: изменить шрифты и размеры
// TODO: закруглить аватарку

struct TextMessageView: View {
    let message: TextMessage
    
    var body: some View {
        HStack(alignment: .top) {
            URLImage(message.sender.avatarURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .padding(.trailing, 10)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(message.sender.fullName)
                    .font(.headline)
                    .foregroundColor(.blue)
                Text(message.content)
                    .font(.body)
                    .foregroundColor(.black)
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
    }
}
