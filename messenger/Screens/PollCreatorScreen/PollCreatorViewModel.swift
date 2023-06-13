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

// MARK: Constants

private extension PollCreatorScreenViewModel {
    
    struct Constants {
        static let maxTitleSymbolCount: Int = 50
        static let maxOptionCount: Int = 8
    }
}
