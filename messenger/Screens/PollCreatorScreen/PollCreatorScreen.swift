import SwiftUI
import Combine

/// TODO logic:
/// close - title create
/// creation action
/// logic from service
/// limitation of enter text
/// option - textfield with limitation

/// TODO: Design:
/// option - text with delete action

final class PollCreatorScreenViewModel: ObservableObject {
    
    @Published
    var question: String = ""
    
    @Published
    var isAnonymousOption: Bool = false
    
    @Published
    var optionViewModels: [PollEditOptionViewModel] = []
    
    @Published
    var abilityToAddMoreOptions: Bool = false
    
    func appendPollOption() {
        let viewModel = PollEditOptionViewModel(id: optionViewModels.count, text: "")
        optionViewModels.append(viewModel)
    }
    
    func removePollOption(optionId: Int) {
        optionViewModels.removeAll(where: { $0.id == optionId })
    }
}

struct PollCreatorScreen: View {
    
    @ObservedObject
    var viewModel: PollCreatorScreenViewModel
    
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
            .navigationTitle("Create poll")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        PollCreatorScreen(
            viewModel: PollCreatorScreenViewModel()
        )
    }
}
