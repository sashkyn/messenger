import SwiftUI

// TODO: добавить белый бекграунд

struct MessageTextField: View {
    
    let text: Binding<String>
    let onPoll: () -> Void
    let onSend: () -> Void
    
    var body: some View {
        HStack {
            Button(action: { onPoll() }) {
                Image(systemName: "square.and.arrow.up")
                    .font(.title)
                    .padding(8.0)
            }
            TextField("Message", text: text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(
                action: {
                    onSend()
                }
            ) {
                Image(systemName: "square.and.arrow.up")
                    .font(.title)
                    .padding(8.0)
            }
        }
    }
}
