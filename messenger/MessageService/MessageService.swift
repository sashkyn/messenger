import Foundation
import Combine

protocol MessageService: AnyObject {
    
    var user: User { get }
    var messages: [any Message] { get }
    var messagesPublisher: AnyPublisher<[any Message], Never> { get }
    
    func send(text: String)
    func send(poll: Poll)
    func select(pollOptionId: Int64?, inPollMessageId: Int64)
}
