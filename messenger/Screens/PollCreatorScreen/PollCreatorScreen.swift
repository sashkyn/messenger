import SwiftUI
import Combine

struct PollCreatorScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: PollCreatorScreenViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                LKColors.x14131B.ignoresSafeArea()
                VStack {
                    Form {
                        InfoSection(
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
                                        .padding(.horizontal, 8.0)
                                        .allowsHitTesting(false)
                                }
                            }
                        }
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
