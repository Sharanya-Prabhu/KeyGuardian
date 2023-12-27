import Foundation
import SwiftUI

struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color("buttonTextColor"))
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color("buttonColorStart"), Color("buttonColorEnd")]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(10.0)
    }
}
