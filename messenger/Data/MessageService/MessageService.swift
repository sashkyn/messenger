import Foundation
import Combine

protocol MessageService: AnyObject {
    
    var currentUser: User { get }
    var messages: [any ContentMessage] { get }
    var messagesPublisher: AnyPublisher<[any ContentMessage], Never> { get }
    
    func send(text: String)
    func send(poll: Poll)
    func select(pollOptionId: Int64?, inPollMessageId: Int64)
    func deleteAllMessages()
}
