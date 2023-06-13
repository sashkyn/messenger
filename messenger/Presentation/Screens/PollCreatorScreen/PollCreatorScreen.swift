import SwiftUI
import Combine

struct PollCreatorScreen: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject
    private var viewModel = PollCreatorScreenViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                LKColors.x14131B.ignoresSafeArea()
                ScrollView {
                    VStack {
                        InfoSection(
                            leadingTitle: "Question",
                            trailingTitle: viewModel.questionLimitTitle,
                            backgroundColor: LKColors.x114398
                        ) {
                            ExpandableTextEditor(
                                text: $viewModel.question.limitedSet(
                                    predicate: { _ in viewModel.questionEnterTextEnabled }
                                ),
                                placeholderText: "Ask a question"
                            )
                            .cornerRadius(12.0)
                        }
                        Spacer().frame(height: 25.0)
                        InfoSection(
                            leadingTitle: "Options",
                            trailingTitle: viewModel.optionsLimitTitle,
                            backgroundColor: .clear
                        ) {
                            ForEach($viewModel.optionViewModels) { optionViewModel in
                                PollEditOptionView(
                                    viewModel: optionViewModel,
                                    onDelete: {
                                        viewModel.removePollOption(optionId: optionViewModel.wrappedValue.id)
                                    }
                                )
                                .cornerRadius(10.0)
                            }
                            
                            if (viewModel.addNewOptionEnabled) {
                                PollAddAnOptionView(
                                    action: { viewModel.appendPollOption() }
                                )
                                .cornerRadius(10.0)
                            }
                        }
                        Spacer().frame(height: 25.0)
                        InfoSection(backgroundColor: .clear) {
                            ImageTitleToggle(
                                image: Image(systemSymbol: .iCircleFill),
                                title: "Anonymous voting",
                                isOn: $viewModel.isAnonymousOption
                            )
                            ImageTitleToggle(
                                image: Image(systemSymbol: .dollarsignCircle),
                                title: "Ability to add more options",
                                isOn: $viewModel.abilityToAddMoreOptions
                            )
                        }
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
                    .padding()
                }
            }
        }
    }
}

// MARK: AppBar Customization

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
                    Text(title)
                        .font(.poppins(type: .semibold, size: 16.0))
                        .foregroundColor(LKColors.xFEFEFE)
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
        PollCreatorScreen()
    }
}
