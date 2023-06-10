import SwiftUI

enum PoppinsFontType {
    case regular
    case bold
    
    var name: String {
        switch self {
        case .regular:
            return "Poppins-Regular"
        case .bold:
            return "Poppins-Bold"
        }
    }
}

extension Font {
    
    static func poppins(
        type: PoppinsFontType,
        size: CGFloat
    ) -> Font {
        .custom(type.name, size: size)
    }
}
