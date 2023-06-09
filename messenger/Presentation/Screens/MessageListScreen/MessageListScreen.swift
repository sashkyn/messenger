import SwiftUI
import Combine

struct MessageListScreen: View {
    
    @ObservedObject
    private var viewModel = MessageListViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                LKColors.x14131B.ignoresSafeArea()
                VStack {
                    ScrollViewReader { scrollViewProxy in
                        ScrollView(.vertical) {
                            LazyVStack {
                                ForEach(viewModel.messages, id: \.id) { message in
                                    switch message {
                                    case let textMessage as TextMessage:
                                        makeTextMessageView(textMessage: textMessage)
                                    case let pollMessage as PollMessage:
                                        makePollMessageView(pollMessage: pollMessage)
                                    default:
                                        makeUnsupportedMessage(message: message)
                                    }
                                }
                            }
                            .padding(16.0)
                        }
                        .onChange(of: viewModel.messages.count) { _ in
                            guard let lastMessageId = viewModel.messages.last?.id else {
                                return
                            }
                            scrollViewProxy.scrollTo(lastMessageId)
                        }
                        .hideKeyboardOnScroll()
                        .background(LKColors.x14131B)
                    }
                    Spacer().frame(height: 70.0)
                }
                VStack {
                    Spacer()
                    MessageTextField(
                        text: $viewModel.currentMessageText,
                        onLeadingAction: {
                            viewModel.isPollCreatorPresented = true
                        },
                        isTrailingActionEnabled: viewModel.isSendButtonEnabled,
                        onTrailingAction: {
                            viewModel.send(text: viewModel.currentMessageText)
                        }
                    )
                }
            }
            .messageListAppBar(
                title: "LowKey Squad",
                subtitle: "1 member • 1 online",
                onClose: {
                    viewModel.deleteAllMessages()
                }
            )
            .sheet(isPresented: $viewModel.isPollCreatorPresented) {
                PollCreatorScreen()
            }
        }
    }
}

// MARK: MessageView Factory

private extension MessageListScreen {
    
    func makeTextMessageView(textMessage: TextMessage) -> some View {
        TextMessageView(message: textMessage)
    }
    
    func makePollMessageView(pollMessage: PollMessage) -> some View {
        PollMessageView(
            message: pollMessage,
            onOption: { optionId in
                viewModel.select(
                    pollOptionId: optionId,
                    inPollMessageId: pollMessage.id
                )
            }
        )
    }
    
    func makeUnsupportedMessage(message: any ContentMessage) -> some View {
        TextMessageView(
            message: .init(
                id: message.id,
                sender: message.sender,
                content: "Not supported message"
            )
        )
    }
}

// MARK: AppBar Customization

private extension View {
    
    func messageListAppBar(
        title: String,
        subtitle: String,
        onClose: @escaping () -> Void
    ) -> some View {
        self
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar(content: {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text(title)
                            .font(.poppins(type: .semibold, size: 16.0))
                            .foregroundColor(LKColors.xFEFEFE)
                        Text(subtitle)
                            .font(.poppins(type: .regular, size: 12.0))
                            .foregroundColor(LKColors.x7E7A9A)
                    }
                }
            })
            .navigationBarItems(
                leading: Button(
                    action: onClose,
                    label: {
                        Image(systemSymbol: .xmark)
                            .foregroundColor(LKColors.xFEFEFE)
                    }
                )
            )
    }
}

// MARK: Preview

struct MessageListScreen_Previews: PreviewProvider {
    
    static var previews: some View {
        MessageListScreen()
    }
}
