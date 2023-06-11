import SwiftUI

struct PollMessageView: View {
    let message: PollMessage
    let onOption: (Int64?) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                AvatarView(user: message.sender)
                
                VStack(alignment: .leading) {
                    Text("Public poll")
                        .font(.poppins(type: .regular, size: 10.0))
                        .foregroundColor(LKColors.xFEFEFE)
                    Text(message.sender.fullName)
                        .font(.poppins(type: .bold, size: 15.0))
                        .foregroundColor(LKColors.xFEFEFE)
                }
                Spacer()
                
                ZStack {
                    Circle()
                        .frame(width: 50, height: 50.0)
                        .foregroundColor(LKColors.xAC1393)
                    VStack(spacing: -4) {
                        Text("\(message.content.answersCount)")
                            .font(.poppins(type: .semibold, size: 16.0))
                            .foregroundColor(LKColors.xFEFEFE)
                        Text("votes")
                            .font(.poppins(type: .regular, size: 10.0))
                            .foregroundColor(LKColors.xFEFEFE)
                    }
                }
            }
            Spacer().frame(height: 20.0)
            
            Text(message.content.title)
                .foregroundColor(.white)
                .font(.poppins(type: .medium, size: 15))
            
            ForEach(message.content.options, id: \.id) { option in
                let isSelected = option.id == message.getSelectedOptionId(senderId: message.sender.id)
                PollOptionView(
                    option: option,
                    isSelected: isSelected
                )
                .onTapGesture {
                    onOption(isSelected ? nil : option.id)
                }
            }
        }
        .padding()
        .background(
            LinearGradient(
                gradient:
                    Gradient(
                        colors: [
                            LKColors.xA83D7F,
                            Color.black
                        ]
                    ),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(15)
    }
}

struct PollOptionView: View {
    let option: PollOption
    let isSelected: Bool
    
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 16.0)
                    .foregroundColor(isSelected ? LKColors.x7E7A9A : LKColors.x1C6EF2.opacity(0.15))
                    .frame(height: 40.0)
                Text(option.text)
                    .font(.poppins(type: .regular, size: 12.0))
                    .foregroundColor(LKColors.xFEFEFE)
                    .padding(.leading, 16.0)
                    .padding(.trailing, 16.0)
            }
        }
    }
}

struct PollMessageView_Previews: PreviewProvider {
    
    static var previews: some View {
        PollMessageView(
            message: PollMessage(
                id: 3,
                sender: MockMessageService.Constants.developer1,
                content: .init(
                    title: "What technology will we choose?",
                    options: [
                        .init(id: 0, text: "SwiftUI"),
                        .init(id: 1, text: "UIKit"),
                        .init(id: 2, text: "Texture"),
                    ],
                    userAnswers: [:]
                )
            ),
            onOption: { _ in return }
        )
        .background(LKColors.x14131B)
    }
}
