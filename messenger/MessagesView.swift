import SwiftUI

struct MessagesView: View {
    
    let service: MessageService = MockMessageService()

    var body: some View {
        List {
//            ForEach(data, id: \.self) { item in
//                TextMessageCell(item: item)
//            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}

// MARK: Message Cell

struct TextMessageCell: View {
    let item: String

    var body: some View {
        VStack {
            Text(item)
                .font(.headline)
                .foregroundColor(.blue)
                .padding()
            
            Divider()
        }
        .background(Color.white)
        .cornerRadius(10)
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
    }
}
