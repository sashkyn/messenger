import SwiftUI
import Combine

final class PollCreatorScreenViewModel: ObservableObject {
    
    @Published var question: String = ""
    @Published var optionViewModels: [PollEditOptionViewModel] = []
    var isAnonymousOption: Bool = false
    var abilityToAddMoreOptions: Bool = false
    var createButtonEnabled: Bool { !optionViewModels.isEmpty && !question.isEmpty }
    var questionLimitTitle: String { "\(question.count)/\(Constants.maxTitleSymbolCount)" }
    var questionEnterTextEnabled: Bool { question.count > Constants.maxTitleSymbolCount }
    var optionsLimitTitle: String { "\(optionViewModels.count)/\(Constants.maxOptionCount)" }
    var addNewOptionEnabled: Bool { optionViewModels.count < Constants.maxOptionCount }
    
    private let service: MessageService
    
    init(service: MessageService) {
        self.service = service
    }
    
    @MainActor
    func appendPollOption() {
        let viewModel = PollEditOptionViewModel(
            id: Int64(optionViewModels.count),
            text: ""
        )
        optionViewModels.append(viewModel)
    }
    
    func removePollOption(optionId: Int64) {
        optionViewModels.removeAll(where: { $0.id == optionId })
    }
    
    func createPoll() {
        service.send(
            poll: Poll(
                title: question,
                options: optionViewModels.map { PollOption(id: $0.id, text: $0.text) },
                userAnswers: [:]
            )
        )
    }
}

struct PollCreatorScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: PollCreatorScreenViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                LKColors.x14131B.ignoresSafeArea()
                VStack {
                    Form {
                        LKSection(
                            leadingTitle: "Question",
                            trailingTitle: viewModel.questionLimitTitle,
                            backgroundColor: LKColors.x114398
                        ) {
                            ZStack(alignment: .leading) {
                                TextEditor(
                                    text: $viewModel.question.limitedSet(
                                        predicate: { _ in viewModel.questionEnterTextEnabled }
                                    )
                                )
                                .font(.poppins(type: .regular, size: 15.0))
                                .transparentScrolling()
                                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                                .background(LKColors.x2E2C3C)
                                .cornerRadius(10.0)
                                .foregroundColor(LKColors.xFEFEFE)
                                
                                if viewModel.question.isEmpty {
                                    Text("Ask a question")
                                        .font(.poppins(type: .regular, size: 15.0))
                                        .background(LKColors.x2E2C3C)
                                        .foregroundColor(LKColors.x7E7A9A)
                                        .padding(.leading, 8.0)
                                        .padding(.trailing, 8.0)
                                        .allowsHitTesting(false)
                                }
                            }
                        }
                        LKSection(
                            leadingTitle: "Options",
                            trailingTitle: viewModel.optionsLimitTitle,
                            backgroundColor: .clear
                        ) {
                            ForEach($viewModel.optionViewModels, id: \.id) { optionViewModel in
                                PollEditOptionView(
                                    viewModel: optionViewModel,
                                    onDelete: {
                                        viewModel.removePollOption(optionId: optionViewModel.wrappedValue.id)
                                    }
                                )
                                .cornerRadius(10.0)
                                .padding(.vertical, 4.0)
                            }
                            
                            if (viewModel.addNewOptionEnabled) {
                                PollAddAnOptionView(
                                    action: { viewModel.appendPollOption() }
                                )
                                .cornerRadius(10.0)
                                .padding(.vertical, 4.0)
                            }
                        }
                        
                        LKSection(backgroundColor: .clear) {
                            Toggle(
                                "Anonymous voting",
                                isOn: $viewModel.isAnonymousOption
                            )
                            Toggle(
                                "Ability to add more options",
                                isOn: $viewModel.abilityToAddMoreOptions
                            )
                        }
                    }
                    .transparentScrolling()
                }
                .modalAppBar(
                    title: "New poll",
                    trailingTitle: "Create",
                    trailingActionEnabled: viewModel.createButtonEnabled,
                    onTrailingAction: {
                        viewModel.createPoll()
                        presentationMode.wrappedValue.dismiss()
                    },
                    onClose: {
                        presentationMode.wrappedValue.dismiss()
                    }
                )
                .background(LKColors.x14131B)
            }
        }
    }
}

private extension View {
    
    func modalAppBar(
        title: String,
        trailingTitle: String,
        trailingActionEnabled: Bool,
        onTrailingAction: @escaping () -> Void,
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
                ),
                trailing:
                    Button(
                        action: onTrailingAction,
                        label: {
                            Text(trailingTitle)
                                .font(.poppins(type: .medium, size: 14.0))
                                .foregroundColor(trailingActionEnabled ? LKColors.x1C6EF2 : LKColors.x7E7A9A)
                        }
                    )
                    .disabled(!trailingActionEnabled)
            )
    }
}

// MARK: Preview

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        PollCreatorScreen(
            viewModel: PollCreatorScreenViewModel(
                service: MockMessageService()
            )
        )
    }
}

// MARK: Constants

private extension PollCreatorScreenViewModel {
    
    struct Constants {
        static let maxTitleSymbolCount: Int = 50
        static let maxOptionCount: Int = 8
    }
}
