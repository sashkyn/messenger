import SwiftUI

@main
struct MessengerApp: App {
    
    var body: some Scene {
        WindowGroup {
            MessageListScreen(
                viewModel: .init(
                    service: MockMessageService()
                )
            )
        }
    }
    
    init() {
        setupAppBarStyle()
    }
    
    private func setupAppBarStyle() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = LKColors.x1C1A2A.toUIColor()
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
