import SwiftUI

@main
struct MessengerApp: App {
    
  var body: some Scene {
        WindowGroup {
            MessagesScreenView(
                viewModel: .init(
                    service: MockMessageService()
                )
            )
        }
    }
}
