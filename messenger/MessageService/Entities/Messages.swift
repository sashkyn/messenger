import Foundation

protocol Message<Content>: Hashable, Identifiable {
    associatedtype Content: Hashable
    
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

struct Poll: Hashable {
    let title: String
    let selectedOptionId: Int?
    let options: [PollOption]
}

struct PollOption: Hashable {
    let id: Int
    let text: String
}
