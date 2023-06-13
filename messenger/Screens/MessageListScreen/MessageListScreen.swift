import SwiftUI
import Combine
import URLImage

/// TODO:
///
/// !!! добавить боттом сдвиг контента чтобы text field не перекрывал сообщения
/// убрать сервис в контейнер
///
/// Design:
/// обрамить debug preview штуки
/// сделать белым цветом статус бар

struct MessageListScreen: View {
    
    @State
    var isPollCreatorPresented: Bool = false

    @ObservedObject
    var viewModel: MessageListViewModel

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                LKColors.x14131B.ignoresSafeArea()
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
                    }
                    .hideKeyboardOnScroll()
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
        MessageListScreen(
            viewModel: MessageListViewModel(
                service: MockMessageService()
            )
        )
    }
}
