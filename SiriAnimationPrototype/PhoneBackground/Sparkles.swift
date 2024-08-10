import SwiftUI

struct Sparkles: View {
    let mesh = Gradient(colors: [.yellow, .purple, .indigo,])
    
    var body: some View {
        Image(systemName: "sparkles")
            .fontSize(40)
            .foregroundStyle(mesh)
            .breatheEffect()
    }
}

private struct BreathEffectModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 18, *) {
            content
                .symbolEffect(.breathe)
        } else {
            content
                .symbolEffect(.pulse)
        }
    }
}

private extension View {
    func breatheEffect() -> some View {
        modifier(BreathEffectModifier())
    }
}

#Preview {
    Sparkles()
}
