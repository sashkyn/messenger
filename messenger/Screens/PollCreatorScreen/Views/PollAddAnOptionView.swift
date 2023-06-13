import SwiftUI

struct PollAddAnOptionView: View {
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("Add an option")
                .font(.poppins(type: .regular, size: 15.0))
                .foregroundColor(LKColors.x1C6EF2)
                .padding(15.0)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(LKColors.x1C1A2A)
                .frame(height: 51.0)
        }
    }
    
    
}

struct PollAddAnOptionView_Previews: PreviewProvider {
    static var previews: some View {
        PollAddAnOptionView(action: { })
    }
}
