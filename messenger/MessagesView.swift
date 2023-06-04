import SwiftUI
import Combine

// TODO: кастомный

final class MessagesViewModel: ObservableObject {
    
    @Published
    var textMessage: String = ""
    
    @Published
    var messages: [any Message] = []
    
    private let service: MessageService
    private var cancellable: AnyCancellable? = nil
    
    init(service: MessageService) {
        self.service = service
        
        self.cancellable = service.messagesPublisher
            .sink(receiveValue: { [weak self] messages in self?.messages = messages })
    }
    
    func send(text: String) {
        service.send(text: text)
        textMessage = ""
    }
}

struct MessagesView: View {

    @ObservedObject
    var viewModel: MessagesViewModel

    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(.vertical) {
                    LazyVStack {
                        ForEach(viewModel.messages, id: \.id) { item in
                            switch item {
                            case let textMessage as TextMessage:
                                TextMessageCell(item: textMessage.content)
                            case let pollMessage as PollMessage:
                                TextMessageCell(item: "\(pollMessage.id)")
                            default:
                                Text("No supported message")
                            }
                        }
                    }
                }
                VStack {
                    Spacer()
                    HStack {
                        Button(action: {
                            print("TODO: open poll creation")
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .font(.title)
                        }
                        TextField("Message", text: $viewModel.textMessage)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button(action: {
                            viewModel.send(text: viewModel.textMessage)
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .font(.title)
                        }
                    }
                }
            }.navigationTitle("Developer chat")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView(
            viewModel: MessagesViewModel(
                service: MockMessageService()
            )
        )
    }
}

// MARK: Message Cell

struct TextMessageCell: View {
    let item: String

    var body: some View {
        VStack {
            Text(item)
                .font(.headline)
                .foregroundColor(.black)
                .padding()
        }
            .background(Color.white)
            .cornerRadius(10)
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
    }
}
