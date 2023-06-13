import Foundation

protocol Message<Content>: Identifiable {
    associatedtype Content
    
    var id: Int64 { get }
    var sender: User { get }
    var content: Content { get }
}

// MARK: Text Message

struct TextMessage: Message {
    let id: Int64
    let sender: User
    let content: String
}

// MARK: Poll Message

struct PollMessage: Message {
    let id: Int64
    let sender: User
    let content: Poll
}

struct Poll {
    let title: String
    let options: [PollOption]
    let userAnswers: [Int64: Int64]
}

struct PollOption {
    let id: Int64
    let text: String
}
