import SwiftUI
import Combine

final class PollCreatorScreenViewModel: ObservableObject {
    
    @Published var question: String = ""
    @Published var optionViewModels: [PollEditOptionViewModel] = []
    var isAnonymousOption: Bool = false
    var abilityToAddMoreOptions: Bool = false
    var createButtonEnabled: Bool { !optionViewModels.isEmpty && !question.isEmpty }
    var questionLimitTitle: String { "\(question.count) / \(Constants.maxTitleSymbolCount)" }
    var questionLimitEnabled: Bool { question.count > Constants.maxTitleSymbolCount }
    var optionLimitTitle: String { "\(optionViewModels.count) / \(Constants.maxOptionCount)" }
    var optionLimitEnabled: Bool { optionViewModels.count >= Constants.maxOptionCount }
    
    private let service: MessageService
    
    init(service: MessageService) {
        self.service = service
    }
    
    func appendPollOption() {
        let viewModel = PollEditOptionViewModel(id: optionViewModels.count, text: "")
        optionViewModels.append(viewModel)
    }
    
    func removePollOption(optionId: Int) {
        optionViewModels.removeAll(where: { $0.id == optionId })
    }
    
    func createPoll() {
        service.send(
            poll: Poll(
                title: question,
                selectedOptionId: nil,
                options: optionViewModels.map { PollOption(id: $0.id, text: $0.text) }
            )
        )
    }
}

struct PollCreatorScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: PollCreatorScreenViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(
                        header: HStack {
                            Text("Question")
                            Spacer()
                            Text(viewModel.questionLimitTitle)
                        }
                    ) {
                        TextField(
                            "Ask a question",
                            text: $viewModel.question.limitedSet(
                                predicate: { text in viewModel.questionLimitEnabled }
                            )
                        )
                    }
                    
                    Section(
                        header: HStack {
                            Text("Options")
                            Spacer()
                            Text(viewModel.optionLimitTitle)
                        }
                    ) {
                        ForEach($viewModel.optionViewModels) { optionViewModel in
                            PollEditOptionView(
                                viewModel: optionViewModel,
                                onDelete: {
                                    viewModel.removePollOption(optionId: optionViewModel.wrappedValue.id)
                                }
                            )
                        }
                        
                        Button(action: viewModel.appendPollOption) {
                            Text("Add an option")
                        }
                            .disabled(viewModel.optionLimitEnabled)
                    }
                    
                    Section(header: Text("Switches")) {
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
            }
            .modalAppBar(
                title: "New poll",
                trailingTitle: "Create",
                onTrailingAction: viewModel.createButtonEnabled ? {
                    viewModel.createPoll()
                    presentationMode.wrappedValue.dismiss()
                } : nil,
                onClose: {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
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
