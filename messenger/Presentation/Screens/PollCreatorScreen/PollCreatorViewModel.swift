import Combine
import Factory

final class PollCreatorScreenViewModel: ObservableObject {
    
    @Injected(\.messageService)
    private var service: MessageService
    
    @Published var question: String = ""
    @Published var optionViewModels: [PollEditOptionViewModel] = []
    var isAnonymousOption: Bool = false
    var abilityToAddMoreOptions: Bool = false
    var questionLimitTitle: String { "\(question.count)/\(Constants.maxTitleSymbolCount)" }
    var questionEnterTextEnabled: Bool { question.count > Constants.maxTitleSymbolCount }
    var optionsLimitTitle: String { "\(optionViewModels.count)/\(Constants.maxOptionCount)" }
    var addNewOptionEnabled: Bool { optionViewModels.count < Constants.maxOptionCount }
    var createButtonEnabled: Bool {
        !optionViewModels.isEmpty &&
        !question.isEmpty &&
        optionViewModels.filter { $0.text.isEmpty }.isEmpty
    }
    
    @MainActor
    func appendPollOption() {
        let viewModel = PollEditOptionViewModel(
            id: Int64(optionViewModels.count),
            text: ""
        )
        optionViewModels.append(viewModel)
    }
    
    @MainActor
    func removePollOption(optionId: Int64) {
        optionViewModels.removeAll(where: { $0.id == optionId })
    }
    
    @MainActor
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

// MARK: Constants

private extension PollCreatorScreenViewModel {
    
    struct Constants {
        static let maxTitleSymbolCount: Int = 50
        static let maxOptionCount: Int = 8
    }
}
