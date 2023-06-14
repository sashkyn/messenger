import SwiftUI

struct PollMessageOptionView: View {
    let option: PollOption
    let isSelected: Bool
    
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 16.0)
                    .foregroundColor(isSelected ? LKColors.x7E7A9A : LKColors.x1C6EF2.opacity(0.15))
                    .frame(height: 40.0)
                Text(option.text)
                    .font(.poppins(type: .regular, size: 12.0))
                    .foregroundColor(LKColors.xFEFEFE)
                    .padding(.leading, 16.0)
                    .padding(.trailing, 16.0)
            }
        }
    }
}
