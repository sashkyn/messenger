import Combine
import Factory

final class PollCreatorScreenViewModel: ObservableObject {
    
    @Injected(\.messageService)
    private var service: MessageService
    
    @Published var question: String = ""
    @Published var optionViewDataList: [PollEditOptionViewData] = []
    var isAnonymousOption: Bool = false
    var abilityToAddMoreOptions: Bool = false
    var questionLimitTitle: String { "\(question.count)/\(Constants.maxTitleSymbolCount)" }
    var questionEnterTextEnabled: Bool { question.count > Constants.maxTitleSymbolCount }
    var optionsLimitTitle: String { "\(optionViewDataList.count)/\(Constants.maxOptionCount)" }
    var addNewOptionEnabled: Bool { optionViewDataList.count < Constants.maxOptionCount }
    var createButtonEnabled: Bool {
        !optionViewDataList.isEmpty &&
        !question.isEmpty &&
        optionViewDataList.filter { $0.text.isEmpty }.isEmpty
    }
    
    @MainActor
    func appendPollOption() {
        let viewModel = PollEditOptionViewData(
            id: Int64(optionViewDataList.count),
            text: ""
        )
        optionViewDataList.append(viewModel)
    }
    
    @MainActor
    func removePollOption(optionId: Int64) {
        optionViewDataList.removeAll(where: { $0.id == optionId })
    }
    
    @MainActor
    func createPoll() {
        service.send(
            poll: Poll(
                title: question,
                options: optionViewDataList.map { PollOption(id: $0.id, text: $0.text) },
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
