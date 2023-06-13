import Foundation

struct TextMessage: ContentMessage {
    let id: Int64
    let sender: User
    let content: String
}
