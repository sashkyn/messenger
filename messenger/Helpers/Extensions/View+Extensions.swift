import SwiftUI

// TODO: сделать конструируемый NavigationBar

// MARK: View + AppBar

extension View {
    
    func messageListAppBar(
        title: String,
        subtitle: String,
        onClose: @escaping () -> Void
    ) -> some View {
        self
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar(content: {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text(title).font(.poppins(type: .bold, size: 16))
                            .foregroundColor(LKColors.xFEFEFE)
                        Text(subtitle).font(.poppins(type: .regular, size: 12))
                            .foregroundColor(LKColors.xFEFEFE)
                    }
                }
            })
            .navigationBarItems(
                leading: Button(
                    action: { onClose() },
                    label: {
                        Image(systemSymbol: .xmark)
                            .foregroundColor(LKColors.xFEFEFE)
                    }
                )
            )
    }
    
    func modalAppBar(
        title: String,
        trailingTitle: String,
        onTrailingAction: (() -> Void)?,
        onClose: @escaping () -> Void
    ) -> some View {
        self
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar(content: {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text(title).font(.poppins(type: .bold, size: 16))
                            .foregroundColor(LKColors.xFEFEFE)
                    }
                }
            })
            .navigationBarItems(
                leading: Button(
                    action: { onClose() },
                    label: {
                        Image(systemSymbol: .xmark)
                            .foregroundColor(LKColors.xFEFEFE)
                    }
                ),
                trailing: Button(
                    action: { onClose() },
                    label: {
                        Text(trailingTitle)
                            .foregroundColor(LKColors.xFEFEFE)
                    }
                ).disabled(onTrailingAction == nil)
            )
    }
}
