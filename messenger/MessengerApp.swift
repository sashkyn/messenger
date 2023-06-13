import SwiftUI
import Factory

@main
struct MessengerApp: App {
    
    var body: some Scene {
        WindowGroup {
            MessageListScreen()
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

extension Container {
    
    var messageService: Factory<MessageService> {
        Factory(self) { MockMessageService() }.singleton
    }
}
