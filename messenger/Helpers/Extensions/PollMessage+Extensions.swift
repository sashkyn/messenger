import Foundation

extension PollMessage {
    
    func getSelectedOptionId(senderId: Int64) -> Int64? {
        content.userAnswers[senderId]
    }
}
