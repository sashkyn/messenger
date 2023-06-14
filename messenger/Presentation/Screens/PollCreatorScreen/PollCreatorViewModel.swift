import Combine
import Factory

final class PollCreatorViewModel: ObservableObject {
    
    @Injected(\.messageService)
    private var service: MessageService
    
    @Published var question: String = ""
    @Published var options: [PollEditOptionView.ViewData] = []
    var isAnonymousOption: Bool = false
    var abilityToAddMoreOptions: Bool = false
    var questionLimitTitle: String { "\(question.count)/\(Constants.maxTitleSymbolCount)" }
    var questionEnterTextEnabled: Bool { question.count > Constants.maxTitleSymbolCount }
    var optionsLimitTitle: String { "\(options.count)/\(Constants.maxOptionCount)" }
    var addNewOptionEnabled: Bool { options.count < Constants.maxOptionCount }
    var createButtonEnabled: Bool {
        !options.isEmpty &&
        !question.isEmpty &&
        options.filter { $0.text.isEmpty }.isEmpty
    }
    
    @MainActor
    func appendPollOption() {
        let viewData = PollEditOptionView.ViewData(
            id: (options.max(by: { $0.id < $1.id })?.id ?? 0) + 1,
            text: ""
        )
        options.append(viewData)
    }
    
    @MainActor
    func removePollOption(optionId: Int64) {
        options.removeAll(where: { $0.id == optionId })
    }
    
    @MainActor
    func createPoll() {
        service.send(
            poll: Poll(
                title: question,
                options: options.map { PollOption(id: $0.id, text: $0.text) },
                userAnswers: [:]
            )
        )
    }
}

// MARK: Constants

private extension PollCreatorViewModel {
    
    struct Constants {
        static let maxTitleSymbolCount: Int = 50
        static let maxOptionCount: Int = 8
    }
}
