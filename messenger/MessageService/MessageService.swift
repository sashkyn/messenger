import Foundation
import Combine

protocol MessageService: AnyObject {
    
    var messages: [any Message] { get }
    var messagesPublisher: AnyPublisher<[any Message], Never> { get }
    
    func send(text: String)
    func send(poll: Poll)
    func select(pollOptionId: Int?, inPollMessageId: Int64)
}

final class MockMessageService: MessageService {
    
    var messages: [any Message] {
        messagesSubject.value
    }
    
    var messagesPublisher: AnyPublisher<[any Message], Never> {
        messagesSubject.eraseToAnyPublisher()
    }
    
    private let messagesSubject = CurrentValueSubject<[any Message], Never>(Constants.messages)
    
    func send(text: String) {
        let textMessage = TextMessage(
            id: Int64.random(in: 0..<9999999),
            sender: Constants.developer1,
            content: text
        )
        messagesSubject.send(messages + [textMessage])
    }
    
    func send(poll: Poll) {
        let pollMessage = PollMessage(
            id: Int64.random(in: 0..<9999999),
            sender: Constants.developer1,
            content: poll
        )
        messagesSubject.send(messages + [pollMessage])
    }
    
    func select(pollOptionId: Int?, inPollMessageId: Int64) {
        guard let pollMessageIndex = messages.firstIndex(where: { message in message.id == inPollMessageId }) else {
            return
        }
        
        let pollMessage = messages[pollMessageIndex]
    
        guard let poll = pollMessage.content as? Poll else {
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
        newMessageArray[pollMessageIndex] = newPollMessage
        messagesSubject.send(newMessageArray)
    }
}

extension MockMessageService {
    
    struct Constants {
        
        static let developer1: User = .init(id: 1, firstName: "Funky", lastName: "Tapir", avatarURL: URL(string: "https://i.pravatar.cc/40")!)
        static let developer2: User = .init(id: 2, firstName: "Empty", lastName: "Cat", avatarURL: URL(string: "https://i.pravatar.cc/40")!)
        static let developer3: User = .init(id: 3, firstName: "Crazy", lastName: "Frog", avatarURL: URL(string: "https://i.pravatar.cc/40")!)
        
        static let messages: [any Message] = [
            TextMessage(
                id: 0,
                sender: developer1,
                content: "Hello World!"
            ),
            TextMessage(
                id: 1,
                sender: developer2,
                content: "Hello World!"
            ),
            TextMessage(
                id: 2,
                sender: developer3,
                content: "Hello World!"
            ),
            PollMessage(
                id: 3,
                sender: developer1,
                content: .init(
                    title: "What technology will we choose?",
                    selectedOptionId: nil,
                    options: [
                        .init(id: 0, text: "SwiftUI"),
                        .init(id: 1, text: "UIKit"),
                        .init(id: 2, text: "Texture"),
                    ]
                )
            )
        ]
    }
}
