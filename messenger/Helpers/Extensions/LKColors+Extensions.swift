import SwiftUI

// MARK: LKColors + getting random color

extension LKColors {
    
    private static let randomColors: [Color] = [
        LKColors.x03114398,
        LKColors.x6F1D7A81,
        LKColors.xAC1393,
        LKColors.x14131B,
        LKColors.x7E7A9A,
        LKColors.xFEFEFE,
        LKColors.x6F1D7A81
    ]
    
    static func makeRandomColor(int: Int) -> Color {
        Self.randomColors[Self.randomColors.count % int]
    }
}
