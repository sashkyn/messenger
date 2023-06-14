import Foundation

protocol ContentMessage<Content> {
    associatedtype Content
    
    var id: Int64 { get }
    var sender: User { get }
    var content: Content { get }
}
