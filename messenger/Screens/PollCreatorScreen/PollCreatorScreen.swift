import SwiftUI
import Combine

/// TODO logic:
/// limitation of enter text
/// option - textfield with limitation

final class PollCreatorScreenViewModel: ObservableObject {
    
    @Published var question: String = ""
    @Published var optionViewModels: [PollEditOptionViewModel] = []
    @Published var isAnonymousOption: Bool = false
    @Published var abilityToAddMoreOptions: Bool = false
    
    var createButtonEnabled: Bool {
        !optionViewModels.isEmpty && !question.isEmpty
    }
    
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
                    Section(header: Text("Question")) {
                        TextField("Ask a question", text: $viewModel.question)
                    }
                    
                    Section(header: Text("Options")) {
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
                                .foregroundColor(.blue)
                        }
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
            .navigationTitle("New poll")
            .navigationBarItems(
                leading: Button(
                    action: {
                        presentationMode.wrappedValue.dismiss()
                    }
                ) {
                    Image(systemName: "xmark.circle.fill")
                },
                trailing: Button(
                    action: {
                        viewModel.createPoll()
                        presentationMode.wrappedValue.dismiss()
                    }
                ) {
                    Text("Create")
                }
                    .disabled(!viewModel.createButtonEnabled)
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        PollCreatorScreen(
            viewModel: PollCreatorScreenViewModel(
                service: MockMessageService()
            )
        )
    }
}
