import Foundation
import Combine

protocol MessageService: AnyObject {
    
    var messages: [any Message] { get }
    var messagesPublisher: AnyPublisher<[any Message], Never> { get }
    
    func send(textMessage: TextMessage)
    func send(pollMessage: PollMessage)
    func select(pollOptionId: Int?, in pollMessageId: Int)
}

final class MockMessageService: MessageService {
    
    var messages: [any Message] {
        messagesSubject.value
    }
    
    var messagesPublisher: AnyPublisher<[any Message], Never> {
        messagesSubject.eraseToAnyPublisher()
    }
    
    private let messagesSubject = CurrentValueSubject<[any Message], Never>(Constants.messages)
    
    func send(textMessage: TextMessage) {
        messagesSubject.send(messages + [textMessage])
    }
    
    func send(pollMessage: PollMessage) {
        messagesSubject.send(messages + [pollMessage])
    }
    
    func select(pollOptionId: Int?, in pollMessageId: Int) {
        guard let pollMessage = messages.first(where: { message in message is PollMessage }),
              let poll = pollMessage.content as? Poll else {
            // TODO: обработка ошибок
            return
        }
        
        let newContent = Poll(
            title: poll.title,
            selectedOptionId: pollOptionId,
            options: poll.options
        )
        let newPollMessage = PollMessage(
            id: pollMessage.id,
            sender: pollMessage.sender,
            content: newContent
        )
        var newMessageArray = messages
        newMessageArray.removeAll { message in message.id == pollMessage.id }
        newMessageArray.append(newPollMessage)
        messagesSubject.send(newMessageArray)
    }
}

private struct Constants {
    
    static let messages: [any Message] = [
        TextMessage(
            id: 0,
            sender: .init(id: 1, firstName: "Aleksandr", lastName: "Martseniuk", avatarURL: nil),
            content: "Hello World!"
        ),
        TextMessage(
            id: 1,
            sender: .init(id: 2, firstName: "Kirill", lastName: "Baranov", avatarURL: nil),
            content: "Hello World!"
        ),
        TextMessage(
            id: 2,
            sender: .init(id: 3, firstName: "Evgeniy", lastName: "Usov", avatarURL: nil),
            content: "Hello World!"
        ),
        PollMessage(
            id: 3,
            sender: .init(id: 1, firstName: "Aleksandr", lastName: "Martseniuk", avatarURL: nil),
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
    ]
}
