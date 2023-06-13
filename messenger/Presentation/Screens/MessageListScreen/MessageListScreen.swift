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
                                        TextMessageView(
                                            message: .init(
                                                id: message.id,
                                                sender: message.sender,
                                                content: "Not supported message"
                                            )
                                        )
                                    }
                                }
                                .onChange(of: viewModel.messages.count) { _ in
                                    scrollViewProxy.scrollTo(viewModel.messages.last?.id ?? 0)
                                }
                            }
                            .padding(16.0)
                        }
                        .hideKeyboardOnScroll()
                        .background(LKColors.x14131B)
                    }
                    Spacer()
                        .frame(height: 70.0)
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
                onClose: {}
            )
            .sheet(isPresented: $viewModel.isPollCreatorPresented) {
                PollCreatorScreen()
            }
        }
    }
}

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
