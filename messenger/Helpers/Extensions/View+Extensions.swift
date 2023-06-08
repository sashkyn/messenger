import SwiftUI

// TODO: сделать конструируемый NavigationBar

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
                        Text(title).font(.body.bold())
                            .foregroundColor(LKColors.xFEFEFE)
                        Text(subtitle).font(.caption2)
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
                        Text(title).font(.body.bold())
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
