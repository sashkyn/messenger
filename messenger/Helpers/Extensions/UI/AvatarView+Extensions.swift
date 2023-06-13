import Foundation

// MARK: AvatarView + init from User

extension AvatarView {
    
    init(user: User) {
        self.init(
            color: user.avatarColor,
            text: "\(user.fullName.prefix(1))"
        )
    }
}
