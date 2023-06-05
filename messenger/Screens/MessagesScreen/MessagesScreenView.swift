import SwiftUI
import Combine
import URLImage

// TODO: добавить энум с картинками SFSymbols
// TODO: сделать изменение контента не по id а по Content
// TODO: добавить экран с созданием полл-а

// TODO: кастомный апп бар
// TODO: скролить в самый низ всегда
// TODO: закешировать картинки
// TODO: добавить паддинг снизу
// TODO: статичные аватарки которые загружены один раз
// TODO: обрамить debug preview штуки

final class MessagesScreenViewModel: ObservableObject {
    
    @Published
    var textMessage: String = ""
    
    @Published
    var messages: [any Message] = []
    
    private let service: MessageService
    private var cancellable: AnyCancellable?
    
    init(service: MessageService) {
        self.service = service
        
        self.cancellable = service.messagesPublisher
            .sink(receiveValue: { [weak self] messages in self?.messages = messages })
    }
    
    func send(text: String) {
        service.send(text: text)
        textMessage = ""
    }
    
    func select(pollOptionId: Int, inPollMessageId: Int64) {
        service.select(pollOptionId: pollOptionId, inPollMessageId: inPollMessageId)
    }
}

struct MessagesScreenView: View {

    @ObservedObject
    var viewModel: MessagesScreenViewModel

    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(.vertical) {
                    LazyVStack {
                        ForEach(viewModel.messages, id: \.hashValue) { item in
                            switch item {
                            case let textMessage as TextMessage:
                                TextMessageView(message: textMessage)
                            case let pollMessage as PollMessage:
                                PollMessageView(
                                    pollMessage: pollMessage,
                                    onOption: { optionId in
                                        viewModel.select(
                                            pollOptionId: optionId,
                                            inPollMessageId: item.id
                                        )
                                    }
                                )
                            default:
                                Text("No supported message")
                            }
                        }
                    }
                }
                VStack {
                    Spacer()
                    MessageTextField(
                        text: $viewModel.textMessage,
                        onPoll: {
                            print("TODO: open poll creation")
                        }, onSend: {
                            viewModel.send(text: viewModel.textMessage)
                        })
                }
            }.navigationTitle("Developers chat")
        }
    }
}

struct MessagesScreenView_Previews: PreviewProvider {
    
    static var previews: some View {
        MessagesScreenView(
            viewModel: MessagesScreenViewModel(
                service: MockMessageService()
            )
        )
    }
}
