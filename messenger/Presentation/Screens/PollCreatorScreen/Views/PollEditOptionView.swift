import SwiftUI
import Combine

extension PollEditOptionView {
    
    struct ViewData: Identifiable {
        let id: Int64
        var text: String
    }
}

struct PollEditOptionView: View {
    
    @Binding var viewData: ViewData
    let onDelete: () -> Void
    
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                TextField("", text: $viewData.text)
                    .font(.poppins(type: .regular, size: 15.0))
                    .foregroundColor(LKColors.xFEFEFE)
                    .padding(15.0)
                if viewData.text.isEmpty {
                    Text("Option")
                        .font(.poppins(type: .regular, size: 15.0))
                        .foregroundColor(LKColors.x7E7A9A)
                        .padding(16.0)
                        .allowsHitTesting(false)
                }
            }
            Spacer()
            Image(systemSymbol: .xmark)
                .foregroundColor(LKColors.xFEFEFE)
                .padding(20.0)
                .background(LKColors.x1C6EF2.opacity(0.1))
                .onTapGesture {
                    clearFocus()
                    onDelete()
                }
                
        }
        .frame(height: 51.0)
        .background(LKColors.x1C1A2A)
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
            viewData: .constant(.init(id: 1, text: "")),
            onDelete: { }
        )
    }
}
