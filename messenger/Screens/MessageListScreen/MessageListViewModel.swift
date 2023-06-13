import Combine

final class MessageListViewModel: ObservableObject {
    
    @Published var currentMessageText: String = ""
    @Published var messages: [any Message] = []
    var isSendButtonEnabled: Bool { !currentMessageText.isEmpty }
    
    let service: MessageService
    private var cancellable: AnyCancellable?
    
    init(service: MessageService) {
        self.service = service
        
        self.cancellable = service.messagesPublisher
            .sink(receiveValue: { [weak self] messages in self?.messages = messages })
    }
    
    func send(text: String) {
        guard !text.isEmpty else {
            return
        }
        
        service.send(text: text)
        currentMessageText = ""
    }
    
    func select(pollOptionId: Int64?, inPollMessageId: Int64) {
        service.select(
            pollOptionId: pollOptionId,
            inPollMessageId: inPollMessageId
        )
    }
}
