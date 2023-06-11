import SwiftUI
import Combine

/// TODO:
/// bug with deletion on textfield tap

struct PollEditOptionViewModel: Identifiable {
    let id: Int64
    var text: String
}

struct PollEditOptionView: View {
    
    @Binding var viewModel: PollEditOptionViewModel
    
    let onDelete: () -> Void
    
    var body: some View {
        HStack {
            TextField("Option", text: $viewModel.text)
            Spacer()
            Button(action: {
                clearFocus()
                onDelete()
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.red)
            }
        }
    }
    
    private func clearFocus() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for:nil
        )
    }
}

struct PollEditOptionView_Previews: PreviewProvider {

    static var previews: some View {
        PollEditOptionView(
            viewModel: Binding(
                get: { PollEditOptionViewModel(id: 0, text: "Option 1") },
                set: { newValue, transaction in }),
            onDelete: {
                print("onDelete")
            }
        )
    }
}
