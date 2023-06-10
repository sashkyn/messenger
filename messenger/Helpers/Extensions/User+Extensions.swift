import SwiftUI

// MARK: User + FullName

extension User {
    
    var fullName: String {
        firstName + " " + lastName
    }
}

// MARK: User + Avatar color

extension User {
    
    var avatarColor: Color {
        LKColors.makeRandomColor(int: id)
    }
}
