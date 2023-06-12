import SwiftUI

enum PoppinsFontType {
    case regular
    case bold
    case medium
    case semibold
    
    var name: String {
        switch self {
        case .regular:
            return "Poppins-Regular"
        case .bold:
            return "Poppins-Bold"
        case .medium:
            return "Poppins-Medium"
        case .semibold:
            return "Poppins-SemiBold"
        }
    }
}

extension Font {
    
    static func poppins(
        type: PoppinsFontType,
        size: CGFloat
    ) -> Font {
        custom(type.name, size: size)
    }
}
