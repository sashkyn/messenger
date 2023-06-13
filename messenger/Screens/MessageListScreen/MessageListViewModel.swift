import Combine
import Factory

final class MessageListViewModel: ObservableObject {
    
    @Injected(\.messageService)
    private var service: MessageService
    
    @Published var currentMessageText: String = ""
    @Published var messages: [any Message] = []
    @Published var isPollCreatorPresented: Bool = false
    var isSendButtonEnabled: Bool { !currentMessageText.isEmpty }

    private var cancellable: AnyCancellable?
    
    init() {
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
