import Foundation

struct PollMessage: ContentMessage {
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
