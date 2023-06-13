import Combine

final class MockMessageService: MessageService {
    
    var currentUser: User { Constants.developer1 }
    
    var messages: [any ContentMessage] {
        messagesSubject.value
    }
    
    var messagesPublisher: AnyPublisher<[any ContentMessage], Never> {
        messagesSubject.eraseToAnyPublisher()
    }
    
    private let messagesSubject = CurrentValueSubject<[any ContentMessage], Never>(Constants.messages)
    
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
    
    func select(pollOptionId: Int64?, inPollMessageId: Int64) {
        guard let pollMessageIndex = messages.firstIndex(where: { message in message.id == inPollMessageId }) else {
            return
        }
        
        let pollMessage = messages[pollMessageIndex]
    
        guard let poll = pollMessage.content as? Poll else {
            return
        }
        
        var userAnswers = poll.userAnswers
        userAnswers[currentUser.id] = pollOptionId
        
        let newContent = Poll(
            title: poll.title,
            options: poll.options,
            userAnswers: userAnswers
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
        
        static let developer1: User = .init(id: 1, firstName: "Funky", lastName: "Tapir")
        static let developer2: User = .init(id: 2, firstName: "Empty", lastName: "Cat")
        static let developer3: User = .init(id: 3, firstName: "Crazy", lastName: "Frog")
        
        static let messages: [any ContentMessage] = [
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
                    options: [
                        .init(id: 0, text: "SwiftUI"),
                        .init(id: 1, text: "UIKit"),
                        .init(id: 2, text: "Texture"),
                    ],
                    userAnswers: [:]
                )
            )
        ]
    }
}
