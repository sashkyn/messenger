import SwiftUI

// MARK: LKColors + getting random color

extension LKColors {
    
    private static let randomColors: [Color] = [
        LKColors.x114398,
        LKColors.x1D7A81,
        LKColors.xAC1393,
        LKColors.x14131B,
        LKColors.x7E7A9A,
        LKColors.xFEFEFE,
        LKColors.x1D7A81
    ]
    
    static func makeRandomColor(int: Int64) -> Color {
        Self.randomColors[Self.randomColors.count % Int(int)]
    }
}
