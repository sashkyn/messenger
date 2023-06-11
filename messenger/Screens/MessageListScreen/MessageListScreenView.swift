import SwiftUI
import Combine
import URLImage

/// TODO:
///
/// !!! добавить боттом сдвиг контента чтобы text field не перекрывал сообщения
/// убрать сервис в контейнер
///
/// Design:
/// закешировать картинки
/// статичные аватарки которые загружены один раз
/// обрамить debug preview штуки
/// сделать чтобы за полл можно было голосовать от глобального айди пользователя а не от сендера

final class MessageListScreenViewModel: ObservableObject {
    
    @Published var textMessage: String = ""
    @Published var messages: [any Message] = []
    
    let service: MessageService
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
    
    func select(pollOptionId: Int64?, inPollMessageId: Int64) {
        service.select(
            pollOptionId: pollOptionId,
            inPollMessageId: inPollMessageId
        )
    }
}

struct MessageListScreenView: View {
    
    @State
    var isPollCreatorPresented: Bool = false

    @ObservedObject
    var viewModel: MessageListScreenViewModel

    var body: some View {
        NavigationView {
            ZStack {
                ScrollViewReader { scrollViewProxy in
                    ScrollView(.vertical) {
                        LazyVStack {
                            ForEach(viewModel.messages, id: \.id) { message in
                                switch message {
                                case let textMessage as TextMessage:
                                    TextMessageView(message: textMessage)
                                case let pollMessage as PollMessage:
                                    PollMessageView(
                                        message: pollMessage,
                                        onOption: { optionId in
                                            viewModel.select(
                                                pollOptionId: optionId,
                                                inPollMessageId: message.id
                                            )
                                        }
                                    )
                                default:
                                    let notSupportedTextMessage = TextMessage(
                                        id: message.id,
                                        sender: message.sender,
                                        content: "No supported message"
                                    )
                                    TextMessageView(message: notSupportedTextMessage)
                                }
                            }
                            .onChange(of: viewModel.messages.count) { _ in
                                scrollViewProxy.scrollTo(viewModel.messages.last?.id ?? 0)
                            }
                        }
                    }
                    .background(LKColors.x14131B)
                }
                VStack {
                    Spacer()
                    MessageTextField(
                        text: $viewModel.textMessage,
                        onLeadingAction: {
                            isPollCreatorPresented = true
                        },
                        onTrailingAction: {
                            viewModel.send(text: viewModel.textMessage)
                        }
                    )
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .messageListAppBar(
                title: "LowKey Squad",
                subtitle: "1 member • 1 online",
                onClose: {}
            )
            .sheet(isPresented: $isPollCreatorPresented) {
                PollCreatorScreen(
                    viewModel: PollCreatorScreenViewModel(
                        service: viewModel.service
                    )
                )
            }
        }
    }
}

struct MessagesScreenView_Previews: PreviewProvider {
    
    static var previews: some View {
        MessageListScreenView(
            viewModel: MessageListScreenViewModel(
                service: MockMessageService()
            )
        )
    }
}
