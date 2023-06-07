import SwiftUI
import Combine
import URLImage

/// TODO:
/// убрать сервис в контейнер
/// добавить боттом сдвиг контента чтобы text field не перекрывал сообщения
/// скролить в самый низ всегда
///
/// Design:
/// кастомный апп бар
/// закешировать картинки
/// статичные аватарки которые загружены один раз
/// обрамить debug preview штуки

final class MessagesScreenViewModel: ObservableObject {
    
    var textMessage: String = ""
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
    
    func select(pollOptionId: Int, inPollMessageId: Int64) {
        service.select(
            pollOptionId: pollOptionId,
            inPollMessageId: inPollMessageId
        )
    }
}

struct MessagesScreenView: View {
    
    @State
    var isPollCreatorPresented: Bool = false

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
            .navigationTitle("Developers chat")
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
        MessagesScreenView(
            viewModel: MessagesScreenViewModel(
                service: MockMessageService()
            )
        )
    }
}
