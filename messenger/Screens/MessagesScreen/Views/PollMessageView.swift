import SwiftUI

// TODO: сделать возможность выбора опции с колбеками

// TODO: изменить шрифты и размеры
// TODO: добавить градиент
// TODO: добавить каунтер
// TODO: добавить линии

struct PollMessageView: View {
    let pollMessage: PollMessage
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(pollMessage.sender.fullName)
                .font(.headline)
                .foregroundColor(.blue)
            
            Text(pollMessage.content.title)
                .font(.title)
                .fontWeight(.bold)
            
            ForEach(pollMessage.content.options, id: \.id) { option in
                PollOptionView(option: option, isSelected: option.id == pollMessage.content.selectedOptionId)
            }
        }
        .padding()
    }
}

struct PollOptionView: View {
    let option: PollOption
    let isSelected: Bool
    
    var body: some View {
        HStack {
            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                .foregroundColor(isSelected ? .blue : .gray)
            
            Text(option.title)
                .font(.body)
            
            Spacer()
        }
    }
}

struct PollMessageView_Previews: PreviewProvider {
    
    static var previews: some View {
        PollMessageView(
            pollMessage: PollMessage(
                id: 3,
                sender: MockMessageService.Constants.developer1,
                content: .init(
                    title: "What technology we will choose?",
                    selectedOptionId: nil,
                    options: [
                        .init(id: 0, title: "SwiftUI"),
                        .init(id: 1, title: "UIKit"),
                        .init(id: 2, title: "Texture"),
                    ]
                )
            )
        )
    }
}
